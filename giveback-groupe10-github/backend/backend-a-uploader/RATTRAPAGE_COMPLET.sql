-- Fichier combiné
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
-- =========================================================
-- Met à jour la fonction automatique de création de profil
-- pour utiliser l'année de naissance (pas la date complète).
-- =========================================================

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, prenom, statut, tags, annee_naissance, pays, ville)
  values (
    new.id,
    new.raw_user_meta_data->>'prenom',
    new.raw_user_meta_data->>'statut',
    coalesce(
      (select array(select jsonb_array_elements_text(new.raw_user_meta_data->'tags'))),
      '{}'
    ),
    nullif(new.raw_user_meta_data->>'annee_naissance', '')::integer,
    new.raw_user_meta_data->>'pays',
    new.raw_user_meta_data->>'ville'
  );
  return new;
end;
$$ language plpgsql security definer;
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
