---
name: python-backend
description: Expert Python backend development with FastAPI, Django, Flask, SQLAlchemy, Pydantic, Clean Architecture, Hexagonal (Ports & Adapters), SOLID, async patterns, testing, and production best practices
metadata:
  languages: python
  frameworks: fastapi,django,flask
  patterns: clean-architecture,hexagonal,solid,cqrs
---

## What I do

I build production-grade Python backends using modern patterns and enterprise architecture:

- **FastAPI**: Async REST APIs with automatic OpenAPI docs, dependency injection, background tasks
- **Django**: Full-featured applications with ORM, admin, signals, middleware
- **Flask**: Lightweight microservices and APIs
- **SQLAlchemy**: ORM with async support, relationship mapping, query optimization
- **Pydantic v2**: Strict data validation, serialization, settings management
- **Async Python**: asyncio, async/await, connection pooling, async SQLAlchemy
- **Testing**: pytest, fixtures, factories, async test clients, coverage
- **Tooling**: Poetry/uv, ruff, mypy, pre-commit hooks
- **Logging**: Structured logging with structlog, correlation IDs
- **Architecture**: Clean Architecture, Hexagonal (Ports & Adapters), SOLID, CQRS
- **Domain-Driven Design**: Entities, Value Objects, Aggregates, Domain Events

## When to use me

- Building new Python API services or microservices
- Migrating Flask/Django apps to FastAPI
- Designing database models and migrations
- Implementing authentication and authorization
- Writing tests for existing Python backends
- Optimizing Python application performance
- Setting up Python project structure from scratch
- Debugging async Python issues
- Refactoring monoliths to Clean Architecture
- Implementing CQRS with event sourcing

## SOLID Principles (Python)

### Single Responsibility
```python
# ❌ Bad: UserService does too much
class UserService:
    def create_user(self, data): ...
    def send_welcome_email(self, user): ...
    def generate_report(self, user): ...

# ✅ Good: Each class has one reason to change
class UserRegistrationService:
    def __init__(self, user_repo: UserRepository, email_service: EmailService):
        self._user_repo = user_repo
        self._email_service = email_service
    
    async def execute(self, data: CreateUserDTO) -> User:
        user = User.create(name=data.name, email=data.email)
        await self._user_repo.save(user)
        await self._email_service.send_welcome(user.email, user.name)
        return user
```

### Open/Closed
```python
# Open for extension, closed for modification
class PaymentProcessor(Protocol):
    async def process(self, amount: Money) -> PaymentResult: ...

class StripeProcessor:
    async def process(self, amount: Money) -> PaymentResult: ...

class PixProcessor:
    async def process(self, amount: Money) -> PaymentResult: ...

class OrderService:
    def __init__(self, payment: PaymentProcessor):
        self._payment = payment
    
    async def checkout(self, order: Order) -> None:
        await self._payment.process(order.total)
```

### Liskov Substitution
```python
# All implementations must be substitutable
class ReadRepository(Protocol[T]):
    async def find_by_id(self, id: str) -> Optional[T]: ...
    async def find_all(self, filters: Filter) -> list[T]: ...

class PostgresUserRepository:
    async def find_by_id(self, id: str) -> Optional[User]: ...
    async def find_all(self, filters: Filter) -> list[User]: ...

class InMemoryUserRepository:  # Test double - same interface
    async def find_by_id(self, id: str) -> Optional[User]: ...
    async def find_all(self, filters: Filter) -> list[User]: ...
```

### Interface Segregation
```python
# Small, focused interfaces
class ReadRepository(Protocol[T]):
    async def find_by_id(self, id: str) -> Optional[T]: ...

class WriteRepository(Protocol[T]):
    async def save(self, entity: T) -> None: ...
    async def delete(self, id: str) -> None: ...

class UserRepository(ReadRepository[T], WriteRepository[T], Protocol): ...
```

### Dependency Inversion
```python
# High-level module depends on abstraction
class CreateUserUseCase:
    def __init__(
        self,
        user_repo: UserRepository,      # Abstraction (Protocol)
        email_service: EmailService,     # Abstraction (Protocol)
        event_bus: EventBus,             # Abstraction (Protocol)
    ):
        self._user_repo = user_repo
        self._email_service = email_service
        self._event_bus = event_bus

# Low-level modules implement abstractions
class SQLAlchemyUserRepository:
    def __init__(self, session: AsyncSession):
        self._session = session
    
    async def find_by_id(self, id: str) -> Optional[User]:
        result = await self._session.execute(
            select(UserModel).where(UserModel.id == id)
        )
        model = result.scalar_one_or_none()
        return UserMapper.to_domain(model) if model else None
```

## Clean Architecture (Python Implementation)

