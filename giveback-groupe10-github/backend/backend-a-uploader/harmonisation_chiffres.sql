-- =========================================================
-- Entonnoir de chiffres réels, pour harmoniser le rapport
-- (point 1 du retour n°2).
-- =========================================================

-- 1. Nombre total d'inscrits
select count(*) as total_inscrits from profiles;

-- 2. Nombre d'utilisateurs ayant une activité réelle (au moins une
-- candidature, une demande de mentorat, une publication OU un like)
select count(distinct user_id) as utilisateurs_actifs
from (
  select user_id from applications
  union
  select user_id from mentor_requests
  union
  select user_id from posts
  union
  select user_id from likes
  union
  select user_id from formation_likes
) as activite;

-- 3. Nombre de questionnaires de satisfaction exploitables (retours complets)
select count(*) as questionnaires_exploitables from feedbacks;

-- 4. Détail : combien de candidatures = "ajoutées à mon suivi" (PAS
-- forcément déposées officiellement — à clarifier dans le rapport)
select count(*) as candidatures_en_suivi from applications;

-- 5. Mentors actifs (dans la table mentors) vs membres de l'équipe (9)
select count(*) as mentors_actifs_dans_la_table from mentors;

-- 6. Répartition des critères de vulnérabilité (à formuler avec prudence,
-- catégories qui peuvent se chevaucher — voir remarque de la coordination)
select
  count(*) filter (where 'famille-modeste' = any(tags)) as famille_modeste,
  count(*) filter (where 'orphelin' = any(tags)) as orphelins,
  count(*) filter (where 'handicap' = any(tags)) as handicap,
  count(*) filter (where
    ('famille-modeste' = any(tags))::int +
    ('orphelin' = any(tags))::int +
    ('handicap' = any(tags))::int >= 2
  ) as profils_avec_plusieurs_criteres_a_la_fois
from profiles;
