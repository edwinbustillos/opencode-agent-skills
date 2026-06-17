---
name: api-design
description: Expert API design with REST, GraphQL, gRPC, OpenAPI 3.1, authentication (JWT, OAuth2, API keys), rate limiting, versioning, idempotency, contract testing, API gateway patterns, and enterprise patterns
metadata:
  protocols: rest,graphql,grpc
  auth: jwt,oauth2
  standards: openapi31,rfc7807,rfc8259
---

## What I do

I design and implement production-grade APIs across all major paradigms with enterprise patterns:

- **REST**: Resource-oriented design, HATEOAS, proper HTTP semantics, Richardson Maturity Model
- **GraphQL**: Schema design, resolvers, subscriptions, N+1 prevention, DataLoader
- **gRPC**: Protocol Buffers, streaming, service contracts, bidirectional
- **OpenAPI 3.1**: Full specification, code generation, contract testing, documentation
- **Authentication**: JWT (access/refresh tokens), OAuth2, API keys, session-based
- **Authorization**: RBAC, ABAC, policy-based access control, OAuth2 scopes
- **Documentation**: OpenAPI 3.1, Swagger UI, Redoc, GraphQL introspection
- **Versioning**: URI versioning, header versioning, content negotiation
- **Rate Limiting**: Token bucket, sliding window, per-user limits, distributed rate limiting
- **Error Handling**: RFC 7807 Problem Details, consistent error formats
- **Idempotency**: Idempotency keys, exactly-once semantics, deduplication
- **Contract Testing**: Pact, Dredd, OpenAPI validation
- **API Gateway**: Routing, aggregation, rate limiting, authentication

## When to use me

- Designing new API specifications
- Implementing RESTful APIs with proper conventions
- Setting up JWT authentication with refresh tokens
- Designing GraphQL schemas and resolvers
- Implementing API versioning strategies
- Writing OpenAPI 3.1 specifications
- Designing rate limiting policies
- Implementing idempotency for write operations
- Designing API gateway routing rules
- Implementing contract testing

## Richardson Maturity Model

### Level 0 — Swamp of POX
- Single endpoint (POST /api)
- No HTTP semantics
- Action in request body

### Level 1 — Resources
- Multiple endpoints for different resources
- URI identifies resources
- Still limited HTTP methods

### Level 2 — HTTP Verbs
- Proper use of GET, POST, PUT, PATCH, DELETE
- Status codes meaningful
- Headers used correctly

### Level 3 — HATEOAS (Hypermedia)
- Responses include links to related resources
- Client navigates via links, not hardcoded URIs
- Self-descriptive messages

```json
{
  "id": "user-123",
  "name": "John",
  "_links": {
    "self": { "href": "/v1/users/user-123" },
    "orders": { "href": "/v1/users/user-123/orders" },
    "edit": { "href": "/v1/users/user-123", "method": "PATCH" },
    "delete": { "href": "/v1/users/user-123", "method": "DELETE" }
  }
}
```

## OpenAPI 3.1 (Enterprise)

### Full Specification Structure

