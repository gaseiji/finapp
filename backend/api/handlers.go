package api

import (
	"net/http"
)

func (cfg *APIConfig) HandleFuncHealth(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("OK"))
}
