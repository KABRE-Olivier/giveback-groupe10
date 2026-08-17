select tablename, rowsecurity as rls_active
from pg_tables
where schemaname = 'public'
order by tablename;
