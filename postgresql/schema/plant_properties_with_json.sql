
DROP INDEX IF EXISTS property_json_idx;
DROP TABLE IF EXISTS plant_properties;
DROP TABLE IF EXISTS property_type;
DROP TABLE IF EXISTS property_group;
DROP TABLE IF EXISTS pool_names;

CREATE TABLE IF NOT EXISTS pool_names
(
    id uuid NOT NULL,
    ru character(255),
    en character(255),
    CONSTRAINT pool_names_pkey PRIMARY KEY (id),
    CONSTRAINT any_name_must_exists CHECK (
        ru IS NOT NULL AND char_length(ru) > 0 OR
        en IS NOT NULL AND char_length(en) > 0
    )
)

CREATE TABLE IF NOT EXISTS property_group
(
    id uuid NOT NULL,
    name_id uuid NOT NULL,
    CONSTRAINT property_group_pkey PRIMARY KEY (id),
    CONSTRAINT property_group_name_id_fkey FOREIGN KEY (name_id)
        REFERENCES pool_names (id)
)

CREATE TABLE IF NOT EXISTS property_type
(
    id uuid NOT NULL,
    name_id uuid NOT NULL,
    group_id uuid,
    
    details jsonb NOT NULL,

    type_details_json_schema text,
    property_json_schema text,

    CONSTRAINT property_type_pkey PRIMARY KEY (id),

    CONSTRAINT property_type_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES property_group (id),

    CONSTRAINT property_type_name_id_fkey FOREIGN KEY (name_id)
        REFERENCES pool_names (id)
)

CREATE TABLE IF NOT EXISTS plant_properties
(
    id uuid NOT NULL,
    plant_id uuid NOT NULL,
    property_type_id uuid NOT NULL,
    
    property jsonb NOT NULL,

    CONSTRAINT plant_properties_pkey PRIMARY KEY (id),
    
    CONSTRAINT plant_properties_property_type_id_fkey FOREIGN KEY (property_type_id)
        REFERENCES property_type (id),
    
    CONSTRAINT type_must_exists CHECK (
        (property -> 'type_id') IS NOT NULL
    ),

    CONSTRAINT type_is_string CHECK (
        jsonb_typeof(property -> 'type_id') = 'string'
    ),
    
    CONSTRAINT type_same_as_in_table CHECK (
        property_type_id = ((property ->> 'type_id')::uuid)
    ),

    CONSTRAINT property_validation CHECK (
        jsonb_typeof(property -> 'min_value') = 'number' AND
        jsonb_typeof(property -> 'max_value') = 'number' AND
        (property -> 'max_value') >= (property -> 'min_value')
    )
)

CREATE INDEX IF NOT EXISTS property_json_idx ON plant_properties USING gin (property jsonb_path_ops);
