MODULE  := $(shell go list -m)
BINARY  := worktree
BIN_DIR := bin

VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
COMMIT  := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
DATE    := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)

LDFLAGS := -s -w \
	-X '$(MODULE)/cmd.Version=$(VERSION)' \
	-X '$(MODULE)/cmd.Commit=$(COMMIT)' \
	-X '$(MODULE)/cmd.BuildDate=$(DATE)'

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z_/-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build binary to bin/
	go build -ldflags "$(LDFLAGS)" -o $(BIN_DIR)/$(BINARY) .

.PHONY: install
install: ## Install binary to GOPATH/bin
	go install -ldflags "$(LDFLAGS)" .

.PHONY: run
run: ## Run the application (pass ARGS="..." to forward arguments)
	go run . $(ARGS)

.PHONY: test
test: ## Run tests
	go test ./...

.PHONY: test/cover
test/cover: ## Run tests with coverage report
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report: coverage.html"

.PHONY: test/race
test/race: ## Run tests with race detector
	go test -race ./...

.PHONY: fmt
fmt: ## Format source code
	go fmt ./...

.PHONY: vet
vet: ## Run go vet
	go vet ./...

.PHONY: lint
lint: ## Run golangci-lint (requires golangci-lint installed)
	golangci-lint run ./...

.PHONY: tidy
tidy: ## Tidy and verify go modules
	go mod tidy
	go mod verify

.PHONY: clean
clean: ## Remove build artifacts and coverage files
	rm -f $(BIN_DIR)/$(BINARY) coverage.out coverage.html

.PHONY: check
check: fmt vet test ## Run fmt, vet, and tests
