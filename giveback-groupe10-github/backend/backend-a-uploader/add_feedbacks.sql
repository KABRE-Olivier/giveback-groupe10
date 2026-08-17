-- =========================================================
-- Table de collecte des retours des testeurs — sert de
-- preuve horodatée pour le diagnostic terrain ET le test
-- de la plateforme (points 1 et 2 du complément du 12 août).
-- =========================================================

create table feedbacks (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  auteur_prenom text,
  note_facilite integer,          -- 1 à 5
  opportunites_pertinentes text,   -- 'oui' / 'plutot' / 'non'
  fonctionnalite_utile text,       -- espace perso / mentorat / mini-formations / communauté / recherche
  difficulte text,
  amelioration text,
  recommande boolean,
  recommande_pourquoi text,
  comment_trouve text,             -- comment la personne a connu la plateforme
  created_at timestamp default now()
);

alter table feedbacks enable row level security;

create policy "Un utilisateur voit tous les retours"
  on feedbacks for select using (true);

create policy "Un utilisateur publie son propre retour"
  on feedbacks for insert with check (auth.uid() = user_id);

create policy "Un utilisateur modifie son propre retour"
  on feedbacks for update using (auth.uid() = user_id);
