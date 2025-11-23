-- +goose Up
CREATE TABLE transactions (
    id UUID PRIMARY KEY,

    description TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,

    user_payment_method UUID NOT NULL REFERENCES payment_method(id),
    CONSTRAINT fk_transactions_payment_method FOREIGN KEY (user_payment_method) REFERENCES payment_method(id),

    category_id UUID REFERENCES categories(id),
    CONSTRAINT fk_transactions_category FOREIGN KEY (category_id) REFERENCES categories(id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_transactions_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_transactions_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,
    inactivated_by UUID REFERENCES users(id),
    CONSTRAINT fk_transactions_inactivated_by FOREIGN KEY (inactivated_by) REFERENCES users(id)
);

-- +goose Down
DROP TABLE transactions;
