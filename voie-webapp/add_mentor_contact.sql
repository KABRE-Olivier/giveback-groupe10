-- =========================================================
-- Ajoute une adresse de contact pour chaque mentor,
-- affichée sous forme de lien "Contacter directement".
-- =========================================================

alter table mentors add column if not exists contact text;

-- Renseigne des contacts d'exemple (emails à 2iE pour les membres de l'équipe).
-- ⚠️ Remplace par les vraies adresses que chacun accepte de partager publiquement.
update mentors set contact = 'landry.lekeufack@2ie-edu.org' where nom = 'Morelle Moffo';
update mentors set contact = 'nininahazwebelys@gmail.com' where nom = 'Belyse Nininahazwe';
update mentors set contact = 'olivierkabre303@gmail.com' where nom = 'Kabre Olivier';
update mentors set contact = 'danielle.okei@2ie-edu.org' where nom = 'OKEI Danielle Ange';
update mentors set contact = 'garcialaurette88@gmail.com' where nom = 'Sawa Anne Laurette Kissi';
update mentors set contact = 'dongoyvan7777@gmail.com' where nom = 'Ivan NDONGO';
-- Les mentors fictifs externes n'ont pas d'adresse réelle : pas de contact affiché pour eux.
