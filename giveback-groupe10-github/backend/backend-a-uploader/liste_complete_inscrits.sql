select p.prenom, u.email, p.created_at
from profiles p
join auth.users u on u.id = p.id
order by p.created_at asc;
