---
name: cpp-systems
description: Expert C++ systems programming with modern C++17/20, CMake, templates, memory safety, and performance optimization
metadata:
  languages: cpp,c
  frameworks: cmake,boost,qt
---

## What I do

I build production-grade C++ systems with modern idioms and safety:

- **Modern C++17/20**: Structured bindings, std::optional/variant, ranges, concepts
- **Memory Management**: RAII, smart pointers, custom allocators, memory pools
- **Build Systems**: CMake, Conan, vcpkg, FetchContent
- **Concurrency**: std::thread, std::async, atomics, lock-free data structures
- **Testing**: Google Test, Catch2, doctest, fuzzing with AFL/libFuzzer
- **Static Analysis**: clang-tidy, cppcheck, PVS-Studio, sanitizers (ASan, TSan, UBSan)
- **Templates**: SFINAE, CRTP, type traits, constexpr if, fold expressions
- **Performance**: SIMD, cache-friendly data structures, branch prediction hints
- **Libraries**: Boost, fmt, spdlog, nlohmann/json, OpenSSL
- **Build Automation**: CMake presets, CTest, CPack

## When to use me

- Building high-performance C++ applications
- Implementing lock-free concurrent data structures
- Designing template-heavy libraries
- Setting up CMake build systems
- Writing unit tests with Google Test/Catch2
- Profiling and optimizing C++ code
- Implementing FFI between C++ and other languages
- Debugging memory issues (leaks, undefined behavior)

## Best Practices

### Memory Safety
- Prefer smart pointers (`std::unique_ptr`, `std::shared_ptr`) over raw pointers
- Use RAII for all resource management (files, sockets, locks)
- Initialize all variables; use `= {}` for value initialization
- Use `std::span` (C++20) for non-owning array views
- Prefer `std::string_view` over `const std::string&` for read-only params

### Modern C++
- Use `auto` when type is obvious or complex
- Prefer range-based for loops and algorithms
- Use `std::optional` instead of null pointers/magic values
- Use `std::variant` over unions for type safety
- Prefer `constexpr` for compile-time computation
- Use structured bindings for pair/tuple decomposition

### Code Quality
- Enable compiler warnings: `-Wall -Wextra -Wpedantic -Werror`
- Run `clang-tidy` with modernize- and performance- checks
- Use `[[nodiscard]]`, `[[maybe_unused]]`, `[[likely]]` attributes
- Follow the C++ Core Guidelines
- Use `std::span` for function parameters instead of pointer+size

### Build System
- Use modern CMake (target-based, not directory-based)
- Use `target_link_libraries` with `PUBLIC`/`PRIVATE`/`INTERFACE`
- Use Conan or vcpkg for dependency management
- Enable CMake presets for build configurations
- Use `FetchContent` for header-only libraries

### Testing
- Use Google Test or Catch2 for unit testing
- Enable sanitizers in CI: ASan, TSan, UBSan
- Use fuzz testing for parsing/validation code
- Mock interfaces with GoogleMock
- Use CTest for test discovery and execution

## Project Structure

```
src/
├── main.cpp
├── core/
│   ├── types.h
│   └── error.h
├── handler/
│   └── user_handler.cpp
├── service/
│   └── user_service.cpp
├── model/
│   └── user.cpp
├── repository/
│   └── user_repository.cpp
├── util/
│   ├── logger.h
│   └── config.h
└── third_party/
include/
├── mylib/
│   ├── api.h
│   └── types.h
tests/
├── CMakeLists.txt
├── test_user_service.cpp
├── test_user_handler.cpp
└── fixtures/
├── CMakeLists.txt
├── conanfile.py
├── CMakePresets.json
├── .clang-tidy
├── .clang-format
└── Dockerfile
```
