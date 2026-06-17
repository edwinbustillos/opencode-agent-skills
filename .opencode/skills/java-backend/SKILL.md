---
name: java-backend
description: Expert Java backend development with Spring Boot, Jakarta EE, Hibernate, Maven/Gradle, Hexagonal Architecture, CQRS, DDD, SOLID, and enterprise patterns
metadata:
  languages: java
  frameworks: spring,jakarta,hibernate
  patterns: hexagonal,cqrs,ddd,solid,clean-architecture
---

## What I do

I build production-grade Java backends with Spring Boot and enterprise patterns:

- **Spring Boot 3.x**: Auto-configuration, starters, profiles, actuator
- **Spring MVC/WebFlux**: REST APIs, reactive programming, validation
- **Spring Security**: OAuth2, JWT, method security, CSRF protection
- **JPA/Hibernate**: Entity mapping, relationships, query optimization, caching
- **Flyway/Liquibase**: Database migrations, version control
- **Maven/Gradle**: Build automation, dependency management, multi-module projects
- **Testing**: JUnit 5, Mockito, Testcontainers, Spring Boot Test
- **Observability**: Micrometer, OpenTelemetry, structured logging
- **Architecture**: Hexagonal (Ports & Adapters), CQRS, Event Sourcing, DDD
- **Patterns**: SOLID, Clean Architecture, Repository, Unit of Work, Domain Events

## When to use me

- Building new Spring Boot microservices
- Designing JPA entity models and repositories
- Implementing Spring Security configurations
- Writing unit and integration tests
- Setting up Maven/Gradle multi-module projects
- Migrating Spring Boot versions (2.x to 3.x)
- Optimizing database queries and caching
- Implementing event-driven architectures
- Refactoring to Hexagonal Architecture

## SOLID in Java

### Single Responsibility
```java
// ❌ Bad
@Service
public class UserService {
    public User createUser(CreateUserRequest req) { ... }
    public void sendWelcomeEmail(User user) { ... }
    public Report generateReport(User user) { ... }
}

// ✅ Good
@Service
@RequiredArgsConstructor
public class UserRegistrationUseCase {
    private final UserRepository userRepository;
    private final EmailService emailService;
    private final EventBus eventBus;
    
    @Transactional
    public User execute(CreateUserCommand command) {
        User user = User.create(command.name(), command.email());
        userRepository.save(user);
        emailService.sendWelcome(user.getEmail(), user.getName());
        eventBus.publish(new UserCreatedEvent(user.getId()));
        return user;
    }
}
```

### Interface Segregation
```java
// Small, focused interfaces
public interface ReadRepository<T> {
    Optional<T> findById(String id);
    List<T> findAll(Specification<T> spec);
}

public interface WriteRepository<T> {
    T save(T entity);
    void delete(String id);
}

public interface UserRepository extends ReadRepository<User>, WriteRepository<User> {
    Optional<User> findByEmail(String email);
}
```

### Dependency Inversion
```java
// High-level depends on abstraction
@RequiredArgsConstructor
public class CreateUserUseCase {
    private final UserRepository userRepository;      // Port (interface)
    private final EmailService emailService;           // Port (interface)
    private final DomainEventPublisher eventPublisher; // Port (interface)
}

// Low-level implements abstraction
@Repository
@Primary
public class JpaUserRepository implements UserRepository {
    private final UserJpaRepository jpaRepo;
    private final UserMapper mapper;
    
    @Override
    public Optional<User> findById(String id) {
        return jpaRepo.findById(id).map(mapper::toDomain);
    }
}
```

## Hexagonal Architecture (Ports & Adapters)

### Structure
```
src/main/java/com/example/
├── domain/                          # Core (no dependencies)
│   ├── model/
│   │   ├── User.java               # Aggregate Root
│   │   ├── Email.java              # Value Object
│   │   ├── Money.java              # Value Object
│   │   └── UserId.java             # Value Object
│   ├── event/
│   │   ├── DomainEvent.java
│   │   ├── UserCreatedEvent.java
│   │   └── DomainEventPublisher.java
│   ├── exception/
│   │   ├── DomainException.java
│   │   ├── UserNotFoundException.java
│   │   └── DuplicateEmailException.java
│   └── port/
│       ├── in/
│       │   ├── CreateUserUseCase.java    # Input Port
│       │   ├── GetUserQuery.java         # Input Port
│       │   └── ListUsersQuery.java
│       └── out/
│           ├── UserRepository.java       # Output Port
│           ├── EmailService.java         # Output Port
│           └── DomainEventPublisher.java # Output Port
│
├── application/                     # Use Case Implementation
│   ├── service/
│   │   ├── CreateUserServiceImpl.java   # Implements Input Port
│   │   ├── GetUserQueryImpl.java
│   │   └── ListUsersQueryImpl.java
│   └── dto/
│       ├── CreateUserCommand.java
│       ├── UserResponse.java
│       └── UserMapper.java
│
├── infrastructure/                   # Adapters
│   ├── persistence/
│   │   ├── JpaUserRepository.java       # Implements Output Port
│   │   ├── UserJpaRepository.java       # Spring Data JPA
│   │   ├── UserEntity.java             # JPA Entity
│   │   ├── UserMapper.java             # JPA ↔ Domain mapper
│   │   └── UserRepositoryAdapter.java
│   ├── messaging/
│   │   ├── RabbitMqEventPublisher.java  # Implements Output Port
│   │   └── KafkaEventPublisher.java
│   ├── email/
│   │   └── SesEmailService.java         # Implements Output Port
│   └── config/
│       ├── HexagonalConfig.java         # Wires everything
│       └── SecurityConfig.java
│
├── adapter/                          # Driving Adapters
│   ├── in/
│   │   ├── web/
│   │   │   ├── UserController.java      # Thin REST controller
│   │   │   ├── UserRequest.java
│   │   │   └── UserResponse.java
│   │   └── grpc/
│   │       └── UserGrpcService.java
│   └── out/
│       └── consumer/
│           └── UserEventConsumer.java
│
├── test/
│   ├── unit/
│   │   └── domain/
│   ├── integration/
│   │   └── persistence/
│   └── adapter/
│       └── in/
│           └── web/
└── pom.xml
```

