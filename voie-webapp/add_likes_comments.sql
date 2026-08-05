-- =========================================================
-- Ajoute les likes et les commentaires sur les publications
-- de la communauté.
-- =========================================================

create table likes (
  id bigint generated always as identity primary key,
  post_id bigint references posts on delete cascade,
  user_id uuid references auth.users on delete cascade,
  created_at timestamp default now(),
  unique (post_id, user_id)
);

alter table likes enable row level security;

create policy "Tout le monde peut voir les likes"
  on likes for select using (true);

create policy "Un utilisateur gère ses propres likes"
  on likes for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create table comments (
  id bigint generated always as identity primary key,
  post_id bigint references posts on delete cascade,
  user_id uuid references auth.users on delete cascade,
  auteur_prenom text,
  contenu text,
  created_at timestamp default now()
);

alter table comments enable row level security;

create policy "Tout le monde peut voir les commentaires"
  on comments for select using (true);

create policy "Un utilisateur publie ses propres commentaires"
  on comments for insert with check (auth.uid() = user_id);
