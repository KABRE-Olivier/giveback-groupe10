-- =========================================================
-- Ajoute la date de naissance et la localisation (pays/ville)
-- aux profils utilisateurs.
-- =========================================================

alter table profiles add column if not exists date_naissance date;
alter table profiles add column if not exists pays text;
alter table profiles add column if not exists ville text;

-- La confidentialité empêche un utilisateur de voir le profil complet
-- des autres, donc on enregistre pays/ville directement sur chaque
-- publication pour que la communauté puisse afficher la localisation.
alter table posts add column if not exists auteur_pays text;
alter table posts add column if not exists auteur_ville text;
