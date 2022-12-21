
CREATE TABLE IF NOT EXISTS plant (
    id              SERIAL PRIMARY KEY,
    global_id       UUID NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS plant_name (
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255) NOT NULL,
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    PRIMARY KEY (language_id, plant_id)
);

CREATE TABLE IF NOT EXISTS plant_name_alias (
    id              BIGSERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255) NOT NULL,
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    UNIQUE (language_id, text)
);

DROP TYPE IF EXISTS plant_image_mimetype_enum CASCADE;
CREATE TYPE plant_image_mimetype_enum AS ENUM (
    'image/jpeg',
    'image/pjpeg',
    'image/png'
);

CREATE TABLE IF NOT EXISTS plant_image (
    id              BIGSERIAL PRIMARY KEY,
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    height          INTEGER NOT NULL CHECK (height > 100),
    width           INTEGER NOT NULL CHECK (width > 100),
    mimetype        plant_image_mimetype_enum NOT NULL,
    global_id       UUID NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS plant_image_tag (
    id              SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS plant_image_to_plant_image_tag (
    plant_image_id          INTEGER NOT NULL REFERENCES plant_image(id),
    plant_image_tag_id      INTEGER NOT NULL REFERENCES plant_image_tag(id),
    PRIMARY KEY (plant_image_id, plant_image_tag_id)
);

CREATE TABLE IF NOT EXISTS plant_image_tag_name (
    language_id             SMALLINT NOT NULL REFERENCES language(id),
    text                    VARCHAR(255) NOT NULL CHECK ( char_length(text) > 3 ),
    plant_image_tag_id      INTEGER NOT NULL REFERENCES plant_image_tag(id),
    PRIMARY KEY (language_id, plant_image_tag_id)
);

CREATE TABLE IF NOT EXISTS plant_text_fragment (
    id              BIGSERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255) NOT NULL CHECK ( char_length(text) > 3 ),
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    UNIQUE (language_id, text)
);


CREATE TABLE IF NOT EXISTS plant_set (
    id              BIGSERIAL PRIMARY KEY,
    owner_id        INTEGER NOT NULL REFERENCES account(id),
    name            VARCHAR(255) NOT NULL CHECK ( char_length(name) > 5 ),
    public          BOOLEAN NOT NULL DEFAULT FALSE,
    global_id       UUID NOT NULL UNIQUE,
    UNIQUE (owner_id, name)
);

CREATE TABLE IF NOT EXISTS plant_set_to_account (
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id),
    account_id      INTEGER NOT NULL REFERENCES account(id),
    PRIMARY KEY (plant_set_id, account_id)
);

CREATE TABLE IF NOT EXISTS plant_set_to_plant (
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id),
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    PRIMARY KEY (plant_set_id, plant_id)
);