```
src/
├── domain/                          # Enterprise Business Rules
│   ├── __init__.py
│   ├── entities/
│   │   ├── __init__.py
│   │   ├── user.py                  # Domain Entity
│   │   └── order.py
│   ├── value_objects/
│   │   ├── __init__.py
│   │   ├── email.py                 # Value Object (immutable)
│   │   ├── money.py
│   │   └── user_id.py
│   ├── aggregates/
│   │   └── order_aggregate.py       # Aggregate Root
│   ├── events/
│   │   ├── __init__.py
│   │   ├── base.py                  # DomainEvent base class
│   │   ├── user_created.py
│   │   └── order_placed.py
│   ├── exceptions/
│   │   ├── __init__.py
│   │   └── domain.py               # DomainException hierarchy
│   └── interfaces/                   # Ports (Abstractions)
│       ├── __init__.py
│       ├── repositories/
│       │   ├── __init__.py
│       │   ├── user_repository.py   # Input/Output Port
│       │   └── order_repository.py
│       └── services/
│           ├── __init__.py
│           ├── email_service.py
│           └── payment_gateway.py
│
├── application/                     # Application Business Rules
│   ├── __init__.py
│   ├── use_cases/
│   │   ├── __init__.py
│   │   ├── create_user.py           # Use Case (orchestration)
│   │   ├── get_user.py
│   │   ├── list_users.py
│   │   └── delete_user.py
│   ├── dto/
│   │   ├── __init__.py
│   │   ├── create_user_dto.py       # Input DTO
│   │   └── user_response_dto.py     # Output DTO
│   ├── mappers/
│   │   ├── __init__.py
│   │   └── user_mapper.py           # Entity ↔ DTO mapping
│   └── ports/                       # Output Port interfaces
│       ├── __init__.py
│       └── event_publisher.py
│
├── infrastructure/                   # Frameworks & Drivers
│   ├── __init__.py
│   ├── persistence/
│   │   ├── __init__.py
│   │   ├── repositories/
│   │   │   ├── __init__.py
│   │   │   └── user_repository.py   # Adapter (implements port)
│   │   ├── models/
│   │   │   ├── __init__.py
│   │   │   └── user_model.py        # SQLAlchemy model
│   │   ├── mappers/
│   │   │   ├── __init__.py
│   │   │   └── user_mapper.py       # ORM ↔ Domain mapper
│   │   └── unit_of_work.py          # Transaction management
│   ├── external/
│   │   ├── __init__.py
│   │   ├── stripe_payment.py        # Payment Gateway adapter
│   │   └── ses_email.py             # Email Service adapter
│   ├── messaging/
│   │   ├── __init__.py
│   │   ├── rabbitmq_publisher.py    # Event Publisher adapter
│   │   └── rabbitmq_consumer.py
│   └── config/
│       ├── __init__.py
│       ├── settings.py              # Pydantic Settings
│       └── dependencies.py          # DI container setup
│
├── presentation/                    # Interface Adapters
│   ├── __init__.py
│   ├── api/
│   │   ├── __init__.py
│   │   ├── v1/
│   │   │   ├── __init__.py
│   │   │   ├── routes/
│   │   │   │   ├── __init__.py
│   │   │   │   ├── users.py        # Thin controller
│   │   │   │   └── router.py
│   │   │   └── dependencies.py     # Route-level DI
│   │   └── schemas/
│   │       ├── __init__.py
│   │       ├── request/
│   │       │   └── user.py          # Pydantic request schemas
│   │       └── response/
│   │           └── user.py          # Pydantic response schemas
│   ├── middleware/
│   │   ├── __init__.py
│   │   ├── error_handler.py         # Global error handling
│   │   ├── correlation_id.py        # Request correlation
│   │   └── logging.py               # Request logging
│   └── presenters/
│       ├── __init__.py
│       └── user_presenter.py        # Format output
│
├── tests/
│   ├── conftest.py
│   ├── factories.py
│   ├── unit/
│   │   ├── domain/
│   │   │   └── test_user.py
│   │   └── use_cases/
│   │       └── test_create_user.py
│   ├── integration/
│   │   └── repositories/
│   │       └── test_user_repository.py
│   └── e2e/
│       └── test_users_api.py
│
├── alembic/
│   ├── env.py
│   └── versions/
├── alembic.ini
├── pyproject.toml
├── ruff.toml
└── mypy.ini
```

## Hexagonal (Ports & Adapters) in Python

### Domain Layer (Core)
```python
# domain/entities/user.py
from dataclasses import dataclass
from domain.value_objects.email import Email
from domain.value_objects.user_id import UserID
from domain.events.user_created import UserCreated

@dataclass
class User:
    id: UserID
    name: str
    email: Email
    _events: list = field(default_factory=list, repr=False)
    
    @classmethod
    def create(cls, name: str, email: str) -> "User":
        user = cls(
            id=UserID.generate(),
            name=name,
            email=Email(email),
        )
        user._events.append(UserCreated(
            aggregate_id=str(user.id),
            name=user.name,
            email=str(user.email),
        ))
        return user
    
    def change_email(self, new_email: str) -> None:
        self.email = Email(new_email)
        # Domain event for CQRS read model update
```

