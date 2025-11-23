-- +goose Up
CREATE TABLE users (
    id UUID PRIMARY KEY,

    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    pass_hash TEXT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ,

    last_login_at TIMESTAMPTZ,
    pass_expiration_date TIMESTAMPTZ,

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,

    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    verification_token TEXT,
    verification_token_expires_at TIMESTAMPTZ,

    pass_reset_token TEXT,
    pass_reset_token_expires_at TIMESTAMPTZ
);

-- +goose Down
DROP TABLE users;