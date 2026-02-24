-- +goose Up
CREATE TABLE budget (
    id UUID PRIMARY KEY,

    month INT NOT NULL,
    year INT NOT NULL,

    category_id UUID NOT NULL REFERENCES categories(id),
    CONSTRAINT budget_category_id FOREIGN KEY (category_id) REFERENCES categories(id),

    amount NUMERIC(12,2) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT budget_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT budget_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- índice único para evitar duplicação de orçamento por categoria/mês/ano
CREATE UNIQUE INDEX idx_budget_category_year_month
    ON budget (category_id, year, month);

-- +goose Down
DROP INDEX IF EXISTS idx_budget_category_year_month;
DROP TABLE budget;
