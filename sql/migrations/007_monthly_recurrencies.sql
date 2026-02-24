-- +goose Up
CREATE TABLE monthly_recurrencies (
    id UUID PRIMARY KEY,

    description TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    next_due_date DATE NOT NULL,

    category_id UUID REFERENCES categories(id),
    CONSTRAINT fk_monthly_recurrencies_category_id FOREIGN KEY (category_id) REFERENCES categories(id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_monthly_recurrencies_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_monthly_recurrencies_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,
    inactivated_by UUID REFERENCES users(id),
    CONSTRAINT fk_monthly_recurrencies_inactivated_by FOREIGN KEY (inactivated_by) REFERENCES users(id)
);

-- +goose Down
DROP TABLE monthly_recurrencies;
