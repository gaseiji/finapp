-- name: CreateUser :one
INSERT INTO users (username, email, pass_hash)
VALUES ($1, $2, $3)



