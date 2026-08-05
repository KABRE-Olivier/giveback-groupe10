-- =========================================================
-- Crée un statut "administrateur" et autorise ce statut
-- à consulter l'ensemble des données (profils, candidatures,
-- demandes de mentorat) pour le tableau de bord.
-- =========================================================

create table admins (
  user_id uuid references auth.users primary key,
  created_at timestamp default now()
);

alter table admins enable row level security;

create policy "Un admin peut voir la liste des admins"
  on admins for select
  using (exists (select 1 from admins a where a.user_id = auth.uid()));

-- Autorise les administrateurs à voir TOUS les profils
create policy "Admin peut voir tous les profils"
  on profiles for select
  using (exists (select 1 from admins where user_id = auth.uid()));

-- Autorise les administrateurs à voir TOUTES les candidatures
create policy "Admin peut voir toutes les candidatures"
  on applications for select
  using (exists (select 1 from admins where user_id = auth.uid()));

-- Autorise les administrateurs à voir TOUTES les demandes de mentorat
create policy "Admin peut voir toutes les demandes de mentorat"
  on mentor_requests for select
  using (exists (select 1 from admins where user_id = auth.uid()));

-- =========================================================
-- ÉTAPE SUIVANTE (à faire manuellement) :
-- 1. Trouve ton identifiant utilisateur avec la requête ci-dessous
--    (remplace l'email par celui de ton compte de test actuel) :
--
--    select id, email from auth.users where email = 'TON_EMAIL_ICI';
--
-- 2. Copie l'identifiant (id) affiché, puis exécute :
--
--    insert into admins (user_id) values ('COLLE_TON_ID_ICI');
-- =========================================================
