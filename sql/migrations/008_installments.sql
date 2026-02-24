-- +goose Up
CREATE TABLE installments (
    id UUID PRIMARY KEY,

    description TEXT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    total_number_installments INT NOT NULL,
    total_remaining_installments INT NOT NULL,
    next_due_date DATE NOT NULL,

    category_id UUID REFERENCES categories(id),
    CONSTRAINT fk_installments_category_id FOREIGN KEY (category_id) REFERENCES categories(id),

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_installments_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_installments_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- +goose Down
DROP TABLE installments;