```yaml
openapi: 3.1.0
info:
  title: Order Service API
  version: 2.0.0
  description: |
    API para gerenciamento de pedidos.
    
    ## Autenticação
    Todos os endpoints requerem Bearer token via Authorization header.
    
    ## Paginação
    Listas suportam paginação cursor-based com `cursor` e `limit`.
    
    ## Idempotência
    Operações POST/PUT/PATCH suportam idempotency key via `Idempotency-Key` header.
  contact:
    name: API Support
    email: api@example.com
  license:
    name: MIT

servers:
  - url: https://api.example.com/v2
    description: Production
  - url: https://staging-api.example.com/v2
    description: Staging

security:
  - bearerAuth: []

tags:
  - name: Orders
    description: Order management
  - name: Health
    description: Service health

paths:
  /v2/orders:
    get:
      tags: [Orders]
      operationId: listOrders
      summary: List user orders
      description: Returns paginated list of orders for authenticated user
      parameters:
        - $ref: '#/components/parameters/CursorParam'
        - $ref: '#/components/parameters/LimitParam'
        - name: status
          in: query
          schema:
            $ref: '#/components/schemas/OrderStatus'
        - name: sort
          in: query
          schema:
            type: string
            enum: [created_at, total]
            default: created_at
        - name: order
          in: query
          schema:
            type: string
            enum: [asc, desc]
            default: desc
      responses:
        '200':
          description: Paginated order list
          headers:
            X-Next-Cursor:
              description: Cursor for next page
              schema:
                type: string
            X-Total-Count:
              description: Total matching orders
              schema:
                type: integer
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrderListResponse'
        '401':
          $ref: '#/components/responses/Unauthorized'
        '429':
          $ref: '#/components/responses/TooManyRequests'
        '500':
          $ref: '#/components/responses/InternalError'
    
    post:
      tags: [Orders]
      operationId: createOrder
      summary: Create new order
      description: |
        Creates a new order. Supports idempotency via `Idempotency-Key` header.
        If the key was used before, returns the previous response.
      parameters:
        - name: Idempotency-Key
          in: header
          required: true
          schema:
            type: string
            format: uuid
          description: Unique idempotency key (UUID v4)
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateOrderRequest'
            examples:
              single_item:
                summary: Single item order
                value:
                  items:
                    - product_id: "prod-001"
                      quantity: 2
                  shipping_address:
                    street: "123 Main St"
                    city: "São Paulo"
                    state: "SP"
                    zip: "01000-000"
              multi_item:
                summary: Multi-item order
                value:
                  items:
                    - product_id: "prod-001"
                      quantity: 1
                    - product_id: "prod-002"
                      quantity: 3
                  shipping_address:
                    street: "456 Oak Ave"
                    city: "Rio de Janeiro"
                    state: "RJ"
                    zip: "20000-000"
      responses:
        '201':
          description: Order created
          headers:
            Location:
              description: URL of created resource
              schema:
                type: string
                format: uri
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrderResponse'
        '400':
          $ref: '#/components/responses/BadRequest'
        '401':
          $ref: '#/components/responses/Unauthorized'
        '409':
          description: Idempotency key already used with different request
          content:
            application/problem+json:
              schema:
                $ref: '#/components/schemas/ProblemDetail'

  /v2/orders/{orderId}:
    parameters:
      - name: orderId
        in: path
        required: true
        schema:
          type: string
          format: uuid
    
    get:
      tags: [Orders]
      operationId: getOrder
      summary: Get order by ID
      responses:
        '200':
          description: Order details
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrderResponse'
        '404':
          $ref: '#/components/responses/NotFound'
    
    patch:
      tags: [Orders]
      operationId: updateOrder
      summary: Update order status
      parameters:
        - name: Idempotency-Key
          in: header
          required: true
          schema:
            type: string
            format: uuid
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UpdateOrderRequest'
      responses:
        '200':
          description: Order updated
        '404':
          $ref: '#/components/responses/NotFound'

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
  
  parameters:
    CursorParam:
      name: cursor
      in: query
      schema:
        type: string
      description: Opaque cursor for pagination
    LimitParam:
      name: limit
      in: query
      schema:
        type: integer
        minimum: 1
        maximum: 100
        default: 20
      description: Items per page
  
  schemas:
    OrderStatus:
      type: string
      enum: [pending, confirmed, shipped, delivered, cancelled]
    
    CreateOrderRequest:
      type: object
      required: [items, shipping_address]
      properties:
        items:
          type: array
          minItems: 1
          maxItems: 50
          items:
            $ref: '#/components/schemas/OrderItemInput'
        shipping_address:
          $ref: '#/components/schemas/Address'
        notes:
          type: string
          maxLength: 500
    
    OrderItemInput:
      type: object
      required: [product_id, quantity]
      properties:
        product_id:
          type: string
          format: uuid
        quantity:
          type: integer
          minimum: 1
          maximum: 999
    
    OrderResponse:
      type: object
      properties:
        id:
          type: string
          format: uuid
        status:
          $ref: '#/components/schemas/OrderStatus'
        items:
          type: array
          items:
            $ref: '#/components/schemas/OrderItem'
        total:
          type: number
          format: double
        created_at:
          type: string
          format: date-time
        _links:
          $ref: '#/components/schemas/HateoasLinks'
    
    ProblemDetail:
      type: object
      description: RFC 7807 Problem Details
      properties:
        type:
          type: string
          format: uri
          description: URI reference identifying the problem type
        title:
          type: string
          description: Short human-readable summary
        status:
          type: integer
          description: HTTP status code
        detail:
          type: string
          description: Human-readable explanation
        instance:
          type: string
          format: uri
          description: URI reference to the specific occurrence
        errors:
          type: object
          additionalProperties:
            type: array
            items:
              type: string
          description: Field-level validation errors
  
  responses:
    BadRequest:
      description: Invalid request
      content:
        application/problem+json:
          schema:
            $ref: '#/components/schemas/ProblemDetail'
    Unauthorized:
      description: Authentication required
      content:
        application/problem+json:
          schema:
            $ref: '#/components/schemas/ProblemDetail'
    NotFound:
      description: Resource not found
      content:
        application/problem+json:
          schema:
            $ref: '#/components/schemas/ProblemDetail'
    TooManyRequests:
      description: Rate limit exceeded
      headers:
        Retry-After:
          description: Seconds until next request allowed
          schema:
            type: integer
        X-RateLimit-Limit:
          description: Max requests per window
          schema:
            type: integer
        X-RateLimit-Remaining:
          description: Remaining requests
          schema:
            type: integer
      content:
        application/problem+json:
          schema:
            $ref: '#/components/schemas/ProblemDetail'
    InternalError:
      description: Server error
      content:
        application/problem+json:
          schema:
            $ref: '#/components/schemas/ProblemDetail'
```

