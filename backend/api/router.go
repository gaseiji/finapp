package api

import "net/http"

func (cfg *APIConfig) Router() *http.ServeMux {
	mux := http.NewServeMux()

	mux.HandleFunc("/users/login", cfg.UsersHandler.HandleCreateLogin)
	mux.HandleFunc("/health", cfg.HandleFuncHealth)

	return mux
}
