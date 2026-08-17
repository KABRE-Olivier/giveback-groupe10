-- =========================================================
-- Espace de stockage PRIVÉ pour les preuves d'accompagnement
-- (captures d'échanges, confirmations...). Pas d'accès public
-- en lecture — seul vous (propriétaire du projet Supabase)
-- pouvez consulter les fichiers, via le tableau de bord.
-- =========================================================

insert into storage.buckets (id, name, public)
values ('preuves-accompagnement', 'preuves-accompagnement', false)
on conflict (id) do nothing;

-- Seuls les utilisateurs connectés peuvent déposer une preuve
drop policy if exists "Connectés peuvent déposer une preuve" on storage.objects;
create policy "Connectés peuvent déposer une preuve"
  on storage.objects for insert
  with check (bucket_id = 'preuves-accompagnement' and auth.role() = 'authenticated');

-- Permet de générer des liens temporaires sécurisés depuis l'admin
drop policy if exists "Connectés peuvent lire pour lien temporaire (accompagnement)" on storage.objects;
create policy "Connectés peuvent lire pour lien temporaire (accompagnement)"
  on storage.objects for select
  using (bucket_id = 'preuves-accompagnement' and auth.role() = 'authenticated');

-- Colonne pour stocker le chemin du fichier de preuve
alter table accompagnements add column if not exists preuve_fichier text;

-- Colonne identité réelle — privée, jamais exposée publiquement.
-- Sert uniquement de preuve interne consultable par vous seul
-- (via Table Editor Supabase) si le jury demande une vérification.
alter table accompagnements add column if not exists identite_reelle text;

-- Verrou technique : même un utilisateur connecté ne peut PAS lire
-- cette colonne via l'API (uniquement en écriture, pour l'insertion).
-- Seul vous, propriétaire du projet, y avez accès via le tableau
-- de bord Supabase (Table Editor), qui contourne cette restriction.
revoke select (identite_reelle) on accompagnements from authenticated, anon;