## Idempotency Pattern

### How It Works
1. Client generates unique idempotency key (UUID v4)
2. Server stores key + request hash + response
3. Subsequent requests with same key return cached response
4. Keys expire after 24-48 hours

```typescript
class IdempotencyService {
  async process<T>(
    key: string,
    requestHash: string,
    handler: () => Promise<T>
  ): Promise<T> {
    const existing = await this.store.get(key);
    
    if (existing) {
      if (existing.requestHash !== requestHash) {
        throw new ConflictError('Idempotency key used with different request');
      }
      return existing.response as T;
    }
    
    const response = await handler();
    await this.store.set(key, { requestHash, response, createdAt: new Date() });
    return response;
  }
}
```

### Storage Options
- **Redis**: Fast, TTL support, atomic operations
- **Database**: Persistent, queryable, transactional
- **Memory**: Fastest, but not distributed (use with sticky sessions)

## Contract Testing

### Provider-Driven Contracts (Pact)
- Provider publishes Pact files
- Consumer verifies against provider
- CI/CD integration with broker

### OpenAPI Validation
- Validate request/response against spec at runtime
- Middleware: validate incoming requests
- Middleware: validate outgoing responses (in tests)
- Tools: ajv, zod-to-openapi, @asteasolutions/zod-to-openapi

### Code Generation from OpenAPI
- TypeScript clients: `orval`, `openapi-generator`
- Server stubs: `openapi-generator`
- Always keep spec as source of truth

## API Gateway Patterns

### Routing
```yaml
routes:
  - path: /api/users/**
    service: user-service
    strip-prefix: /api/users
  - path: /api/orders/**
    service: order-service
    strip-prefix: /api/orders
  - path: /api/products/**
    service: product-service
    strip-prefix: /api/products
```

