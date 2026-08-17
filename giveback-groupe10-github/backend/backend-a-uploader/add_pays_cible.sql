-- =========================================================
-- Ajoute la zone géographique de chaque opportunité, pour
-- que le pays/ville de l'utilisateur influence vraiment
-- ses recommandations (pas juste un affichage communauté).
-- =========================================================

alter table opportunities add column if not exists pays_cible text;

-- Bourses Mastercard Foundation : éligibilité régionale, pas un seul pays
update opportunities set pays_cible = 'Afrique subsaharienne francophone'
where partenaire like 'Mastercard Foundation%';

-- Stages internationaux : ouverts à toute l'Afrique
update opportunities set pays_cible = 'Afrique'
where title like '%FAO%' or title like '%Union Africaine%';

-- Offre d'emploi réellement locale
update opportunities set pays_cible = 'Burkina Faso'
where title like '%Secteur Eau et Environnement (Burkina Faso)%';
