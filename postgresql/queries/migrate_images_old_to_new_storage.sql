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

-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantImages" ("Id", "PlantId", "Height", "Width", "Extention")
-- SELECT id, plant_id, height, width, extention
-- FROM bio_graph_plant_image
-- WHERE extention is not null and length(extention) > 0
-- ;
--
-- SELECT count(*) FROM "fwd_seed-plant-service-db_public"."PlantImages";

-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantImageTags" ("Id", "Name")
-- SELECT uuid_generate_v4(), tag.ru
-- FROM bio_graph_plant_image_tag as tag
-- ;

-- INSERT INTO "fwd_seed-plant-service-db_public"."PlantImagePlantImageTag" ("ImagesId", "TagsId")
-- SELECT tags.bio_graph_plant_image_id as image_id, newTag."Id" as tag_id
-- FROM bio_graph_plant_image_tags as tags
-- LEFT JOIN bio_graph_plant_image_tag as tag ON tags.tags_name = tag.name
-- LEFT JOIN "fwd_seed-plant-service-db_public"."PlantImageTags" as newTag ON newTag."Name" = tag.ru
-- ;
--
-- SELECT count(*) FROM "fwd_seed-plant-service-db_public"."PlantImagePlantImageTag";