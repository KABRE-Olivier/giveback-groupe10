-- =========================================================
-- Ajoute un numéro WhatsApp pour chaque mentor.
-- Format : indicatif pays + numéro, SANS le "+", sans espace,
-- sans le 0 initial après l'indicatif (ex: 22657997906).
-- =========================================================

alter table mentors add column if not exists whatsapp text;

-- Numéros repris de la liste officielle de l'équipe.
-- ⚠️ À confirmer avec chacun avant toute publication publique.
update mentors set whatsapp = '237682453324' where nom = 'Morelle Moffo';
update mentors set whatsapp = '22657997906' where nom = 'Kabre Olivier';
update mentors set whatsapp = '22656172960' where nom = 'OKEI Danielle Ange';
update mentors set whatsapp = '225706024357' where nom = 'Sawa Anne Laurette Kissi';
update mentors set whatsapp = '212721283647' where nom = 'Ivan NDONGO';
-- Belyse : numéro trop court dans la liste d'origine (+257 152794),
-- à faire confirmer directement avec elle avant de l'ajouter.
