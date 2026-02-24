package apiUsers

import (
	"encoding/json"
	"net/http"

	"github.com/gaseiji/finapp/backend/domain/user"
)

type Handler struct {
	Service *user.UserService
}

func NewHandler(service *user.UserService) *Handler {
	return &Handler{Service: service}
}

func (h *Handler) HandleCreateLogin(w http.ResponseWriter, r *http.Request) {
	var dto CreateUserDTO
	decoder := json.NewDecoder(r.Body)
	decoder.DisallowUnknownFields()
	if err := decoder.Decode(&dto); err != nil {
		http.Error(w, "bad request", http.StatusBadRequest)
		return
	}

	user := user.UserModel{
		Username: dto.Username,
		Email:    dto.Email,
		Password: dto.Password,
	}

	err := h.Service.CreateUser(user)
	if err != nil {
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("ok"))
}
