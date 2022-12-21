
CREATE TABLE IF NOT EXISTS comment_plant (
    id              BIGSERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    text            TEXT NOT NULL CHECK ( char_length(text) > 1 ),
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);

CREATE TABLE IF NOT EXISTS comment_plant_set (
    id              BIGSERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    text            TEXT NOT NULL CHECK ( char_length(text) > 1 ),
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id)
);
