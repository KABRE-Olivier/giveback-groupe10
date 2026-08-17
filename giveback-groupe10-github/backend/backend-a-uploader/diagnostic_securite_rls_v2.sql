-- =========================================================
-- DIAGNOSTIC SÉCURITÉ (version corrigée) — inclut la
-- condition WITH CHECK, utilisée pour les insertions.
-- =========================================================

-- 1. RLS activée sur chaque table ? (attendu : true partout)
select tablename, rowsecurity as rls_active
from pg_tables
where schemaname = 'public'
order by tablename;

-- 2. Toutes les politiques, avec la condition complète (lecture ET écriture)
select
  tablename,
  policyname,
  cmd as operation,
  qual as condition_lecture,
  with_check as condition_ecriture
from pg_policies
where schemaname = 'public'
order by tablename, policyname;

-- 3. Tables sans AUCUNE politique (à corriger en priorité si le résultat n'est pas vide)
select tablename
from pg_tables t
where schemaname = 'public'
and not exists (
  select 1 from pg_policies p
  where p.schemaname = 'public' and p.tablename = t.tablename
);
