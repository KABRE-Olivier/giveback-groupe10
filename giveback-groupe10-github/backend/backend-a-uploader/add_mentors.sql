-- =========================================================
-- À exécuter dans Supabase : SQL Editor → New query
-- Ajoute les mentors et les demandes de mentorat
-- =========================================================

create table mentors (
  id bigint generated always as identity primary key,
  nom text,
  bio text,
  expertise text[],        -- domaine d'intervention, ex: '{candidature,orientation}'
  created_at timestamp default now()
);

alter table mentors enable row level security;

create policy "Tout le monde peut voir les mentors"
  on mentors for select using (true);

create table mentor_requests (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  mentor_id bigint references mentors on delete cascade,
  message text,
  status text default 'Envoyée',
  created_at timestamp default now()
);

alter table mentor_requests enable row level security;

create policy "Un utilisateur gère ses propres demandes"
  on mentor_requests for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Mentors d'exemple, basés sur des membres de l'équipe Voie
-- (à ajuster/compléter avec leur accord avant un vrai lancement)
-- Tous présentés au même niveau : uniquement leur domaine d'intervention.
insert into mentors (nom, bio, expertise) values
('Morelle Moffo', 'Membre de l''équipe Voie. Accompagne sur la compréhension des critères d''éligibilité aux bourses et la constitution de dossiers de candidature.', '{candidature,orientation}'),
('Belyse Nininahazwe', 'Membre de l''équipe Voie. Accompagne sur la structuration de projets et de dossiers de candidature.', '{candidature,ressources}'),
('Kabre Olivier', 'Coordinateur de l''équipe Voie. Accompagne sur la structuration globale d''une candidature et la mise en relation avec les bonnes ressources.', '{orientation,coordination}'),
('OKEI Danielle Ange', 'Membre de l''équipe Voie. Accompagne sur l''identification des aménagements possibles et l''orientation vers les bourses adaptées.', '{orientation,candidature}'),
('Sawa Anne Laurette Kissi', 'Membre de l''équipe Voie. Accompagne sur la constitution de dossiers de candidature.', '{candidature,suivi}'),
('Ivan NDONGO', 'Membre de l''équipe Voie. Assure un suivi dédié des dossiers de candidature.', '{suivi,candidature}'),
('Fatou D.', 'Mentore bénévole externe. Accompagne sur la préparation d''un dossier de candidature solide.', '{candidature,orientation}'),
('Karim S.', 'Mentor bénévole externe. Accompagne sur la constitution du dossier de candidature.', '{candidature,orientation}'),
('Aïcha B.', 'Mentore bénévole externe. Aide à monter un dossier de candidature convaincant.', '{candidature,ressources}');
