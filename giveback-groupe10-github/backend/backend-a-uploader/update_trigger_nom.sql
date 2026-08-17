-- =========================================================
-- Met à jour le trigger de création automatique de profil
-- pour qu'il copie aussi le champ "nom" (nouvellement ajouté
-- au formulaire d'inscription), en plus du prénom.
-- =========================================================

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, prenom, nom, statut, tags)
  values (
    new.id,
    new.raw_user_meta_data->>'prenom',
    new.raw_user_meta_data->>'nom',
    new.raw_user_meta_data->>'statut',
    coalesce(
      (select array(select jsonb_array_elements_text(new.raw_user_meta_data->'tags'))),
      '{}'
    )
  );
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