### Request Aggregation
- Combine multiple downstream calls into one response
- Client sends single request, gateway aggregates
- Reduces chattiness for microservices

### Protocol Translation
- REST → gRPC
- HTTP → WebSocket
- JSON → Protobuf

## Rate Limiting Algorithms

### Token Bucket
- Bucket holds N tokens
- Each request consumes 1 token
- Tokens added at fixed rate
- Allows burst up to bucket size

### Sliding Window
- Tracks requests in a time window
- More accurate than fixed window
- No boundary spikes

### Fixed Window
- Counter resets at fixed intervals
- Simple but allows 2x burst at boundaries

### Leaky Bucket
- Requests processed at constant rate
- Queue overflow → rejection
- Smooths out traffic spikes

## Best Practices

### REST Design
- Use nouns for resources (`/users`, not `/getUsers`)
- Use HTTP methods correctly: GET (read), POST (create), PUT (full update), PATCH (partial), DELETE
- Return proper status codes: 200, 201, 204, 400, 401, 403, 404, 409, 429
- Use plural nouns for collections
- Implement cursor-based pagination for list endpoints
- Use HATEOAS links for discoverability

### Authentication & Authorization
- Use short-lived access tokens (15min) with refresh tokens (7-30d)
- Store tokens in httpOnly secure cookies (web) or secure storage (mobile)
- Implement token rotation on refresh
- Use API keys for service-to-service communication
- Implement rate limiting per API key/user
- OAuth2 flows: Authorization Code + PKCE (web), Client Credentials (service-to-service)

### Error Handling
- Use RFC 7807 Problem Details format for errors
- Include `type`, `title`, `status`, `detail`, `instance`
- Include machine-readable error codes in `errors` field
- Never expose internal errors or stack traces
- Log errors with correlation IDs (X-Request-ID)
- Return validation errors with field-level detail
- Use `application/problem+json` content type

### Versioning
- Use URI versioning (`/v1/users`) for breaking changes
- Use header versioning for minor changes
- Deprecate old versions with `Sunset` header
- Maintain at most 2 major versions simultaneously
- Document deprecation in OpenAPI with `deprecated: true`

### Security
- Validate Content-Type header
- Use `Content-Security-Policy` headers
- Implement CORS properly (never `Access-Control-Allow-Origin: *` in production)
- Validate and sanitize all inputs
- Use parameterized queries
- Implement request size limits
- Log security events

## Project Structure

```
src/
├── api/
│   ├── openapi.yaml             # OpenAPI 3.1 spec (source of truth)
│   ├── routes/
│   │   ├── index.ts
│   │   ├── v1/
│   │   │   ├── users.ts
│   │   │   ├── posts.ts
│   │   │   └── router.ts
│   │   └── v2/
│   │       └── router.ts
│   ├── middleware/
│   │   ├── auth.ts
│   │   ├── rate-limit.ts
│   │   ├── validate.ts
│   │   ├── idempotency.ts
│   │   └── error-handler.ts
│   ├── controllers/
│   │   └── user.controller.ts
│   └── schemas/
│       ├── user.schema.ts       # Zod/Joi validation
│       └── error.schema.ts
├── auth/
│   ├── jwt.ts
│   ├── oauth2.ts
│   ├── api-key.ts
│   └── strategies/
│       ├── local.ts
│       └── bearer.ts
├── gateway/
│   ├── router.ts                # API Gateway routing rules
│   ├── aggregator.ts            # Request aggregation
│   └── circuit-breaker.ts       # Circuit breaker config
├── contracts/
│   ├── pact/                    # Pact contract files
│   └── tests/                   # Contract tests
├── docs/
│   ├── openapi.yaml
│   ├── architecture.md          # API architecture decisions
│   └── examples/
│       ├── user-response.json
│       └── error-response.json
└── tests/
    ├── contract/
    └── integration/
```
