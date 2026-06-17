---
name: testing-strategy
description: Expert testing strategy with unit, integration, end-to-end, TDD, BDD, test doubles, mocking, property-based testing, and test automation
metadata:
  types: unit,integration,e2e,performance
  tools: jest,vitest,pytest,junit,playwright
---

## What I do

I design and implement comprehensive testing strategies:

- **Unit Tests**: Isolated component/function tests with mocks
- **Integration Tests**: Service interaction, database, API tests
- **E2E Tests**: Full user flow automation with Playwright/Cypress
- **Performance Tests**: Load testing, stress testing, benchmarking
- **TDD/BDD**: Test-first development, behavior-driven scenarios
- **Test Doubles**: Mocks, stubs, fakes, spies
- **Property-Based Testing**: Hypothesis, fast-check, generative testing
- **Contract Testing**: API contract verification, Pact
- **Test Automation**: CI integration, parallel execution, flake detection
- **Test Design**: AAA pattern, test isolation, test data management

## When to use me

- Designing testing strategies for new projects
- Implementing TDD/BDD workflows
- Setting up test automation in CI/CD
- Writing tests for existing untested code
- Debugging flaky tests
- Implementing test doubles and mocking strategies
- Setting up E2E test frameworks
- Optimizing test execution speed

## Best Practices

### Test Pyramid
```
        /  E2E  \           Few (10%), slow, high confidence
       / Integration \     Medium (20%), moderate speed
      /    Unit Tests    \ Many (70%), fast, focused
```

### Unit Testing
- Follow AAA pattern: Arrange, Act, Assert
- One assertion per test (or one concept per test)
- Test behavior, not implementation details
- Use descriptive test names: `should return error when user not found`
- Mock external dependencies; don't mock the system under test
- Keep tests independent; no shared mutable state
- Test edge cases: empty, null, boundary values, error paths

### Integration Testing
- Test real integrations (database, API, filesystem)
- Use testcontainers for database tests
- Test error scenarios (timeout, connection refused)
- Use fixtures or factories for test data
- Reset state between tests (truncation, transactions)

### E2E Testing
- Test critical user journeys only (login, checkout, etc.)
- Use page object model for maintainability
- Implement retry mechanisms for flaky operations
- Use explicit waits, not sleep
- Capture screenshots/videos on failure
- Run E2E tests in CI with isolated environments

### Mocking
- Mock at the boundary (HTTP, database, filesystem)
- Use fakes over mocks when possible
- Verify behavior (calls, arguments) not just calls
- Reset mocks between tests
- Avoid over-mocking; test through interfaces

### Test Data
- Use factories over fixtures for flexibility
- Generate test data with Faker or factory libraries
- Use unique data to avoid collisions
- Clean up after tests (or use transactions)
- Use seeds for reproducible test data

### CI Integration
- Run unit tests on every commit
- Run integration tests on PR
- Run E2E tests on staging deploy
- Parallelize test execution
- Report coverage as a trend, not a gate
- Quarantine flaky tests, don't delete them

## Project Structure

```
tests/
├── unit/
│   ├── services/
│   │   └── user.service.test.ts
│   ├── handlers/
│   │   └── user.handler.test.ts
│   └── utils/
│       └── validator.test.ts
├── integration/
│   ├── api/
│   │   └── user.api.test.ts
│   ├── database/
│   │   └── user.repository.test.ts
│   └── fixtures/
│       ├── users.json
│       └── setup.ts
├── e2e/
│   ├── pages/
│   │   ├── login.page.ts
│   │   └── dashboard.page.ts
│   ├── flows/
│   │   ├── login.spec.ts
│   │   └── checkout.spec.ts
│   └── fixtures/
│       └── auth.ts
├── performance/
│   ├── load-test.js            # k6/artillery script
│   └── benchmark/
├── helpers/
│   ├── test-utils.ts
│   ├── factories.ts
│   └── mocks.ts
├── conftest.py                 # pytest config
├── vitest.config.ts
└── playwright.config.ts
```
