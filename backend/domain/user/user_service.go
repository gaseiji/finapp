package user

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"fmt"
	"strings"

	"golang.org/x/crypto/argon2"
)

type UserService struct {
	Repository UserRepository
}

func NewUserService(repository UserRepository) *UserService {
	return &UserService{Repository: repository}
}

func (s *UserService) CreateUser(u UserModel) error {
	hashedPassword, err := s.HashPassword(u.Password)
	if err != nil {
		return err
	}

	u.Password = hashedPassword
	return s.Repository.CreateUserFunc(u)

}

func (s *UserService) HashPassword(password string) (string, error) {

	salt := make([]byte, 16)
	_, err := rand.Read(salt)
	if err != nil {
		return "", err
	}

	time := uint32(1)
	memory := uint32(64 * 1024)
	threads := uint8(4)
	keyLen := uint32(32)

	hash := argon2.IDKey([]byte(password), salt, time, memory, threads, keyLen)

	encoded := fmt.Sprintf("%s.%s",
		base64.RawStdEncoding.EncodeToString(salt),
		base64.RawStdEncoding.EncodeToString(hash),
	)

	return encoded, nil

}

func (s *UserService) VerifyPassword(password, encodedHash string) (bool, error) {

	parts := strings.Split(encodedHash, ".")
	if len(parts) != 2 {
		return false, fmt.Errorf("hash inválido")
	}

	salt, err := base64.RawStdEncoding.DecodeString(parts[0])
	if err != nil {
		return false, fmt.Errorf("falha ao decodificar salt: %w", err)
	}

	hash, err := base64.RawStdEncoding.DecodeString(parts[1])
	if err != nil {
		return false, fmt.Errorf("falha ao decodificar hash: %w", err)
	}

	time := uint32(1)
	memory := uint32(64 * 1024)
	threads := uint8(4)
	keyLen := uint32(32)

	testHash := argon2.IDKey([]byte(password), salt, time, memory, threads, keyLen)

	if subtle.ConstantTimeCompare(hash, testHash) == 1 {
		return true, nil
	}

	return false, nil
}
