
CREATE TABLE IF NOT EXISTS favorite_plant (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_id        INTEGER NOT NULL REFERENCES plant(id)
);

CREATE TABLE IF NOT EXISTS favorite_plant_set (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_set_id    INTEGER NOT NULL REFERENCES plant_set(id)
);

CREATE TABLE IF NOT EXISTS favorite_search (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_search_id        INTEGER NOT NULL REFERENCES plant_search(id)
);
