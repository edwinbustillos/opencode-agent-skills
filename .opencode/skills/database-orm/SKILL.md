---
name: database-orm
description: Expert database design with SQL/NoSQL, ORMs (Prisma, SQLAlchemy, Hibernate, GORM, Drizzle), Repository pattern, Unit of Work, DDD aggregates, Data Mapper vs Active Record, migrations, indexing, query optimization, and data modeling
metadata:
  databases: postgresql,mysql,mongodb,redis
  orms: prisma,sqlalchemy,hibernate,gorm,drizzle
  patterns: repository,unit-of-work,data-mapper,ddd
---

## What I do

I design and optimize database schemas with modern ORMs and enterprise patterns:

- **PostgreSQL**: Advanced features (JSONB, CTEs, window functions, full-text search)
- **MySQL/MariaDB**: InnoDB, indexing, query optimization
- **MongoDB**: Document design, aggregation pipeline, change streams
- **Redis**: Caching, pub/sub, data structures, session storage
- **Prisma**: Type-safe queries, migrations, client generation
- **SQLAlchemy**: Async ORM, relationship mapping, query optimization
- **Hibernate/JPA**: Entity mapping, caching strategies, query tuning
- **GORM**: Go ORM patterns, associations, hooks
- **Drizzle**: TypeScript-first SQL builder, type safety
- **Repository Pattern**: Abstraction over data access
- **Unit of Work**: Transaction management
- **DDD**: Aggregates, Value Objects, Domain Events
- **Data Mapper vs Active Record**: Choosing the right pattern
- **Migrations**: Version control, zero-downtime migrations, rollback strategies
- **Performance**: Indexing strategies, EXPLAIN ANALYZE, query optimization

## When to use me

- Designing database schemas from scratch
- Optimizing slow database queries
- Implementing database migrations
- Setting up ORM configurations
- Designing indexing strategies
- Implementing data modeling patterns (3NF, denormalization)
- Setting up replication and failover
- Debugging N+1 query problems
- Choosing between Data Mapper and Active Record
- Implementing Repository and Unit of Work patterns

## Repository Pattern

### Interface Definition
```typescript
// Read-only operations
interface ReadRepository<T, ID> {
  findById(id: ID): Promise<T | null>;
  findByIds(ids: ID[]): Promise<T[]>;
  findAll(spec?: Specification<T>): Promise<T[]>;
  count(spec?: Specification<T>): Promise<number>;
  exists(id: ID): Promise<boolean>;
}

// Write operations
interface WriteRepository<T, ID> {
  save(entity: T): Promise<T>;
  saveAll(entities: T[]): Promise<T[]>;
  delete(id: ID): Promise<void>;
  deleteAll(ids: ID[]): Promise<void>;
}

// Full repository
interface Repository<T, ID> extends ReadRepository<T, ID>, WriteRepository<T, ID> {}

// Specialized repositories
interface UserRepository extends Repository<User, string> {
  findByEmail(email: string): Promise<User | null>;
  findByStatus(status: UserStatus): Promise<User[]>;
}
```

### Specification Pattern (for flexible queries)
```typescript
interface Specification<T> {
  isSatisfiedBy(entity: T): boolean;
  toQuery(): QueryObject;
}

class EmailSpecification implements Specification<User> {
  constructor(private email: string) {}
  
  isSatisfiedBy(user: User): boolean {
    return user.email === this.email;
  }
  
  toQuery() {
    return { email: this.email };
  }
}

class AndSpecification<T> implements Specification<T> {
  constructor(
    private left: Specification<T>,
    private right: Specification<T>,
  ) {}

  isSatisfiedBy(entity: T): boolean {
    return this.left.isSatisfiedBy(entity) && this.right.isSatisfiedBy(entity);
  }
}

// Usage
const spec = new AndSpecification(
  new EmailSpecification('user@example.com'),
  new StatusSpecification('active'),
);
const user = await userRepo.findOne(spec);
```

## Unit of Work Pattern

### Interface
```typescript
interface UnitOfWork {
  getRepository<T>(entityClass: new (...args: any[]) => T): Repository<T, any>;
  commit(): Promise<void>;
  rollback(): Promise<void>;
  runInTransaction<T>(fn: () => Promise<T>): Promise<T>;
}
```

