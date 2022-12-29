
SELECT *
FROM plant_name
WHERE
    language_id = 1 AND
    to_tsvector('russian', "text") @@ plainto_tsquery('russian', 'ель')
;

SELECT *
FROM plant_name
WHERE
    (language_id = 2 OR language_id = 3) AND
    to_tsvector('english', "text") @@ plainto_tsquery('english', 'Betula')
;

SELECT *
FROM plant_name
WHERE
    language_id = 1 AND
    to_tsvector('russian', "text") @@ plainto_tsquery('russian', 'Betula')
;

SELECT *
FROM plant_name
WHERE
    language_id = 1 AND
    to_tsvector('russian', "text") @@ plainto_tsquery('russian', 'Betula pendula ‘Purpurea’')
;

SELECT *
FROM plant_name
WHERE
    (language_id = 2 OR language_id = 3) AND
    to_tsvector('english', "text") @@ plainto_tsquery('english', 'Betula "Purpurea"')
;

SELECT *
FROM plant_name
WHERE
    language_id = 1 AND
    to_tsvector('russian', "text") @@ plainto_tsquery('russian', 'Ель ''Хупси''')
;

--- all in sql, separated queries will be more preferable (?)
---     Betula "Purpurea"
---     Ель 'Хупси'
SELECT *
FROM plant_name
WHERE
    (language_id = 1 AND to_tsvector('russian', "text") @@ plainto_tsquery('russian', 'Ель ''Хупс'''))
    OR
    ((language_id = 2 OR language_id = 3) AND to_tsvector('english', "text") @@ plainto_tsquery('english', 'Ель ''Хупс'''))
;

--- examples
SELECT plainto_tsquery('russian', 'Ель ''Хупс''');
SELECT plainto_tsquery('russian', 'Betula "Purpurea"');
