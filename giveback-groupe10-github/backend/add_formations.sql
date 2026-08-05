create table formations (
  id bigint generated always as identity primary key,
  categorie text,
  titre text,
  description text,
  video_id text,
  created_at timestamp default now()
);

alter table formations enable row level security;

create policy "Tout le monde peut voir les mini-formations"
  on formations for select using (true);

insert into formations (categorie, titre, description, video_id) values
('CV', 'Comment faire un CV étudiant ?',
 'Créer un CV étudiant efficace en quelques minutes, même sans expérience professionnelle.',
 'vfTITf4QbO8'),
('CV', 'Comment faire un CV étudiant sans expérience',
 'Mettre en avant ses compétences et sa formation quand on n''a pas encore d''expérience pro.',
 '_BogbDn4Df8'),
('Lettre de motivation', 'Rédiger une bonne lettre de motivation',
 'Conseils pratiques pour une lettre de motivation claire et convaincante (utile pour Parcoursup et au-delà).',
 'ceNrxwIwwyc'),
('Lettre de motivation', 'Une lettre de motivation 100% efficace',
 'Structurer une lettre de motivation qui sort du lot pour une formation ou un contrat.',
 'dUcgpHvVqBw');
