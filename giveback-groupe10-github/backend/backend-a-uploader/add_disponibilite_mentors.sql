-- =========================================================
-- Champ de disponibilité pour les mentors (1 à 5, 5 = le plus
-- disponible). Sert de critère de tri par défaut. Jamais
-- affiché publiquement sur la plateforme — c'est un critère
-- de classement interne, pas une donnée exposée.
-- =========================================================

alter table mentors add column if not exists disponibilite smallint default 3;
alter table mentors add column if not exists photo_url text;

-- ⚠️ À AJUSTER PAR VOUS-MÊME, honnêtement, pour chaque mentor
-- (1 = peu disponible en ce moment, 5 = très disponible / répond vite)
-- Exemple ci-dessous à corriger selon la réalité de chacun :

-- update mentors set disponibilite = 5 where nom ilike '%Kabre Olivier%';
-- update mentors set disponibilite = 4 where nom ilike '%Augustin Houngue%';
-- update mentors set disponibilite = 3 where nom ilike '%...%';
-- (répétez pour chacun des 9 mentors)

select id, nom, disponibilite from mentors order by disponibilite desc, nom;
