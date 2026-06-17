---
name: golang-backend
description: Expert Go backend development with Gin, Echo, Fiber, gRPC, concurrency patterns, Clean Architecture, Hexagonal (Ports & Adapters), SOLID, and cloud-native services
metadata:
  languages: go
  frameworks: gin,echo,fiber,grpc
  patterns: clean-architecture,hexagonal,solid,ddd
---

## What I do

I build production-grade Go backend services with idiomatic patterns and enterprise architecture:

- **Web Frameworks**: Gin, Echo, Fiber, Chi (stdlib-like routing)
- **gRPC**: Protocol Buffers, streaming, interceptors, service mesh integration
- **Concurrency**: Goroutines, channels, worker pools, sync primitives
- **Database**: GORM, sqlx, pgx, database/sql with connection pooling
- **Middleware**: Authentication, rate limiting, CORS, logging, recovery
- **Testing**: Table-driven tests, testify, mockgen, integration tests
- **Observability**: slog (structured logging), OpenTelemetry, Prometheus metrics
- **Tooling**: gofmt, goimports, golangci-lint, go generate
- **Cloud Native**: Docker, Kubernetes clients, health checks, graceful shutdown
- **Architecture**: Clean Architecture, Hexagonal (Ports & Adapters), SOLID

## When to use me

- Building new Go microservices or APIs
- Implementing gRPC services and clients
- Designing concurrent data processing pipelines
- Writing table-driven tests
- Setting up Go module projects
- Optimizing Go application performance
- Implementing graceful shutdown patterns
- Building CLI tools with cobra/urfave
- Refactoring to Clean Architecture

## SOLID in Go

### Single Responsibility
```go
// ❌ Bad: UserService does too much
type UserService struct{}
func (s *UserService) CreateUser(...) error { ... }
func (s *UserService) SendEmail(...) error { ... }
func (s *UserService) GenerateReport(...) error { ... }

// ✅ Good: Each type has one reason to change
type UserRegistrationService struct {
    userRepo  UserRepository
    emailSvc  EmailService
    eventBus  EventBus
}

func (s *UserRegistrationService) Execute(ctx context.Context, cmd CreateUserCommand) (*User, error) {
    user := NewUser(cmd.Name, cmd.Email)
    if err := s.userRepo.Save(ctx, user); err != nil {
        return nil, err
    }
    if err := s.emailSvc.SendWelcome(ctx, user.Email, user.Name); err != nil {
        return nil, err
    }
    return user, nil
}
```

### Interface Segregation
```go
// Small, focused interfaces (idiomatic Go)
type ReadRepository[T any] interface {
    FindByID(ctx context.Context, id string) (*T, error)
    FindAll(ctx context.Context, filter Filter) ([]*T, error)
}

type WriteRepository[T any] interface {
    Save(ctx context.Context, entity *T) error
    Delete(ctx context.Context, id string) error
}

type UserRepository interface {
    ReadRepository[User]
    WriteRepository[User]
    FindByEmail(ctx context.Context, email string) (*User, error)
}
```

### Dependency Inversion
```go
// High-level depends on abstractions
type CreateUserUseCase struct {
    userRepo  UserRepository       // Abstraction
    emailSvc  EmailService         // Abstraction
    eventBus  EventBus             // Abstraction
}

// Low-level implements abstractions
type PostgresUserRepository struct {
    db *sqlx.DB
}

func (r *PostgresUserRepository) FindByID(ctx context.Context, id string) (*User, error) {
    var model UserModel
    err := r.db.GetContext(ctx, &model, "SELECT * FROM users WHERE id = $1", id)
    if err != nil {
        return nil, err
    }
    return UserModelToDomain(&model), nil
}
```

## Clean Architecture (Go)

```
cmd/
├── server/
│   └── main.go                     # Entry point (wiring)
└── migrate/
    └── main.go

internal/
├── domain/                          # Enterprise Business Rules
│   ├── entity/
│   │   ├── user.go                  # Domain Entity
│   │   ├── order.go
│   │   └── value_object.go          # Value Objects (Email, Money)
│   ├── event/
│   │   ├── event.go                 # DomainEvent interface
│   │   ├── user_created.go
│   │   └── bus.go                   # EventBus interface
│   └── repository/
│       ├── user_repository.go       # Port (interface)
│       └── order_repository.go

├── application/                     # Application Business Rules
│   ├── usecase/
│   │   ├── create_user.go           # Use Case
│   │   ├── get_user.go
│   │   └── list_users.go
│   ├── dto/
│   │   ├── create_user.go           # Input DTO
│   │   └── user_response.go         # Output DTO
│   └── port/
│       └── event_publisher.go       # Output Port

├── infrastructure/                   # Frameworks & Drivers
│   ├── persistence/
│   │   ├── postgres/
│   │   │   ├── user_repository.go   # Adapter (implements port)
│   │   │   ├── user_model.go        # ORM model
│   │   │   └── unit_of_work.go
│   │   └── migration/
│   │       └── migrations/
│   ├── external/
│   │   ├── stripe_payment.go        # Payment Gateway adapter
│   │   └── ses_email.go             # Email Service adapter
│   ├── messaging/
│   │   ├── rabbitmq_publisher.go    # Event Publisher adapter
│   │   └── nats_publisher.go
│   └── config/
│       └── config.go                # Viper/env config

├── delivery/                         # Interface Adapters (Controllers)
│   ├── http/
│   │   ├── handler/
│   │   │   ├── user_handler.go      # Thin handler
│   │   │   └── middleware/
│   │   │       ├── auth.go
│   │   │       ├── cors.go
│   │   │       ├── logging.go
│   │   │       └── recovery.go
│   │   ├── router/
│   │   │   └── router.go
│   │   └── dto/
│   │       ├── request/
│   │       └── response/
│   └── grpc/
│       └── user_grpc.go

├── pkg/
│   ├── logger/
│   │   └── logger.go
│   ├── errors/
│   │   └── errors.go                # Custom error types
│   └── validator/
│       └── validator.go

├── go.mod
├── go.sum
├── Makefile
├── Dockerfile
└── .golangci.yml
```

