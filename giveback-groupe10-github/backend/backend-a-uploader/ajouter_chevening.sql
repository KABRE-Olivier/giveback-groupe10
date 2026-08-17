-- =========================================================
-- Ajoute la bourse Chevening (Royaume-Uni), vérifiée le
-- 13 août 2026, candidatures ouvertes jusqu'au 6 octobre 2026.
-- Diversifie le catalogue au-delà de Mastercard Foundation/2iE,
-- comme demandé par la coordination (point 4 du retour n°2).
-- =========================================================

insert into opportunities (type, title, description, deadline, tags, lien, partenaire, financement, pays_cible) values

('Bourse', 'Bourse Chevening — Master au Royaume-Uni',
 'Bourse phare du gouvernement britannique (Foreign, Commonwealth and Development Office) pour un master d''un an dans n''importe quelle université du Royaume-Uni, tous domaines confondus. Entièrement financée : frais de scolarité, billets d''avion, visa, allocation mensuelle. Plus de 160 pays éligibles. Exige au moins 2 800 heures d''expérience professionnelle (environ 2 ans, stages inclus) et un diplôme universitaire équivalent à une licence. Engagement à revenir dans son pays au moins 2 ans après la bourse.',
 '2026-10-06', '{etudiant}',
 'https://www.chevening.org/apply/', 'Gouvernement britannique (FCDO)', 'Entièrement financée', 'Afrique');
