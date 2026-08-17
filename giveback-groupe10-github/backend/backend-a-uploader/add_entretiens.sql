-- =========================================================
-- Table des entretiens terrain (diagnostic, point 2 du retour)
-- =========================================================

create table if not exists entretiens (
  id bigint generated always as identity primary key,
  interviewer text not null,           -- membre de l'équipe qui a mené l'entretien
  interviewee_code text not null,      -- code anonyme, ex: 'E01'
  identite_reelle text,                -- privé, preuve interne uniquement
  pays text,
  reponses text not null,              -- résumé des réponses aux questions du diagnostic
  type_preuve text,                    -- 'photo' | 'capture_echange' | 'google_form' | 'autre'
  preuve_fichier text,                 -- chemin du fichier si photo/capture uploadée
  created_at timestamp default now()
);

alter table entretiens enable row level security;

drop policy if exists "Lecture équipe" on entretiens;
create policy "Lecture équipe"
  on entretiens for select using (true);

drop policy if exists "Écriture équipe" on entretiens;
create policy "Écriture équipe"
  on entretiens for insert with check (true);

-- Verrou : identité réelle jamais lisible via l'API, même connecté
revoke select (identite_reelle) on entretiens from authenticated, anon;

-- =========================================================
-- Espace de stockage privé pour les preuves d'entretien
-- (photo avec la personne, capture d'échange...)
-- =========================================================

insert into storage.buckets (id, name, public)
values ('preuves-entretiens', 'preuves-entretiens', false)
on conflict (id) do nothing;

drop policy if exists "Connectés peuvent déposer une preuve entretien" on storage.objects;
create policy "Connectés peuvent déposer une preuve entretien"
  on storage.objects for insert
  with check (bucket_id = 'preuves-entretiens' and auth.role() = 'authenticated');

-- Permet de générer des liens temporaires sécurisés (utilisé par l'admin
-- pour montrer les preuves — les chemins de fichiers restent imprévisibles,
-- donc pas de risque réel d'accès par un tiers)
drop policy if exists "Connectés peuvent lire pour lien temporaire (entretiens)" on storage.objects;
create policy "Connectés peuvent lire pour lien temporaire (entretiens)"
  on storage.objects for select
  using (bucket_id = 'preuves-entretiens' and auth.role() = 'authenticated');

-- Vérification
select count(*) as total_entretiens from entretiens;
