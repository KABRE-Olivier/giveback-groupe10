-- =========================================================
-- Suivi de l'usage des outils CV / lettre de motivation
-- (téléchargements de modèles + générations CV/lettre)
-- =========================================================

create table if not exists outils_usage (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete set null,
  type text not null,  -- 'modele_centrale_2ie' | 'modele_emih_eree_bgis' | 'cv_genere' | 'lettre_generee'
  created_at timestamp default now()
);

alter table outils_usage enable row level security;

drop policy if exists "Tout le monde peut enregistrer un usage" on outils_usage;
create policy "Tout le monde peut enregistrer un usage"
  on outils_usage for insert with check (true);

drop policy if exists "Lecture équipe" on outils_usage;
create policy "Lecture équipe"
  on outils_usage for select using (true);

-- =========================================================
-- Requête pour consulter les chiffres (à relancer quand vous
-- voulez, ex: pour le rapport)
-- =========================================================
-- select type, count(*) as nb from outils_usage group by type;
