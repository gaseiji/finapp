-- +goose Up
CREATE TABLE users (
    id UUID PRIMARY KEY,

    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,

    pass_hash TEXT NOT NULL,
    pass_expiration_date TIMESTAMPTZ,

    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    
    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,
    last_login_at TIMESTAMPTZ
);

-- +goose Down
DROP TABLE users;