### Ports (Interfaces)
```python
# domain/interfaces/repositories/user_repository.py
from typing import Protocol, Optional
from domain.entities.user import User

class UserRepository(Protocol):
    async def find_by_id(self, id: str) -> Optional[User]: ...
    async def find_by_email(self, email: str) -> Optional[User]: ...
    async def save(self, user: User) -> None: ...
    async def delete(self, id: str) -> None: ...

# domain/interfaces/services/email_service.py
from typing import Protocol
from domain.value_objects.email import Email

class EmailService(Protocol):
    async def send_welcome(self, to: Email, name: str) -> None: ...
    async def send_notification(self, to: Email, subject: str, body: str) -> None: ...
```

### Adapters (Implementation)
```python
# infrastructure/persistence/repositories/user_repository.py
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from domain.entities.user import User
from infrastructure.persistence.models.user_model import UserModel
from infrastructure.persistence.mappers.user_mapper import UserMapper

class SQLAlchemyUserRepository:
    def __init__(self, session: AsyncSession):
        self._session = session
    
    async def find_by_id(self, id: str) -> Optional[User]:
        result = await self._session.execute(
            select(UserModel).where(UserModel.id == id)
        )
        model = result.scalar_one_or_none()
        return UserMapper.to_domain(model) if model else None
    
    async def save(self, user: User) -> None:
        model = UserMapper.to_persistence(user)
        self._session.add(model)
        await self._session.flush()
```

### Dependency Injection
```python
# presentation/api/v1/dependencies.py
from functools import lru_cache
from infrastructure.persistence.unit_of_work import SQLAlchemyUnitOfWork
from infrastructure.external.ses_email import SESEmailService
from application.use_cases.create_user import CreateUserUseCase

@lru_cache
def get_create_user_use_case() -> CreateUserUseCase:
    uow = SQLAlchemyUnitOfWork()
    email_service = SESEmailService()
    return CreateUserUseCase(
        user_repo=uow.get_repository("user"),
        email_service=email_service,
        event_bus=get_event_bus(),
    )

# Thin controller
@router.post("/users", response_model=UserResponse, status_code=201)
async def create_user(
    body: CreateUserRequest,
    use_case: CreateUserUseCase = Depends(get_create_user_use_case),
):
    user = await use_case.execute(UserMapper.to_input(body))
    return UserMapper.to_response(user)
```

## Unit of Work Pattern
```python
# infrastructure/persistence/unit_of_work.py
from contextlib import asynccontextmanager
from sqlalchemy.ext.asyncio import AsyncSession

class SQLAlchemyUnitOfWork:
    def __init__(self, session_factory):
        self._session_factory = session_factory
        self._session: Optional[AsyncSession] = None
        self._repositories: dict = {}
    
    async def __aenter__(self):
        self._session = self._session_factory()
        return self
    
    async def __aexit__(self, exc_type, exc_val, exc_tb):
        if exc_type:
            await self.rollback()
        else:
            await self.commit()
        await self._session.close()
    
    def get_repository(self, name: str):
        if name not in self._repositories:
            if name == "user":
                self._repositories[name] = SQLAlchemyUserRepository(self._session)
            elif name == "order":
                self._repositories[name] = SQLAlchemyOrderRepository(self._session)
        return self._repositories[name]
    
    async def commit(self):
        await self._session.commit()
    
    async def rollback(self):
        await self._session.rollback()

# Usage
async with SQLAlchemyUnitOfWork(session_factory) as uow:
    user_repo = uow.get_repository("user")
    await user_repo.save(user)
    # Auto-commits on success, auto-rollbacks on exception
```

## Best Practices

### Code Quality
- Use type hints everywhere; enable `mypy --strict`
- Prefer `dataclasses` or Pydantic models over raw dicts
- Use `ruff` for linting and formatting (replaces black, isort, flake8)
- Follow PEP 8 with 88-char line length (black default)
- Use `from __future__ import annotations` for forward references

### Architecture
- **Dependency Rule**: Domain layer NEVER imports from infrastructure/presentation
- **Use Case Pattern**: Each business operation = one use case class
- **Protocol for Ports**: Use `typing.Protocol` for port interfaces
- Keep route handlers THIN (1-3 lines max)
- Business logic lives in use cases, NOT in controllers

### Async Patterns
- Use `async def` for I/O-bound handlers; `def` for CPU-bound
- Never block the event loop; use `asyncio.to_thread()` for sync code
- Use async SQLAlchemy sessions (`AsyncSession`)
- Implement proper connection pooling with `asyncpg`/`aiomysql`

### Testing
- Aim for 80%+ coverage on business logic
- Use `pytest-asyncio` for async tests
- Create factories with `factory_boy` or `polyfactory`
- Test error paths, not just happy paths
- Use `httpx.AsyncClient` for FastAPI test client
- Mock at PORT boundaries (not implementation details)

### Security
- Use `pydantic-settings` for secret management
- Never log secrets or tokens
- Use `python-jose` or `PyJWT` for JWT tokens
- Implement rate limiting with `slowapi`
- Validate and sanitize all inputs
