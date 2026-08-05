delete from posts where auteur_prenom in ('Équipe Voie', 'Équipe Giveback Groupe 10');

alter table likes add column if not exists type text default 'coeur';
