-- +goose Up
CREATE TABLE verification_tokens (
    id UUID PRIMARY KEY,

    token TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,

    used BOOLEAN NOT NULL DEFAULT FALSE,
    used_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),

    user_id UUID NOT NULL,

    CONSTRAINT fk_password_reset_tokens_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- +goose Down
DROP TABLE verification_tokens;