
CREATE TABLE IF NOT EXISTS language (
    id              SMALLSERIAL PRIMARY KEY,
    name            VARCHAR(13) NOT NULL UNIQUE CHECK ( char_length(name) > 1 ),
    tag             VARCHAR(3) NOT NULL UNIQUE CHECK ( char_length(tag) > 1 )
);
