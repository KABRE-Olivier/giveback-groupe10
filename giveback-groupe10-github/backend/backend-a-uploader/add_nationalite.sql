-- =========================================================
-- Ajoute la nationalité, séparée du pays de résidence.
-- Utile car les bourses exigent souvent la NATIONALITÉ
-- (ex: "ressortissant d'un pays d'Afrique subsaharienne
-- francophone"), tandis que stages/emplois locaux dépendent
-- plutôt du pays de RÉSIDENCE.
-- =========================================================

alter table profiles add column if not exists nationalite text;
