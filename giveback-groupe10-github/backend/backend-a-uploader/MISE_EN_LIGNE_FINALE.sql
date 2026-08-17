-- =========================================================
-- SCRIPT DE RATTRAPAGE FINAL — regroupe tout ce qui reste
-- en attente depuis le retour du jury. Sûr à exécuter même
-- si une partie a déjà été faite (rien ne sera dupliqué/cassé).
-- =========================================================

-- 1. Année de naissance (au lieu de la date complète)
alter table profiles add column if not exists annee_naissance integer;
update profiles
set annee_naissance = extract(year from date_naissance)::integer
where date_naissance is not null and annee_naissance is null;
update profiles set date_naissance = null;

-- 2. Nationalité (séparée du pays de résidence)
alter table profiles add column if not exists nationalite text;

-- 3. Trigger de création automatique de profil (version finale)
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

-- 4. Zone géographique cible des opportunités
alter table opportunities add column if not exists pays_cible text;
update opportunities set pays_cible = 'Afrique subsaharienne francophone'
where partenaire like 'Mastercard Foundation%';
update opportunities set pays_cible = 'Afrique'
where title like '%FAO%' or title like '%Union Africaine%';
update opportunities set pays_cible = 'Burkina Faso'
where title like '%Secteur Eau et Environnement (Burkina Faso)%';

-- 5. Table des retours/feedback des testeurs (preuve terrain)
create table if not exists feedbacks (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  auteur_prenom text,
  note_facilite integer,
  opportunites_pertinentes text,
  fonctionnalite_utile text,
  difficulte text,
  amelioration text,
  recommande boolean,
  recommande_pourquoi text,
  comment_trouve text,
  created_at timestamp default now()
);
alter table feedbacks enable row level security;

drop policy if exists "Un utilisateur voit tous les retours" on feedbacks;
create policy "Un utilisateur voit tous les retours"
  on feedbacks for select using (true);

drop policy if exists "Un utilisateur publie son propre retour" on feedbacks;
create policy "Un utilisateur publie son propre retour"
  on feedbacks for insert with check (auth.uid() = user_id);

drop policy if exists "Un utilisateur modifie son propre retour" on feedbacks;
create policy "Un utilisateur modifie son propre retour"
  on feedbacks for update using (auth.uid() = user_id);

-- 6. Numéros WhatsApp reconfirmés
update mentors set whatsapp = '225706024357' where nom = 'Sawa Anne Laurette Kissi';
update mentors set whatsapp = '229152129454' where nom = 'Emmanuella Justine Délali Ahomadegbe Tometin';
update mentors set whatsapp = '225789072240' where nom = 'Konan Adjoua Laetitia';

-- Vérification finale
select 'profiles avec annee_naissance' as info, count(*) from profiles where annee_naissance is not null
union all
select 'opportunities avec pays_cible', count(*) from opportunities where pays_cible is not null
union all
select 'table feedbacks existe', count(*) from feedbacks;