### Main (Wiring)
```go
// cmd/server/main.go
func main() {
    cfg := config.Load()
    
    // Infrastructure
    db := postgres.NewConnection(cfg.Database)
    eventBus := nats.NewPublisher(cfg.NATS)
    
    // Repositories (Adapters)
    userRepo := postgres.NewUserRepository(db)
    emailSvc := ses.NewEmailService(cfg.AWS)
    
    // Use Cases
    createUserUseCase := usecase.NewCreateUserUseCase(userRepo, emailSvc, eventBus)
    getUserUseCase := usecase.NewGetUserUseCase(userRepo)
    
    // HTTP Handlers (Controllers)
    userHandler := handler.NewUserHandler(createUserUseCase, getUserUseCase)
    
    // Router
    router := router.NewRouter(userHandler, cfg.CORS)
    
    // Server
    srv := &http.Server{
        Addr:         cfg.Port,
        Handler:      router,
        ReadTimeout:  cfg.ReadTimeout,
        WriteTimeout: cfg.WriteTimeout,
    }
    
    // Graceful shutdown
    log.Info("starting server", "port", cfg.Port)
    if err := srv.ListenAndServe(); err != http.ErrServerClosed {
        log.Fatal("server failed", err)
    }
}
```

## Concurrency Patterns

### Worker Pool
```go
type WorkerPool[T any] struct {
    jobs    chan T
    results chan Result[T]
    workers int
}

func NewWorkerPool[T any](workers int, jobCount int) *WorkerPool[T] {
    return &WorkerPool[T]{
        jobs:    make(chan T, jobCount),
        results: make(chan Result[T], jobCount),
        workers: workers,
    }
}

func (wp *WorkerPool[T]) Start(ctx context.Context, fn func(context.Context, T) (any, error)) {
    var wg sync.WaitGroup
    for i := 0; i < wp.workers; i++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for job := range wp.jobs {
                result, err := fn(ctx, job)
                wp.results <- Result[T]{Value: result, Err: err}
            }
        }()
    }
    go func() {
        wg.Wait()
        close(wp.results)
    }()
}
```

### errgroup for Concurrent Error Handling
```go
import "golang.org/x/sync/errgroup"

func (s *OrderService) ProcessOrder(ctx context.Context, order *Order) error {
    g, ctx := errgroup.WithContext(ctx)
    
    g.Go(func() error {
        return s.inventory.Reserve(ctx, order.Items)
    })
    
    g.Go(func() error {
        return s.payment.Charge(ctx, order.Total)
    })
    
    g.Go(func() error {
        return s.notification.Send(ctx, order.UserID, "Order confirmed")
    })
    
    return g.Wait() // Returns first error, cancels other goroutines
}
```

### Graceful Shutdown
```go
func GracefulShutdown(ctx context.Context, srv *http.Server, timeout time.Duration) {
    shutdownCtx, cancel := context.WithTimeout(ctx, timeout)
    defer cancel()
    
    if err := srv.Shutdown(shutdownCtx); err != nil {
        log.Error("server forced to shutdown", err)
    }
    
    log.Info("server exiting")
}
```

## Best Practices

### Code Quality
- Follow Go conventions: camelCase, no unused imports, short variable names
- Use `gofmt` and `goimports` for formatting
- Run `golangci-lint` with extensive linter config
- Handle errors explicitly; never use `_` for errors
- Use `errors.Is()` and `errors.As()` for error comparison
- Wrap errors with `fmt.Errorf("context: %w", err)`

### Architecture
- Accept interfaces, return structs
- Use `internal/` for private packages
- Keep packages small and focused
- Use dependency injection via constructors
- **Dependency Rule**: domain/ NEVER imports from infrastructure/

### HTTP APIs
- Use `chi` or standard library for routing when possible
- Implement proper HTTP status codes
- Use `json.NewEncoder` for streaming responses
- Validate request bodies with struct tags or `go-playground/validator`
- Implement idempotency keys for write operations

### Database
- Use `sqlx` for query building or `pgx` for PostgreSQL
- Always use parameterized queries
- Implement connection pooling with `SetMaxOpenConns`
- Use database transactions for multi-step operations
- Run migrations with `golang-migrate`

### Testing
- Table-driven tests for all scenarios
- Use `testify` for assertions
- Mock at interface boundaries with `mockgen`
- Integration tests with real database
- Benchmark tests for performance-critical code
