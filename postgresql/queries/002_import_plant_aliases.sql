--- move aliases
INSERT INTO plant_name_alias (language_id, text, plant_id)
SELECT 1, source.name, p.id
FROM "fwd_mimir_plants_public"."bio_graph_plant_source_name_variant" as source
LEFT JOIN "public".plant p on source.plant_id = p.global_id
WHERE "type" = 'TEXT' AND source.name is not null AND source.plant_id is not null AND source.lang = 'ru'
;
SELECT count(id)
FROM plant_name_alias
;


--- test
SELECT l.tag, alias.text
FROM plant
LEFT JOIN plant_name_alias alias on alias.plant_id = plant.id
LEFT JOIN language l on alias.language_id = l.id
WHERE plant.global_id = '049051cf-6b38-4fff-93ef-245b047dda1d'
;

