
--- move plants
INSERT INTO "public"."plant" (global_id)
SELECT id as global_id
FROM "fwd_mimir_plants_public"."bio_graph_plant"
;
SELECT count(id)
FROM "public"."plant"
;

--- move plant names
INSERT INTO "public"."plant_name" (language_id, text, plant_id)
SELECT 3, lat, newplant.id
FROM "fwd_mimir_plants_public"."bio_graph_plant" as sourceT
LEFT JOIN "public"."plant" newplant on sourceT.id = newplant.global_id
WHERE lat is not null
;
SELECT count(*)
FROM "public"."plant_name"
;


--- test, get names by global_id
SELECT l.tag, pn.text
FROM plant
LEFT JOIN plant_name pn on pn.plant_id = plant.id
LEFT JOIN language l on pn.language_id = l.id
WHERE plant.global_id = '049051cf-6b38-4fff-93ef-245b047dda1d'
;
