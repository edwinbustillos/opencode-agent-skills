---
name: rust-systems
description: Expert Rust systems programming with async runtime, web frameworks, FFI, embedded, and performance-critical applications
metadata:
  languages: rust
  frameworks: actix,axum,tokio
---

## What I do

I build production-grade Rust applications with safety and performance:

- **Web Frameworks**: Axum (preferred), Actix-web, Rocket, Warp
- **Async Runtime**: Tokio, async-std, structured concurrency with join!/select!
- **Error Handling**: Result<T, E>, anyhow, thiserror, custom error types
- **Serialization**: Serde with derive macros, JSON, TOML, MessagePack
- **Database**: SQLx (compile-time checked), Diesel, SeaORM, sqlx offline mode
- **Testing**: Built-in test framework, proptest, criterion benchmarks, mockall
- **FFI**: Safe bindings with PyO3 (Python), wasm-bindgen (WASM)
- **Systems**: Zero-cost abstractions, SIMD, memory-mapped I/O, custom allocators
- **CLI**: clap for argument parsing, indicatif for progress bars
- **Observability**: tracing, tracing-subscriber, structured logging

## When to use me

- Building high-performance APIs or microservices
- Implementing concurrent/parallel data processing
- Writing FFI bindings to Rust from other languages
- Optimizing memory usage and CPU performance
- Building CLI tools with complex argument parsing
- Implementing WebSocket or real-time servers
- Working with unsafe Rust and raw pointers
- Benchmarking and profiling Rust code

## Best Practices

### Ownership & Safety
- Prefer borrowing over cloning; use `Cow<str>` when ownership is uncertain
- Use `Arc<Mutex<T>>` for shared state; prefer `RwLock` for read-heavy workloads
- Minimize `unsafe` blocks; document invariants in comments
- Use `#[must_use]` on functions returning important values
- Prefer `Result<T, E>` over panics; use `expect()` only in tests

### Error Handling
- Use `thiserror` for library errors (derives `Display`, `Error`)
- Use `anyhow` for application errors (context, backtraces)
- Chain errors with `.context("description")?`
- Never use `unwrap()` in production code
- Implement `From` traits for error conversion

### Performance
- Use iterators and combinators over manual loops
- Leverage zero-cost abstractions (generics over trait objects when possible)
- Use `#[inline]` judiciously for hot paths
- Profile with `cargo flamegraph` and criterion benchmarks
- Use `serde` with `#[serde(skip_serializing_if)]` to reduce payload

### Async Patterns
- Use `tokio::spawn` for concurrent tasks
- Implement graceful shutdown with `tokio::signal`
- Use `tower::ServiceBuilder` for middleware stacks
- Prefer `axum::extract` for type-safe request handling
- Use `sqlx::Acquire` for transaction management

### Code Quality
- Run `cargo clippy` with all warnings
- Use `cargo fmt` for consistent formatting
- Enable `deny(missing_docs)` for public APIs
- Use `cargo audit` for dependency vulnerabilities
- Run `cargo miri` for undefined behavior detection

## Project Structure

```
src/
├── main.rs                    # Entry point
├── lib.rs                     # Library root
├── config.rs                  # Configuration
├── error.rs                   # Error types
├── router.rs                  # Route definitions
├── handler/                   # Request handlers
│   ├── mod.rs
│   └── user.rs
├── model/                     # Data models
│   ├── mod.rs
│   └── user.rs
├── service/                   # Business logic
│   ├── mod.rs
│   └── user.rs
├── repository/                # Data access
│   ├── mod.rs
│   └── user.rs
├── middleware/                 # Custom middleware
│   ├── mod.rs
│   └── auth.rs
└── dto/                       # Data transfer objects
    ├── mod.rs
    └── user.rs
├── migrations/                # SQLx migrations
│   └── 000001_init.sql
├── Cargo.toml
├── rust-toolchain.toml
├── .cargo/
│   └── config.toml
└── benches/
    └── user_benchmark.rs
```
