-- =========================================================
-- Met à jour la fonction automatique de création de profil
-- pour enregistrer aussi la nationalité.
-- =========================================================

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, prenom, statut, tags, annee_naissance, nationalite, pays, ville)
  values (
    new.id,
    new.raw_user_meta_data->>'prenom',
    new.raw_user_meta_data->>'statut',
    coalesce(
      (select array(select jsonb_array_elements_text(new.raw_user_meta_data->'tags'))),
      '{}'
    ),
    nullif(new.raw_user_meta_data->>'annee_naissance', '')::integer,
    new.raw_user_meta_data->>'nationalite',
    new.raw_user_meta_data->>'pays',
    new.raw_user_meta_data->>'ville'
  );
  return new;
end;
$$ language plpgsql security definer;
