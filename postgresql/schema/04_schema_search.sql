
CREATE TABLE IF NOT EXISTS plant_search (
    id              BIGSERIAL PRIMARY KEY,
    account_id      INTEGER NOT NULL REFERENCES account(id),
    text            TEXT NOT NULL CHECK ( char_length(text) > 1 ),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    result_count    INTEGER NOT NULL DEFAULT 0 CHECK ( result_count >= 0 ),
    attempts        INTEGER NOT NULL DEFAULT 1 CHECK ( attempts >= 1 ),
    UNIQUE (account_id, text)
);
