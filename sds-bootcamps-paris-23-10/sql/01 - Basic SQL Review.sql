-- @block Starting with a basic SELECT
SELECT
  * EXCEPT (geom)
FROM
  cartobq.docs.paris_districts;


-- @block Adding new features
SELECT
  l_ar,
  surface,
  l_aroff IN (
    'Louvre', 'Bourse',
    'Temple', 'Hôtel-de-Ville' 
  ) AS within_paris_centre
FROM
  cartobq.docs.paris_districts;


-- @block Using Common Table Expressions
WITH
  paris_centre AS (
    SELECT
      *,
      l_aroff IN (
          'Louvre', 'Bourse',
          'Temple', 'Hôtel-de-Ville' 
        ) AS within_paris_centre
    FROM
      cartobq.docs.paris_districts
  )
SELECT
  l_ar,
  surface,
  within_paris_centre
FROM
  paris_centre;


-- @block Basics of grouping
WITH
  paris_centre AS (
    SELECT
      *,
      l_aroff IN (
          'Louvre', 'Bourse',
          'Temple', 'Hôtel-de-Ville' 
      ) AS within_paris_centre
    FROM
      cartobq.docs.paris_districts
  )
SELECT
  within_paris_centre,
  COUNT(*) AS n_districts,
  SUM(surface) AS total_area
FROM
  paris_centre
GROUP BY
  within_paris_centre
ORDER BY
  total_area DESC;


-- @block Basics of filtering
WITH
  paris_centre AS (
    SELECT
      *,
      l_aroff IN (
          'Louvre', 'Bourse',
          'Temple', 'Hôtel-de-Ville' 
      ) AS within_paris_centre
    FROM
      cartobq.docs.paris_districts
  )
SELECT
  within_paris_centre,
  COUNT(*) AS n_districts,
  SUM(surface) AS total_area
FROM
  paris_centre
WHERE
  l_aroff NOT LIKE 'L%'
GROUP BY
  within_paris_centre
HAVING
  n_districts > 3;


-- @block Using window functions
WITH
  paris_centre AS (
    SELECT
      *,
      l_aroff IN (
          'Louvre', 'Bourse',
          'Temple', 'Hôtel-de-Ville' 
      ) AS within_paris_centre
    FROM
      cartobq.docs.paris_districts
  )
SELECT
  l_aroff,
  surface,
  within_paris_centre,
  RANK() OVER (
    PARTITION BY
      within_paris_centre
    ORDER BY
      surface DESC
  ) AS paris_centre_ranking
FROM
  paris_centre
QUALIFY
  paris_centre_ranking <= 3
ORDER BY
  paris_centre_ranking DESC;


-- @block Working with arrays (I)
SELECT
  l_aroff,
  SPLIT(l_aroff, '-') AS words
FROM
  cartobq.docs.paris_districts;


-- @block Working with arrays (II)
WITH
  words_cte AS (
    SELECT
      l_aroff,
      SPLIT(l_aroff, '-') AS words
    FROM
      cartobq.docs.paris_districts
  )
SELECT
  l_aroff,
  word
FROM
  words_cte,
  UNNEST (words) AS word
WHERE
  LENGTH(word) > 2;
