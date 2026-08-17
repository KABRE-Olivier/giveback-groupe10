-- =========================================================
-- Ajoute le logo 2iE (affiché sur les opportunités partenaires 2iE)
-- =========================================================

alter table opportunities add column if not exists logo_url text;

update opportunities set logo_url = 'https://i.postimg.cc/fTZY3tjb/LOGO-2i-E-GOOD.webp'
where partenaire = '2iE';
