
CREATE TABLE IF NOT EXISTS favorite_plant (
    account_id          INTEGER NOT NULL REFERENCES account(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_id            INTEGER NOT NULL REFERENCES plant(id),
    PRIMARY KEY (account_id, plant_id)
);

CREATE TABLE IF NOT EXISTS favorite_plant_set (
    account_id          INTEGER NOT NULL REFERENCES account(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_set_id        INTEGER NOT NULL REFERENCES plant_set(id),
    PRIMARY KEY (account_id, plant_set_id)
);

CREATE TABLE IF NOT EXISTS favorite_search (
    account_id          INTEGER NOT NULL REFERENCES account(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    plant_search_id     INTEGER NOT NULL REFERENCES plant_search(id),
    PRIMARY KEY (account_id, plant_search_id)
);
