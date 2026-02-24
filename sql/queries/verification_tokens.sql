-- name: CreateVerificationToken :one
INSERT INTO verification_tokens (
    id,
    user_id,
    token,
    expires_at
)
VALUES ($1, $2, $3, $4)
RETURNING *;

-- name: GetVerificationToken :one
SELECT *
FROM verification_tokens
WHERE token = $1;

-- name: MarkVerificationTokenUsed :one
UPDATE verification_tokens
SET used = TRUE,
    used_at = NOW()
WHERE token = $1
RETURNING *;
