alter table profiles add column if not exists date_naissance date;
alter table profiles add column if not exists pays text;
alter table profiles add column if not exists ville text;

alter table posts add column if not exists auteur_pays text;
alter table posts add column if not exists auteur_ville text;
