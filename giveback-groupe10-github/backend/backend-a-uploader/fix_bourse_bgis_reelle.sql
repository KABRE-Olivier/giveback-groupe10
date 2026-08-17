-- =========================================================
-- Corrige la bourse 2iE-BGIS avec les vrais critères
-- d'éligibilité détaillés (source : Youth Media).
-- Ajoute aussi une limite d'âge exploitable pour le matching.
-- =========================================================

alter table opportunities add column if not exists age_max integer;

update opportunities
set description = 'Bachelor en Gestion des Infrastructures et Services (Eau, Énergie, Génie civil), Bac+3, 100% en ligne (12 mois + 6 mois intensifs anglais/entrepreneuriat), à 2iE Ouagadougou. Réservé aux jeunes filles/femmes, personnes en situation de handicap, réfugié(e)s, déplacé(e)s internes ou orphelin(e)s, ressortissants d''un pays francophone d''Afrique subsaharienne, titulaires d''un Bac+2 en génie civil/énergie/eau/assainissement. Moins de 25 ans (27 ans pour les personnes en situation de handicap).',
    tags = '{etudiant,handicap,orphelin,famille-modeste}',
    age_max = 27
where title = 'Bourse Fondation Mastercard — 2iE (Bachelor BGIS)';
