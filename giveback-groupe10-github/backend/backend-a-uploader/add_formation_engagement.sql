-- =========================================================
-- Ajoute les likes et commentaires sur les mini-formations,
-- pour savoir quelles vidéos aident vraiment les utilisateurs.
-- =========================================================

create table formation_likes (
  id bigint generated always as identity primary key,
  formation_id bigint references formations on delete cascade,
  user_id uuid references auth.users on delete cascade,
  created_at timestamp default now(),
  unique (formation_id, user_id)
);

alter table formation_likes enable row level security;

create policy "Tout le monde peut voir les likes formations"
  on formation_likes for select using (true);

create policy "Un utilisateur gère ses propres likes formations"
  on formation_likes for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create table formation_comments (
  id bigint generated always as identity primary key,
  formation_id bigint references formations on delete cascade,
  user_id uuid references auth.users on delete cascade,
  auteur_prenom text,
  contenu text,
  created_at timestamp default now()
);

alter table formation_comments enable row level security;

create policy "Tout le monde peut voir les commentaires formations"
  on formation_comments for select using (true);

create policy "Un utilisateur publie ses propres commentaires formations"
  on formation_comments for insert with check (auth.uid() = user_id);
