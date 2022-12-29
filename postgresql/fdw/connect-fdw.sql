CREATE EXTENSION postgres_fdw;

CREATE SERVER source_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host '127.0.0.1', port '5432', dbname 'mimir_plants');

CREATE USER MAPPING FOR progg
        SERVER source_server
        OPTIONS (user 'progg', password 'yak546uk13');

create schema fwd_mimir_plants_public;
alter schema fwd_mimir_plants_public owner to progg;

IMPORT FOREIGN SCHEMA public
    FROM SERVER source_server INTO fwd_mimir_plants_public;

--- check connection
SELECT * FROM postgres_fdw_get_connections() ORDER BY 1;

--- Test access
SELECT *
FROM "fwd_mimir_plants_public"."bio_graph_plant"
LIMIT 7
;
