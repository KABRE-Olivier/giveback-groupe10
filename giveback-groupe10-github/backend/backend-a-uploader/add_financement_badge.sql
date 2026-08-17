-- =========================================================
-- Ajoute un badge "type de financement" (ex: Entièrement
-- financée) aux opportunités concernées.
-- =========================================================

alter table opportunities add column if not exists financement text;

update opportunities set financement = 'Entièrement financée'
where partenaire like 'Mastercard Foundation%';
