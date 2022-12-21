
CREATE TABLE IF NOT EXISTS account (
    id              SERIAL PRIMARY KEY,
    active          BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS account_profile (
    account_id      INTEGER PRIMARY KEY REFERENCES account(id),
    name            CHARACTER VARYING(107) NOT NULL CHECK ( char_length(name) > 3 ),
    last_name       CHARACTER VARYING(107) NOT NULL CHECK ( char_length(last_name) > 3 ),
    mid_name        CHARACTER VARYING(107),
    email           CHARACTER VARYING(113) UNIQUE NOT NULL CHECK ( char_length(email) > 5 ),
    language_id     SMALLINT NOT NULL REFERENCES language(id)
);

CREATE TABLE IF NOT EXISTS account_login_type (
    id              SMALLSERIAL PRIMARY KEY,
    title           CHARACTER VARYING(21) NOT NULL
);

CREATE TABLE IF NOT EXISTS account_login (
    id              SERIAL PRIMARY KEY,
    type_id         SMALLINT NOT NULL REFERENCES account_login_type(id),
    account_id      INTEGER NOT NULL REFERENCES account(id),
    external_id     UUID NOT NULL UNIQUE,
    active          BOOLEAN NOT NULL DEFAULT TRUE,
    login_at        TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    UNIQUE (account_id, type_id, active)
);
