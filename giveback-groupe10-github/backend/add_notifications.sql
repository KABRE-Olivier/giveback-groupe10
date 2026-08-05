create table notifications (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  type text,
  post_id bigint references posts on delete cascade,
  from_prenom text,
  lu boolean default false,
  created_at timestamp default now()
);

alter table notifications enable row level security;

create policy "Un utilisateur voit ses propres notifications"
  on notifications for select using (auth.uid() = user_id);

create policy "Un utilisateur met à jour ses propres notifications"
  on notifications for update using (auth.uid() = user_id);

create or replace function public.notify_on_like()
returns trigger as $$
declare
  post_owner uuid;
  liker_prenom text;
begin
  select user_id into post_owner from posts where id = new.post_id;
  if post_owner is null or post_owner = new.user_id then
    return new;
  end if;
  select prenom into liker_prenom from profiles where id = new.user_id;
  insert into notifications (user_id, type, post_id, from_prenom)
  values (post_owner, 'like', new.post_id, coalesce(liker_prenom, 'Quelqu''un'));
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_like_created on likes;
create trigger on_like_created after insert on likes
  for each row execute procedure public.notify_on_like();

create or replace function public.notify_on_comment()
returns trigger as $$
declare
  post_owner uuid;
begin
  select user_id into post_owner from posts where id = new.post_id;
  if post_owner is null or post_owner = new.user_id then
    return new;
  end if;
  insert into notifications (user_id, type, post_id, from_prenom)
  values (post_owner, 'comment', new.post_id, coalesce(new.auteur_prenom, 'Quelqu''un'));
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_comment_created on comments;
create trigger on_comment_created after insert on comments
  for each row execute procedure public.notify_on_comment();
