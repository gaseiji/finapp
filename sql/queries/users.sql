-- name: CreateUser :exec
INSERT INTO users (id, username, email, pass_hash, created_at, updated_at, pass_expiration_date, active, email_verified)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);