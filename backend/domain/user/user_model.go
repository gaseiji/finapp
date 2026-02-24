package user

type UserModel struct {
	Username string
	Email    string
	Password string
}

type UserRepository interface {
	CreateUserFunc(user UserModel) error
}
