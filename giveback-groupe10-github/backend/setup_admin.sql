create table admins (
  user_id uuid references auth.users primary key,
  created_at timestamp default now()
);

alter table admins enable row level security;

create policy "Un admin peut voir la liste des admins"
  on admins for select
  using (exists (select 1 from admins a where a.user_id = auth.uid()));

create policy "Admin peut voir tous les profils"
  on profiles for select
  using (exists (select 1 from admins where user_id = auth.uid()));

create policy "Admin peut voir toutes les candidatures"
  on applications for select
  using (exists (select 1 from admins where user_id = auth.uid()));

create policy "Admin peut voir toutes les demandes de mentorat"
  on mentor_requests for select
  using (exists (select 1 from admins where user_id = auth.uid()));
