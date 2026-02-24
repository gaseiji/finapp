package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gaseiji/finapp/backend/api"
	"github.com/gaseiji/finapp/internal/database"
	"github.com/jackc/pgx/v5/pgxpool"

	"github.com/joho/godotenv"
)

func main() {

	godotenv.Load()
	dbURL := os.Getenv("GOOSE_DBSTRING")

	pool, err := pgxpool.New(context.Background(), dbURL)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
		os.Exit(1)
	}
	defer pool.Close()

	dbQueries := database.New(pool)
	cfg := api.APIConfig{DB: dbQueries}

	srv := &http.Server{
		Addr:    ":8080",
		Handler: cfg.Router(), // simple and clean
	}

	log.Println("Server running on :8080")
	srv.ListenAndServe()
}
