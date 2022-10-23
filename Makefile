PROJECT=go-grpc-auth-svc
GH_USER=mkm29

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

init: ## Initialize the project
	@echo "Initializing the project"
	@go mod init github.com/$(GH_USER)/$(PROJECT)

bootstrap: ## Setup project
	@echo "Setting up the project"
	go get github.com/spf13/viper
	go get google.golang.org/grpc
	go get gorm.io/gorm
	go get gorm.io/driver/postgres
	go get golang.org/x/crypto/bcrypt
	go get github.com/golang-jwt/jwt
	mkdir -p cmd pkg/config/envs pkg/db pkg/models pkg/pb pkg/services pkg/utils
	touch cmd/main.go pkg/config/envs/dev.env pkg/config/config.go
	touch pkg/pb/auth.proto pkg/db/db.go pkg/models/auth.go pkg/services/auth.go pkg/utils/hash.go pkg/utils/jwt.go

build: ## Build the project
	@echo "Building the project"
	@go build -o bin/$(PROJECT) cmd/main.go

proto: ## Generate proto files
	buf generate buf.build/smigula/auth

server: ## Run server
	go run cmd/main.go


# https://stackoverflow.com/questions/71777702/service-compiling-successfully-but-message-structs-not-generating-grpc-go