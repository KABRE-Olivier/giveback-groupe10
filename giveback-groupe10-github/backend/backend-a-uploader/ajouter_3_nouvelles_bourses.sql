-- =========================================================
-- Ajoute trois nouvelles bourses réelles, vérifiées le
-- 11 août 2026, toutes encore ouvertes à cette date.
-- =========================================================

-- Sécurité : crée les colonnes si elles n'existent pas encore
alter table opportunities add column if not exists financement text;
alter table opportunities add column if not exists pays_cible text;

insert into opportunities (type, title, description, deadline, tags, lien, partenaire, financement, pays_cible) values

('Bourse', 'Bourse Fondation Mastercard — UAC (Bénin, Licence)',
 'Bourse complète (scolarité, subsistance, logement, matériel, assurance maladie) pour les nouveaux bacheliers du Bénin et de la sous-région, destinée aux étudiants à fort potentiel issus de milieux modestes. Filières : agronomie, numérique, production animale et végétale, médecine humaine, énergie renouvelable, finance et comptabilité.',
 '2026-08-31', '{bachelier,famille-modeste}',
 'https://fondationmastercard-uac.org/fr', 'Mastercard Foundation', 'Entièrement financée', 'Bénin'),

('Bourse', 'Bourse Ashinaga Africa Initiative — orphelins',
 'Bourse complète pour jeunes orphelins (un ou deux parents décédés) d''Afrique subsaharienne francophone et lusophone, brillants et engagés, pour des études universitaires à l''étranger. Comprend deux programmes préparatoires (académique et leadership) d''un an avant l''entrée à l''université, avec mentorat et accompagnement au retour en Afrique après le diplôme.',
 null, '{bachelier,orphelin}',
 'https://en.ashinaga.org/candidatures/?lang=fr', 'Ashinaga', 'Entièrement financée', 'Afrique subsaharienne francophone'),

('Bourse', 'Bourse d''Excellence UEMOA — Licence, Master, Doctorat',
 'Programme de bourses d''excellence de la Commission de l''UEMOA : 10 étudiants sélectionnés par État membre pour une formation de niveau Licence, Master, Doctorat ou spécialisation postdoctorale en santé humaine. Couvre les frais académiques et de subsistance. Pour la Licence : bac 2026 avec moyenne minimale de 14/20, moins de 21 ans.',
 '2026-08-30', '{bachelier,etudiant}',
 'http://www.uemoa.int', 'UEMOA', 'Entièrement financée', 'Bénin, Burkina Faso, Côte d''Ivoire, Guinée-Bissau, Mali, Niger, Sénégal, Togo');
