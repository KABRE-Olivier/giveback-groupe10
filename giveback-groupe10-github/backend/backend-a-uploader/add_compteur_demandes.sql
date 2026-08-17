-- =========================================================
-- Ajoute un compteur PUBLIC de demandes reçues par mentor
-- (juste le nombre, jamais qui a demandé — respecte la
-- confidentialité tout en prouvant que les interactions
-- mentors ↔ utilisateurs sont réelles).
-- =========================================================

alter table mentors add column if not exists demandes_recues integer default 0;

create or replace function public.increment_mentor_requests()
returns trigger as $$
begin
  update mentors set demandes_recues = demandes_recues + 1 where id = new.mentor_id;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_mentor_request_created on mentor_requests;
create trigger on_mentor_request_created
  after insert on mentor_requests
  for each row execute procedure public.increment_mentor_requests();

-- Recalcule les compteurs pour les demandes déjà passées
update mentors m set demandes_recues = (
  select count(*) from mentor_requests mr where mr.mentor_id = m.id
);
