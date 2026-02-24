-- +goose Up
CREATE TABLE categories (
    id UUID PRIMARY KEY,

    category_name TEXT NOT NULL UNIQUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID REFERENCES users(id),
    CONSTRAINT fk_categories_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_categories_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,
    inactivated_by UUID REFERENCES users(id),
    CONSTRAINT fk_categories_inactivated_by FOREIGN KEY (inactivated_by) REFERENCES users(id)
);

-- +goose Down
DROP TABLE categories;