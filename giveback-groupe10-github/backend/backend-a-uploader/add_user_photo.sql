-- =========================================================
-- Ajoute une photo de profil optionnelle pour chaque utilisateur
-- (pas seulement les mentors).
-- =========================================================

alter table profiles add column if not exists photo_url text;
