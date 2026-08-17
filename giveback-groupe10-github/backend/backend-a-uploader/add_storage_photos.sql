-- =========================================================
-- Espace de stockage pour les photos de profil (utilisateurs
-- et mentors). À exécuter une fois.
-- =========================================================

insert into storage.buckets (id, name, public)
values ('photos-profil', 'photos-profil', true)
on conflict (id) do nothing;

-- Tout le monde peut voir les photos (public, nécessaire pour l'affichage)
drop policy if exists "Lecture publique des photos" on storage.objects;
create policy "Lecture publique des photos"
  on storage.objects for select
  using (bucket_id = 'photos-profil');

-- Seuls les utilisateurs connectés peuvent uploader une photo
drop policy if exists "Utilisateurs connectés peuvent uploader" on storage.objects;
create policy "Utilisateurs connectés peuvent uploader"
  on storage.objects for insert
  with check (bucket_id = 'photos-profil' and auth.role() = 'authenticated');

-- Un utilisateur peut remplacer/supprimer uniquement ses propres photos
-- (fichiers nommés avec son user_id en préfixe, ex: "abc123-timestamp.jpg")
drop policy if exists "Utilisateurs gèrent leurs propres photos" on storage.objects;
create policy "Utilisateurs gèrent leurs propres photos"
  on storage.objects for update
  using (bucket_id = 'photos-profil' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "Utilisateurs suppriment leurs propres photos" on storage.objects;
create policy "Utilisateurs suppriment leurs propres photos"
  on storage.objects for delete
  using (bucket_id = 'photos-profil' and (storage.foldername(name))[1] = auth.uid()::text);
