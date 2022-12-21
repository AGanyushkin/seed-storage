
DROP TYPE IF EXISTS plant_property_type_enum CASCADE;
CREATE TYPE plant_property_type_enum AS ENUM (
    'atom_int',
    'atom_float',
    'atom_tag',
    'range_int',
    'range_float',
    'set_int',
    'set_float',
    'set_tag',
    'raw_int',
    'raw_float'
);

CREATE TABLE IF NOT EXISTS plant_property_type (
    id      SERIAL PRIMARY KEY,
    type    plant_property_type_enum
);

CREATE TABLE IF NOT EXISTS plant_property_group (
    id      SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS plant_property_group_name (
    id                          SERIAL PRIMARY KEY,
    language_id                 SMALLINT NOT NULL REFERENCES language(id),
    text                        VARCHAR(255),
    plant_property_group_id     INTEGER NOT NULL REFERENCES plant_property_group(id)
);

CREATE TABLE IF NOT EXISTS plant_property_unit (
    id      SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS plant_property_unit_name (
    id                          SERIAL PRIMARY KEY,
    language_id                 SMALLINT NOT NULL REFERENCES language(id),
    text                        VARCHAR(255),
    plant_property_unit_id      INTEGER NOT NULL REFERENCES plant_property_unit(id)
);

CREATE TABLE IF NOT EXISTS plant_property (
    id                          SERIAL PRIMARY KEY,
    plant_property_type_id      INTEGER NOT NULL REFERENCES plant_property_type(id),
    plant_property_group_id     INTEGER NOT NULL REFERENCES plant_property_group(id),
    plant_property_unit_id      INTEGER NOT NULL REFERENCES plant_property_unit(id)
);

CREATE TABLE IF NOT EXISTS plant_property_name (
    id                          SERIAL PRIMARY KEY,
    language_id                 SMALLINT NOT NULL REFERENCES language(id),
    text                        VARCHAR(255),
    plant_property_id           INTEGER NOT NULL REFERENCES plant_property(id)
);

CREATE TABLE IF NOT EXISTS plant_property_set_tag (
    id                          SERIAL PRIMARY KEY,
    plant_property_id           INTEGER NOT NULL REFERENCES plant_property(id),
    sort_value                  INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS plant_property_set_tag_name (
    id                          SERIAL PRIMARY KEY,
    language_id                 SMALLINT NOT NULL REFERENCES language(id),
    text                        VARCHAR(255),
    plant_property_set_tag_id   INTEGER NOT NULL REFERENCES plant_property_set_tag(id)
);

CREATE TABLE IF NOT EXISTS plant_property_set_float (
    id                          SERIAL PRIMARY KEY,
    plant_property_id           INTEGER NOT NULL REFERENCES plant_property(id),
    value                       FLOAT
);

CREATE TABLE IF NOT EXISTS plant_property_set_int (
    id                          SERIAL PRIMARY KEY,
    plant_property_id           INTEGER NOT NULL REFERENCES plant_property(id),
    value                       INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_range_float (
    id                          INTEGER PRIMARY KEY REFERENCES plant_property(id),
    value_from                  FLOAT NOT NULL,
    value_to                    FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_range_int (
    id                          INTEGER PRIMARY KEY REFERENCES plant_property(id),
    value_from                  INTEGER NOT NULL,
    value_to                    INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_value (
    id                          SERIAL PRIMARY KEY,
    plant_id                    INTEGER NOT NULL REFERENCES plant(id),
    plant_property_id           INTEGER NOT NULL REFERENCES plant_property(id)
);

CREATE TABLE IF NOT EXISTS plant_property_value_to_plant_property_set_tag (
    plant_property_value_id     INTEGER NOT NULL REFERENCES plant_property_value(id),
    plant_property_set_tag_id   INTEGER NOT NULL REFERENCES plant_property_set_tag(id)
);

CREATE TABLE IF NOT EXISTS plant_property_value_int (
    id                          SERIAL PRIMARY KEY,
    plant_property_value_id     INTEGER NOT NULL REFERENCES plant_property_value(id),
    value                       INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_value_float (
    id                          SERIAL PRIMARY KEY,
    plant_property_value_id     INTEGER NOT NULL REFERENCES plant_property_value(id),
    value                       INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_value_range_int (
    id                          INTEGER PRIMARY KEY REFERENCES plant_property_value(id),
    value_from                  INTEGER NOT NULL,
    value_to                    INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_property_value_range_float (
    id                          INTEGER PRIMARY KEY REFERENCES plant_property_value(id),
    value_from                  FLOAT NOT NULL,
    value_to                    FLOAT NOT NULL
);
