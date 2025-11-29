package api

import (
	"net/http"
)

func (cfg *APIConfig) HandleCreateTransaction(w http.ResponseWriter, r *http.Request) {
	// read JSON body
	// validate input
	// insert transaction using cfg.DB
}