### Implementation (Prisma)
```typescript
class PrismaUnitOfWork implements UnitOfWork {
  private repositories = new Map<string, Repository<any, any>>();
  private tx: PrismaClient | null = null;

  constructor(private readonly prisma: PrismaService) {}

  async runInTransaction<T>(fn: () => Promise<T>): Promise<T> {
    return this.prisma.$transaction(async (tx) => {
      this.tx = tx;
      try {
        const result = await fn();
        await this.commit();
        return result;
      } catch (error) {
        await this.rollback();
        throw error;
      }
    });
  }

  getRepository<T>(entityClass: new (...args: any[]) => T): Repository<T, any> {
    const name = entityClass.name;
    if (!this.repositories.has(name)) {
      this.repositories.set(name, this.createRepository(name));
    }
    return this.repositories.get(name)!;
  }
}

// Usage
const uow = new PrismaUnitOfWork(prisma);
await uow.runInTransaction(async () => {
  const userRepo = uow.getRepository(User);
  const orderRepo = uow.getRepository(Order);
  
  const user = await userRepo.findById('user-1');
  const order = Order.create(user, items);
  await orderRepo.save(order);
});
// Auto-commits on success, auto-rollbacks on error
```

### Implementation (SQLAlchemy)
```python
class SQLAlchemyUnitOfWork:
    def __init__(self, session_factory):
        self._session_factory = session_factory
        self._session: Optional[AsyncSession] = None

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
        if name == "user":
            return SQLAlchemyUserRepository(self._session)
        if name == "order":
            return SQLAlchemyOrderRepository(self._session)
        raise ValueError(f"Unknown repository: {name}")

    async def commit(self):
        await self._session.commit()

    async def rollback(self):
        await self._session.rollback()
```

## Data Mapper vs Active Record

### Active Record
- Entity contains persistence logic (save, find, delete)
- Simpler for CRUD applications
- Tight coupling between domain and database
- Examples: Django ORM, Rails ActiveRecord, Sequelize

```typescript
// Active Record pattern
class User extends Model {
  id: string;
  name: string;
  email: string;

  static async findByEmail(email: string): Promise<User | null> {
    return User.findOne({ where: { email } });
  }

  async save(): Promise<void> {
    await super.save();
  }
}
```

### Data Mapper
- Separate mapper between domain and database
- Domain entities are persistence-ignorant
- Better for complex domain logic
- Examples: Hibernate, SQLAlchemy, Prisma (via repository)

```typescript
// Data Mapper pattern
class User {
  constructor(
    public readonly id: UserID,
    public name: string,
    public email: Email,
  ) {}
}

// Separate mapper
class UserMapper {
  static toDomain(model: UserModel): User {
    return new User(
      new UserID(model.id),
      model.name,
      new Email(model.email),
    );
  }

  static toPersistence(user: User): UserModel {
    return {
      id: user.id.value,
      name: user.name,
      email: user.email.value,
    };
  }
}

// Repository uses mapper
class PrismaUserRepository implements UserRepository {
  async findById(id: string): Promise<User | null> {
    const model = await this.prisma.user.findUnique({ where: { id } });
    return model ? UserMapper.toDomain(model) : null;
  }

  async save(user: User): Promise<void> {
    const model = UserMapper.toPersistence(user);
    await this.prisma.user.upsert({
      where: { id: model.id },
      create: model,
      update: model,
    });
  }
}
```

### Comparison

| Aspect | Active Record | Data Mapper |
|--------|---------------|-------------|
| Complexity | Low | High |
| Domain Logic | In entity | In domain classes |
| Testability | Hard (DB dependency) | Easy (mock repositories) |
| Persistence Ignorance | No | Yes |
| Best For | Simple CRUD | Complex domains |
| Examples | Django, Rails | Hibernate, SQLAlchemy |

## DDD Aggregates

