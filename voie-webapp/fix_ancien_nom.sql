-- =========================================================
-- Corrige l'ancien nom "Voie" en "Giveback Groupe 10"
-- dans les bios des mentors (et messages de la communauté).
-- =========================================================

update mentors
set bio = replace(bio, 'équipe Voie', 'équipe Giveback Groupe 10')
where bio like '%équipe Voie%';

update posts
set contenu = replace(contenu, 'communauté Voie', 'communauté Giveback Groupe 10')
where contenu like '%communauté Voie%';
