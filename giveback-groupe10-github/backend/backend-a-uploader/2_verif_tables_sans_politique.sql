select tablename
from pg_tables t
where schemaname = 'public'
and not exists (
  select 1 from pg_policies p
  where p.schemaname = 'public' and p.tablename = t.tablename
);
