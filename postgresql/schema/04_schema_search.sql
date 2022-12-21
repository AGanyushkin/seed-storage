
CREATE TABLE IF NOT EXISTS plant_search (
    id              SERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    text            TEXT NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    result_count    INTEGER NOT NULL DEFAULT 0
);
