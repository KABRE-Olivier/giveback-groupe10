insert into admins (user_id)
select id from auth.users where email = 'olivierkabre303@gmail.com'
on conflict do nothing;

-- Vérification
select a.user_id, u.email
from admins a
join auth.users u on u.id = a.user_id;
