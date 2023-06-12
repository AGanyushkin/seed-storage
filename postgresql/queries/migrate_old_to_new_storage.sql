-- CREATE SERVER self_server
-- FOREIGN DATA WRAPPER postgres_fdw
-- OPTIONS (host '127.0.0.1', port '5432', dbname 'seed-plant-service-db');
-- CREATE USER MAPPING FOR postgres
-- SERVER self_server
-- OPTIONS (user 'postgres', password 'yak546uk13');
-- create schema "fwd_seed-plant-service-db_public";
-- alter schema "fwd_seed-plant-service-db_public" owner to postgres;
-- IMPORT FOREIGN SCHEMA public
-- FROM SERVER self_server INTO "fwd_seed-plant-service-db_public";

-- -- sync schema
-- DROP SCHEMA IF EXISTS "fwd_seed-plant-service-db_public" CASCADE;
-- CREATE SCHEMA "fwd_seed-plant-service-db_public" ;
-- IMPORT FOREIGN SCHEMA public
--     FROM SERVER self_server INTO "fwd_seed-plant-service-db_public";

-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantPropertyTypeGroups" ("Id", "Name")
-- SELECT id, ru
-- FROM bio_graph_plant_property_description_group
-- ;

-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantPropertyTypes" ("Id", "Name", "GroupId", "PropertyTypeClass")
-- SELECT id, ru, group_id,
--        (CASE WHEN (definition_type || '_' || property_type = 'NUMBER_RANGE') THEN 0 ELSE
--            (CASE WHEN (definition_type || '_' || property_type = 'TAG_RANGE') THEN 1 ELSE
--                 (CASE WHEN (definition_type || '_' || property_type = 'TAG_SET') THEN 3 ELSE -1 END)
--                END)
--            END)
-- FROM "public"."bio_graph_plant_property_description"
-- ;

-- -- property types
-- -- TAG_SET
-- -- TAG_RANGE
-- -- NUMBER_RANGE

-- NUMBER_RANGE
-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantProperties" ("Id", "PlantId", "PropertyTypeId", "Property")
-- SELECT prop.id, prop.plant_id, def.id as def_id,
--        json_build_object('value_from', prop.number_range_from, 'value_to', prop.number_range_to)::jsonb as property
-- FROM bio_graph_plant_property_description as def
-- LEFT JOIN bio_graph_plant_property prop ON prop.type_description_id = def.id
-- WHERE def.definition_type = 'NUMBER' and
--       def.property_type = 'RANGE'
-- ;

-- -- TAGs
-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantPropertyTypeTags" ("Id", "SortNumber", "Name", "PlantPropertyTypeId")
-- SELECT tag.id,
--         (CASE WHEN (tag.number IS NULL) THEN 0 ELSE tag.number END) as sort_number,
--         (CASE WHEN (tag.ru IS  NOT NULL) THEN tag.ru ELSE tag.en END) as name,
--         mapping.bio_graph_plant_property_description_id as def_id
-- FROM bio_graph_plant_property_description_tag as tag
-- LEFT JOIN bio_graph_plant_property_description_tag_type_enum mapping ON tag.id = mapping.tag_type_enum_id
-- ;

-- -- TAG_RANGE
-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantProperties" ("Id", "PlantId", "PropertyTypeId", "Property")
-- SELECT prop.id, prop.plant_id, def.id as def_id,
--        json_build_object('tag_from', prop.tag_range_from_id, 'tag_to', prop.tag_range_to_id)::jsonb as property
-- FROM bio_graph_plant_property_description as def
-- LEFT JOIN bio_graph_plant_property prop ON prop.type_description_id = def.id
-- WHERE def.definition_type = 'TAG' and
--       def.property_type = 'RANGE'
-- ;

-- -- TAG_SET
-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantProperties" ("Id", "PlantId", "PropertyTypeId", "Property")
-- SELECT prop.id, prop.plant_id, def.id as def_id,
--        jsonb_build_object('tags', array_to_json(array_agg(mapping.tag_set_id))) as property
-- FROM bio_graph_plant_property_description as def
-- LEFT JOIN bio_graph_plant_property prop ON prop.type_description_id = def.id
-- LEFT JOIN bio_graph_plant_property_tag_set mapping ON prop.id = mapping.bio_graph_plant_property_id
-- WHERE def.definition_type = 'TAG' and
--       def.property_type = 'SET'
-- GROUP BY prop.id, prop.plant_id, def.id
-- ;

-- --
-- DELETE FROM "fwd_seed-plant-service-db_public"."PlantProperties";

--
-- SELECT count(*)
-- FROM "fwd_seed-plant-service-db_public"."PlantProperties";
