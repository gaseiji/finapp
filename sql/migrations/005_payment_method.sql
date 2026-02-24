-- +goose Up
CREATE TABLE payment_method (
    id UUID PRIMARY KEY,

    payment_method_name TEXT NOT NULL UNIQUE,

    user_payment_method UUID NOT NULL,

    owner_user_id UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_payment_method_owner FOREIGN KEY (owner_user_id) REFERENCES users(id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_payment_method_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_payment_method_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,
    inactivated_by UUID REFERENCES users(id),
    CONSTRAINT fk_payment_method_inactivated_by FOREIGN KEY (inactivated_by) REFERENCES users(id)
);

-- +goose Down
DROP TABLE payment_method;