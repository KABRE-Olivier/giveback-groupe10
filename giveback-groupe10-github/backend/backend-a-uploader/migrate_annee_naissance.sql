-- =========================================================
-- Réponse au retour du jury sur la confidentialité :
-- on ne collecte plus la date de naissance complète (jour/mois/année),
-- seulement l'ANNÉE — suffisant pour vérifier les conditions d'âge
-- des bourses, mais beaucoup moins précis/identifiant.
-- =========================================================

alter table profiles add column if not exists annee_naissance integer;

-- Migre les données déjà collectées (extrait juste l'année)
update profiles
set annee_naissance = extract(year from date_naissance)::integer
where date_naissance is not null and annee_naissance is null;

-- La date complète n'est plus utilisée par le site à partir de
-- maintenant. On la vide pour ne plus la conserver inutilement.
update profiles set date_naissance = null;
