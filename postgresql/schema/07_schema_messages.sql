
CREATE TABLE IF NOT EXISTS comment_plant (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    text            TEXT NOT NULL,
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);

CREATE TABLE IF NOT EXISTS comment_plant_set (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    text            TEXT NOT NULL,
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id)
);
