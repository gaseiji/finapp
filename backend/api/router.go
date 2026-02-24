package api

import "net/http"

func (cfg *APIConfig) Router() *http.ServeMux {
	mux := http.NewServeMux()

	mux.HandleFunc("/transactions", cfg.HandleCreateTransaction)
	mux.HandleFunc("/users/login", cfg.HandleLogin)
	mux.HandleFunc("/health", cfg.HandleFuncHealth)

	return mux
}
