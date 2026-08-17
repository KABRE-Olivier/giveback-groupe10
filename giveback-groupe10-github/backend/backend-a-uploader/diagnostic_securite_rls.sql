-- =========================================================
-- DIAGNOSTIC SÉCURITÉ — à exécuter et à garder comme preuve
-- pour la prochaine présentation (point 3 du retour n°2).
-- =========================================================

-- 1. Vérifie que la Row Level Security est bien ACTIVÉE sur chaque table
-- (rowsecurity = true attendu partout)
select
  tablename,
  rowsecurity as rls_active
from pg_tables
where schemaname = 'public'
order by tablename;

-- 2. Liste toutes les politiques de sécurité en place, table par table
-- (permet de vérifier qu'il y a bien une politique par table, pas d'oubli)
select
  tablename,
  policyname,
  cmd as operation,
  qual as condition
from pg_policies
where schemaname = 'public'
order by tablename, policyname;

-- 3. Détecte les tables SANS aucune politique (risque : soit tout
-- bloqué, soit RLS pas vraiment appliquée selon le cas)
select tablename
from pg_tables t
where schemaname = 'public'
and not exists (
  select 1 from pg_policies p
  where p.schemaname = 'public' and p.tablename = t.tablename
);
