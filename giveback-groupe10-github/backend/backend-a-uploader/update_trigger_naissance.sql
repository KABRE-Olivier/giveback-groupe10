-- =========================================================
-- Met à jour la fonction automatique de création de profil
-- pour qu'elle enregistre aussi date de naissance, pays et ville.
-- =========================================================

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, prenom, statut, tags, date_naissance, pays, ville)
  values (
    new.id,
    new.raw_user_meta_data->>'prenom',
    new.raw_user_meta_data->>'statut',
    coalesce(
      (select array(select jsonb_array_elements_text(new.raw_user_meta_data->'tags'))),
      '{}'
    ),
    nullif(new.raw_user_meta_data->>'date_naissance', '')::date,
    new.raw_user_meta_data->>'pays',
    new.raw_user_meta_data->>'ville'
  );
  return new;
end;
$$ language plpgsql security definer;
