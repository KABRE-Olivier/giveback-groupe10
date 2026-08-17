-- =========================================================
-- Ajoute un badge partenaire pour les opportunités,
-- et une photo de profil optionnelle pour les mentors.
-- =========================================================

alter table opportunities add column if not exists partenaire text;
alter table mentors add column if not exists photo_url text;

-- Badge partenaire sur les opportunités Mastercard Foundation / 2iE
update opportunities set partenaire = 'Mastercard Foundation'
where title like '%Mastercard%' or title like '%Fondation%';

update opportunities set partenaire = '2iE'
where title like '%2iE%';

update opportunities set partenaire = 'FAO'
where title like '%FAO%';

update opportunities set partenaire = 'Union Africaine'
where title like '%Union Africaine%';
