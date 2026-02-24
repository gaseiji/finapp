package api

import (
	apiUsers "github.com/gaseiji/finapp/backend/api/user"
	"github.com/gaseiji/finapp/backend/domain/user"
	repositoryusers "github.com/gaseiji/finapp/backend/infrastructure/repository/user"
	"github.com/gaseiji/finapp/internal/database"
)

type APIConfig struct {
	UsersHandler *apiUsers.Handler
	DB           *database.Queries
}

func NewAPIConfig(db *database.Queries) *APIConfig {

	userRepository := repositoryusers.NewUserRepository(db)
	userService := user.NewUserService(userRepository)
	userHandler := apiUsers.NewHandler(userService)

	return &APIConfig{
		DB:           db,
		UsersHandler: userHandler,
	}
}
