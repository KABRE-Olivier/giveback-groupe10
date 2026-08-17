-- Vérifie s'il existe plusieurs comptes avec un email proche
-- (espace en trop, majuscule différente, doublon...)
select id, email, created_at
from auth.users
where email ilike '%olivierkabre303%';

-- Vérifie que CET id précis est bien dans la table admins
select a.user_id, u.email
from admins a
join auth.users u on u.id = a.user_id
where u.email ilike '%olivierkabre303%';
