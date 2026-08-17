-- =========================================================
-- Ajoute la bourse McCall MacBain (McGill, Canada), vérifiée
-- le 13 août 2026. ⚠️ Date limite internationale très proche :
-- 19 août 2026, à afficher en priorité aux utilisateurs.
-- =========================================================

insert into opportunities (type, title, description, deadline, tags, lien, partenaire, financement, pays_cible) values

('Bourse', 'Bourse McCall MacBain — Master à l''Université McGill (Canada)',
 '⚠️ Candidature urgente. Bourse complète de master (jusqu''à 30 places/an, dont 10 pour candidats internationaux) à l''Université McGill (Montréal), couvrant frais de scolarité, logement et mentorat en leadership. Ouverte aux étudiants en dernière année de licence ou diplômés depuis moins de 5 ans. Sélection sur le caractère, l''engagement communautaire, le potentiel de leadership et l''esprit entrepreneurial — pas seulement les notes.',
 '2026-08-19', '{bachelier,etudiant}',
 'https://apply.mccallmacbainscholars.org/apply/', 'McCall MacBain Scholarships', 'Entièrement financée', 'Afrique');
