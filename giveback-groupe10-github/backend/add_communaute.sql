create table posts (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  auteur_prenom text,
  contenu text,
  created_at timestamp default now()
);

alter table posts enable row level security;

create policy "Tout le monde peut lire les publications"
  on posts for select using (true);

create policy "Un utilisateur publie ses propres messages"
  on posts for insert with check (auth.uid() = user_id);

insert into posts (user_id, auteur_prenom, contenu)
select id, 'Équipe Voie', 'Bienvenue sur la communauté Voie ! Partagez ici vos questions, vos expériences de candidature, et vos encouragements. 🌱'
from auth.users limit 1;
