-- +goose Up
CREATE TABLE pattern_rules (
    id UUID PRIMARY KEY,

    pattern TEXT NOT NULL,

    category_id UUID REFERENCES categories(id),
    CONSTRAINT fk_pattern_rules_category_id FOREIGN KEY (category_id) REFERENCES categories(id),

    hits INT NOT NULL DEFAULT 0,
    misses INT NOT NULL DEFAULT 0,

    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by UUID NOT NULL REFERENCES users(id),
    CONSTRAINT fk_pattern_rules_created_by FOREIGN KEY (created_by) REFERENCES users(id),

    updated_at TIMESTAMPTZ,
    updated_by UUID REFERENCES users(id),
    CONSTRAINT fk_pattern_rules_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),

    active BOOLEAN NOT NULL DEFAULT TRUE,
    inactivated_at TIMESTAMPTZ,
    inactivated_by UUID REFERENCES users(id),
    CONSTRAINT fk_pattern_rules_inactivated_by FOREIGN KEY (inactivated_by) REFERENCES users(id)
);

-- índice simples para comparação rápida por pattern
CREATE INDEX idx_pattern_rules_pattern
    ON pattern_rules(pattern);

-- índice único conforme DBML
CREATE UNIQUE INDEX idx_pattern_rules_pattern_category
    ON pattern_rules(pattern, category_id);

-- +goose Down
DROP INDEX IF EXISTS idx_pattern_rules_pattern_category;
DROP INDEX IF EXISTS idx_pattern_rules_pattern;
DROP TABLE pattern_rules;
