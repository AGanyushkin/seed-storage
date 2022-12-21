
CREATE TABLE IF NOT EXISTS plant (
    id              SERIAL PRIMARY KEY,
    global_id       UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_name (
    id              SERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255),
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);

CREATE TABLE IF NOT EXISTS plant_name_alias (
    id              SERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255),
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);

CREATE TABLE IF NOT EXISTS plant_image (
    id              SERIAL PRIMARY KEY,
    plant_id        INTEGER NOT NULL REFERENCES plant(id),
    height          INTEGER NOT NULL,
    width           INTEGER NOT NULL,
    mimetype        VARCHAR(30),
    global_id       UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_image_tag (
    id              SERIAL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS plant_image_to_plant_image_tag (
    plant_image_id          INTEGER NOT NULL REFERENCES plant_image(id),
    plant_image_tag_id      INTEGER NOT NULL REFERENCES plant_image_tag(id)
);

CREATE TABLE IF NOT EXISTS plant_image_tag_name (
    id              SERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255),
    plant_image_tag_id      INTEGER NOT NULL REFERENCES plant_image_tag(id)
);

CREATE TABLE IF NOT EXISTS plant_text_fragment (
    id              SERIAL PRIMARY KEY,
    language_id     SMALLINT NOT NULL REFERENCES language(id),
    text            VARCHAR(255),
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);


CREATE TABLE IF NOT EXISTS plant_set (
    id              SERIAL PRIMARY KEY,
    owner_id        INTEGER NOT NULL REFERENCES account(id),
    description     VARCHAR(255) NOT NULL DEFAULT '',
    public          BOOLEAN NOT NULL DEFAULT FALSE,
    global_id       UUID NOT NULL
);

CREATE TABLE IF NOT EXISTS plant_set_to_account (
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id),
    account_id      INTEGER NOT NULL REFERENCES account(id)
);

CREATE TABLE IF NOT EXISTS plant_set_to_plant (
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id),
    plant_id      INTEGER NOT NULL REFERENCES plant(id)
);