### Aggregate Root
```typescript
class Order {
  private _items: OrderItem[] = [];
  private _status: OrderStatus = OrderStatus.PENDING;

  constructor(
    public readonly id: OrderID,
    public readonly userId: UserID,
    items: OrderItem[],
  ) {
    if (items.length === 0) {
      throw new DomainException('Order must have at least one item');
    }
    this._items = [...items];
  }

  get items(): ReadonlyArray<OrderItem> {
    return [...this._items];
  }

  get status(): OrderStatus {
    return this._status;
  }

  addItem(product: Product, quantity: number): void {
    if (this._status !== OrderStatus.PENDING) {
      throw new DomainException('Cannot add items to non-pending order');
    }
    const existing = this._items.find(i => i.productId === product.id);
    if (existing) {
      existing.increaseQuantity(quantity);
    } else {
      this._items.push(new OrderItem(product.id, quantity, product.price));
    }
  }

  confirm(): void {
    if (this._status !== OrderStatus.PENDING) {
      throw new DomainException('Only pending orders can be confirmed');
    }
    this._status = OrderStatus.CONFIRMED;
  }
}
```

### Value Objects
```typescript
class Email {
  private constructor(private readonly value: string) {}

  static create(email: string): Email {
    if (!Email.isValid(email)) {
      throw new InvalidEmailException(email);
    }
    return new Email(email.toLowerCase().trim());
  }

  private static isValid(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  equals(other: Email): boolean {
    return this.value === other.value;
  }

  toString(): string {
    return this.value;
  }
}
```

## Schema Design

### Best Practices
- Normalize to 3NF; denormalize only with clear performance justification
- Use UUIDs (v7 for sortability) instead of auto-increment IDs
- Add `created_at`, `updated_at`, `deleted_at` (soft delete) timestamps
- Use CHECK constraints for data validation
- Design for zero-downtime migrations

### Indexing
- Index foreign keys (not always automatic)
- Use composite indexes for multi-column queries
- Index columns used in WHERE, JOIN, ORDER BY
- Use partial indexes for filtered queries (PostgreSQL)
- Monitor unused indexes with `pg_stat_user_indexes`

### Migrations
- Every schema change gets a migration file
- Never modify existing migrations; create new ones
- Test migrations up AND down
- Use additive migrations for zero-downtime deploys
- Separate destructive changes into separate migrations

### Query Optimization
- Use EXPLAIN ANALYZE to understand query plans
- Avoid SELECT *; select only needed columns
- Use JOINs instead of subqueries when possible
- Implement pagination (cursor-based for large datasets)
- Use connection pooling (pgbouncer, HikariCP)

### ORM Best Practices
- Use lazy loading judiciously (watch for N+1)
- Eager load relationships when needed with joins
- Use batch operations for bulk inserts/updates
- Implement repository pattern for data access
- Use transactions for multi-step operations
- **Never expose ORM entities directly in API responses** (use DTOs)

### Data Types
- Use `TEXT` for variable-length strings (PostgreSQL)
- Use `TIMESTAMPTZ` for timestamps (never `TIMESTAMP`)
- Use `JSONB` over `JSON` for queryable JSON (PostgreSQL)
- Use `NUMERIC` for money (never `FLOAT`)
- Use enums with custom types (PostgreSQL) or lookup tables

## Project Structure

```
db/
├── migrations/
│   ├── 001_initial_schema.sql
│   ├── 002_add_user_email_index.sql
│   └── 003_create_posts_table.sql
├── seeds/
│   ├── seed.sql
│   └── factories/
├── schemas/
│   ├── users.sql
│   └── posts.sql
├── indexes/
│   └── performance_indexes.sql
└── docs/
    ├── erd.png
    └── data-dictionary.md
src/
├── domain/
│   ├── entities/
│   │   ├── user.ts
│   │   └── order.ts
│   ├── value-objects/
│   │   ├── email.ts
│   │   └── money.ts
│   └── interfaces/
│       └── repositories/
│           ├── user.repository.ts    # Port
│           └── order.repository.ts
├── infrastructure/
│   ├── persistence/
│   │   ├── prisma/
│   │   │   ├── schema.prisma
│   │   │   ├── user.repository.ts   # Adapter
│   │   │   └── user.mapper.ts
│   │   ├── sqlalchemy/
│   │   │   ├── models.py
│   │   │   └── repository.py
│   │   └── unit-of-work.ts
│   └── config/
│       └── database.ts
├── application/
│   └── use-cases/
│       ├── create-user.use-case.ts
│       └── get-user.use-case.ts
└── presentation/
    └── controllers/
        └── user.controller.ts
```
