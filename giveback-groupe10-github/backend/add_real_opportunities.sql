alter table opportunities add column if not exists lien text;

insert into opportunities (type, title, description, deadline, tags, lien) values
('Bourse', 'Bourse Fondation Mastercard — 2iE (Bachelor BGIS)',
 'Programme FILE-IN AFRICA : 100 bourses pour le Bachelor Gestion des Infrastructures et Services à 2iE (Ouagadougou), pour les jeunes de milieux défavorisés d''Afrique subsaharienne francophone.',
 '2026-08-31', '{bachelier,famille-modeste}',
 'https://www.2ie-edu.org/2ie-mastercard/'),
('Bourse', 'Bourse Fondation Mastercard — University of Global Health Equity (Rwanda)',
 'Programme de bourses de Master en santé mondiale et éducation aux professions de santé, à l''University of Global Health Equity au Rwanda, pour jeunes africains.',
 null, '{etudiant}',
 'https://ughe.org/mastercard-foundation-scholars-program-at-the-university-of-global-health-equity/'),
('Bourse', 'Bourse Fondation Mastercard — University of Pretoria (Afrique du Sud)',
 'Bourses de licence et de master (Honours/Masters) avec accompagnement complet, pour jeunes africains talentueux confrontés à des barrières économiques ou sociales, y compris personnes en situation de handicap et déplacés.',
 null, '{bachelier,etudiant,handicap}',
 'https://www.up.ac.za/mastercard-foundation-scholars-program'),
('Bourse', 'Bourse Fondation Mastercard — Sciences Po (France)',
 'Programme de bourses pour jeunes africains à fort potentiel de leadership, avec priorité aux personnes réfugiées, déplacées, en situation de handicap ou issues de zones rurales isolées.',
 null, '{etudiant,handicap,orphelin}',
 'https://www.sciencespo.fr/students/fr/financer/bourses-aides-financieres/bourses-mastercard-foundation/'),
('Bourse', 'Programme de Bourses Fondation Mastercard — toutes universités partenaires',
 'Page officielle listant l''ensemble des universités et ONG partenaires du Mastercard Foundation Scholars Program à travers l''Afrique et au-delà, avec leurs modalités de candidature propres.',
 null, '{bachelier,etudiant}',
 'https://mastercardfdn.org/fr/what-we-do/our-programs/mastercard-foundation-scholars-program/where-to-apply/');
