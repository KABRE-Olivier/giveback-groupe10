-- =========================================================
-- À exécuter dans Supabase : Project → SQL Editor → New query
-- =========================================================

-- Table des profils utilisateurs (complète auth.users)
create table profiles (
  id uuid references auth.users primary key,
  prenom text,
  statut text,           -- 'bachelier' ou 'etudiant'
  tags text[],            -- ex: '{handicap,orphelin}'
  created_at timestamp default now()
);

alter table profiles enable row level security;

create policy "Un utilisateur voit son propre profil"
  on profiles for select using (auth.uid() = id);

create policy "Un utilisateur crée son propre profil"
  on profiles for insert with check (auth.uid() = id);

create policy "Un utilisateur modifie son propre profil"
  on profiles for update using (auth.uid() = id);

-- Table des opportunités (lecture publique)
create table opportunities (
  id bigint generated always as identity primary key,
  type text,               -- 'Bourse', 'Formation', 'Concours', 'Événement'
  title text,
  description text,
  deadline date,
  tags text[],              -- ex: '{bachelier,famille-modeste}'
  verified boolean default true,
  created_at timestamp default now()
);

alter table opportunities enable row level security;

create policy "Tout le monde peut voir les opportunités"
  on opportunities for select using (true);

-- Table des candidatures (suivi dans l'espace personnel)
create table applications (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade,
  opportunity_id bigint references opportunities on delete cascade,
  status text default 'En cours',
  created_at timestamp default now()
);

alter table applications enable row level security;

create policy "Un utilisateur gère ses propres candidatures"
  on applications for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- =========================================================
-- Quelques opportunités de test (à remplacer par de vraies données)
-- =========================================================
insert into opportunities (type, title, description, deadline, tags) values
('Bourse', 'Bourse d''excellence régionale — 1er cycle',
 'Bourse couvrant les frais de scolarité, ouverte aux nouveaux bacheliers d''Afrique de l''Ouest, priorité aux profils de mérite social.',
 '2026-09-15', '{bachelier,famille-modeste}'),
('Formation', 'Programme d''accompagnement candidature',
 'Trois semaines guidées pour construire un dossier de candidature solide, avec suivi individuel par un mentor.',
 '2026-08-30', '{bachelier,etudiant}'),
('Concours', 'Concours national d''entrée — filière ingénierie',
 'Frais d''inscription pris en charge pour les candidats en situation de vulnérabilité déclarée.',
 '2026-09-01', '{bachelier,handicap}'),
('Bourse', 'Bourse de continuité — années supérieures',
 'Destinée aux étudiants déjà inscrits risquant une interruption de parcours faute de financement.',
 '2026-08-25', '{etudiant,famille-modeste}'),
('Bourse', 'Bourse d''autonomie — jeunes sans soutien familial',
 'Financement intégral incluant hébergement, réservé aux candidats orphelins ou sans tuteur.',
 '2026-09-10', '{orphelin}'),
('Stage', 'Stage encadré — secteur ingénierie et environnement',
 'Stage de 3 à 6 mois pour étudiants en cours de cycle, avec encadrement dédié pour les profils sans réseau professionnel.',
 '2026-09-05', '{etudiant}'),
('Emploi', 'Premier emploi accompagné — jeunes diplômés',
 'Dispositif d''insertion professionnelle pour jeunes diplômés en situation de vulnérabilité, avec accompagnement à la candidature.',
 '2026-09-20', '{etudiant,famille-modeste}');
