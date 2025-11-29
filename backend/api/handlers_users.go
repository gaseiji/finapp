package api

import (
	"net/http"
)

func (cfg *APIConfig) HandleLogin(w http.ResponseWriter, r *http.Request) {
	// read JSON body
	// validate input
	// insert transaction using cfg.DB
}