### Configuration (Wiring)
```java
@Configuration
@ComponentScan(basePackages = "com.example")
public class HexagonalConfig {
    
    @Bean
    public UserRepository userRepository(UserJpaRepository jpaRepo, UserMapper mapper) {
        return new JpaUserRepository(jpaRepo, mapper);
    }
    
    @Bean
    public EmailService emailService(JavaMailSender mailSender) {
        return new SmtpEmailService(mailSender);
    }
    
    @Bean
    public DomainEventPublisher eventPublisher(RabbitTemplate rabbitTemplate) {
        return new RabbitMqEventPublisher(rabbitTemplate);
    }
    
    @Bean
    public CreateUserUseCase createUserUseCase(
        UserRepository userRepository,
        EmailService emailService,
        DomainEventPublisher eventPublisher
    ) {
        return new CreateUserServiceImpl(userRepository, emailService, eventPublisher);
    }
}
```

### Thin Controller
```java
@RestController
@RequestMapping("/v1/users")
@RequiredArgsConstructor
public class UserController {
    private final CreateUserUseCase createUserUseCase;
    private final GetUserQuery getUserQuery;
    private final UserMapper mapper;
    
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<UserResponse> create(@RequestBody @Valid CreateUserRequest request) {
        CreateUserCommand command = mapper.toCommand(request);
        User user = createUserUseCase.execute(command);
        UserResponse response = mapper.toResponse(user);
        return ResponseEntity
            .created(URI.create("/v1/users/" + user.getId()))
            .body(response);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> get(@PathVariable String id) {
        return getUserQuery.execute(id)
            .map(user -> ResponseEntity.ok(mapper.toResponse(user)))
            .orElse(ResponseEntity.notFound().build());
    }
}
```

## CQRS in Spring

### Write Side (Commands)
```java
@Service
@RequiredArgsConstructor
public class CreateOrderUseCase {
    private final OrderRepository orderRepository;
    private final InventoryService inventoryService;
    private final DomainEventPublisher eventPublisher;
    
    @Transactional
    public Order execute(CreateOrderCommand command) {
        // Validate
        if (!inventoryService.isAvailable(command.items())) {
            throw new InsufficientInventoryException();
        }
        
        // Create aggregate
        Order order = Order.create(command.userId(), command.items());
        
        // Persist
        orderRepository.save(order);
        
        // Publish event (for read model update)
        eventPublisher.publish(new OrderCreatedEvent(order.getId(), order.getTotal()));
        
        return order;
    }
}
```

### Read Side (Queries)
```java
@Service
@RequiredArgsConstructor
public class GetOrderQueryImpl implements GetOrderQuery {
    private final OrderReadRepository readRepository;
    
    @Override
    public Optional<OrderView> execute(String orderId) {
        return readRepository.findById(orderId);
    }
}

// Optimized read model (denormalized)
@Entity
@Table(name = "order_views")
public class OrderView {
    @Id
    private String id;
    private String userName;
    private String userEmail;
    private BigDecimal total;
    private String status;
    private List<OrderItemView> items;
    private LocalDateTime createdAt;
}
```

## DDD Value Objects
```java
@Embeddable
@EqualsAndHashCode
public class Email {
    @Column(name = "email")
    private String value;
    
    protected Email() {}
    
    public Email(String value) {
        if (value == null || !EMAIL_PATTERN.matcher(value).matches()) {
            throw new InvalidEmailException(value);
        }
        this.value = value.toLowerCase().trim();
    }
    
    public String getValue() { return value; }
    
    @Override
    public String toString() { return value; }
}
```

## Best Practices

### Code Quality
- Use Java 17+ features: records, sealed classes, pattern matching, text blocks
- Immutability with records for DTOs and value objects
- Use `Optional` instead of null returns
- Apply Lombok judiciously (`@Value`, `@Builder`, `@Slf4j`)
- Follow SOLID principles and clean code practices

### Architecture
- **Dependency Rule**: Domain layer NEVER imports from infrastructure/presentation
- Use hexagonal (ports & adapters) architecture
- Separate controllers, services, repositories
- Use DTOs for API boundaries; never expose entities directly
- Implement proper exception handling with `@ControllerAdvice`
- Use `@Transactional` at service layer only

### Spring Boot
- Use `application.yml` over `.properties`
- Leverage profiles for environment-specific config
- Use `@ConfigurationProperties` for type-safe config
- Implement health checks with Spring Actuator
- Use `@Validated` for request validation

### Database
- Use `@Query` for complex queries instead of derived methods
- Implement pagination with `Pageable` and `Slice`
- Use `@EntityGraph` to solve N+1 problems
- Enable Hibernate second-level cache with Ehcache/Caffeine
- Use Flyway for all schema changes

### Testing
- `@SpringBootTest` for integration tests
- `@WebMvcTest` for controller tests
- `@DataJpaTest` for repository tests
- Use Testcontainers for database tests
- Mock external services with WireMock
- Test at port boundaries (mock repositories, not implementations)
