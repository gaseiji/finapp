package user

import (
	"testing"
)

type fakeRepo struct{}

func (f *fakeRepo) CreateUserFunc(user UserModel) error {
	return nil
}

func TestHashAndVerifyPassword(t *testing.T) {

	repo := &fakeRepo{}
	service := NewUserService(repo)

	password := "myPass.123"

	// Testa HashPassword
	hashed, err := service.HashPassword(password)
	if err != nil {
		t.Fatalf("error gen hash: %v", err)
	}

	if hashed == "" {
		t.Fatalf("hash empty")
	}

	// Testa VerifyPassword com senha correta
	ok, err := service.VerifyPassword(password, hashed)
	if err != nil {
		t.Fatalf("err invalid passoword: %v", err)
	}

	if !ok {
		t.Fatalf("err correct password not verified")
	}

	// Testa VerifyPassword com senha incorreta
	ok, err = service.VerifyPassword("worng.Pass", hashed)
	if err != nil {
		t.Fatalf("err verifying wrong pass: %v", err)
	}

	if ok {
		t.Fatalf("incorrent password verified as correct")
	}
}
