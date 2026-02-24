package repositoryusers

import (
	"context"
	"time"

	"github.com/gaseiji/finapp/backend/domain/user"
	"github.com/gaseiji/finapp/internal/database"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
)

type UserRepository struct {
	db *database.Queries
}

func NewUserRepository(db *database.Queries) *UserRepository {
	return &UserRepository{db: db}
}

func (r *UserRepository) CreateUserFunc(user user.UserModel) error {
	params := database.CreateUserParams{
		ID:       uuid.New(),
		Username: user.Username,
		Email:    user.Email,
		PassHash: user.Password,
		CreatedAt: pgtype.Timestamptz{
			Time:  time.Now(),
			Valid: true,
		},
		UpdatedAt: pgtype.Timestamptz{
			Time:  time.Now(),
			Valid: true,
		},
		PassExpirationDate: pgtype.Timestamptz{
			Time:  time.Now().Add(365 * 24 * time.Hour),
			Valid: true,
		},
		Active:        true,
		EmailVerified: false,
	}

	err := r.db.CreateUser(context.Background(), params)
	return err
}
