---
name: performance-optimization
description: Expert performance optimization with profiling, caching strategies, database optimization, CDN, load balancing, and monitoring
metadata:
  domains: performance,profiling,caching,monitoring
  tools: lighthouse,perf,ab,jmeter
---

## What I do

I identify and resolve performance bottlenecks across the stack:

- **Backend Profiling**: CPU, memory, I/O profiling and optimization
- **Frontend Performance**: Core Web Vitals, bundle optimization, rendering
- **Caching**: Multi-layer caching (application, database, CDN, browser)
- **Database Optimization**: Query optimization, indexing, connection pooling
- **Load Testing**: k6, artillery, JMeter, stress testing
- **CDN**: Content delivery, edge caching, image optimization
- **Monitoring**: APM, distributed tracing, metrics collection
- **Memory**: Memory leak detection, garbage collection tuning
- **Concurrency**: Thread pool optimization, async processing
- **Cost**: Performance per dollar optimization

## When to use me

- Profiling slow API endpoints
- Optimizing database queries
- Implementing caching strategies
- Setting up APM and monitoring
- Conducting load testing
- Optimizing frontend bundle size
- Fixing memory leaks
- Designing high-availability architectures

## Best Practices

### Backend Optimization
- Profile before optimizing; measure first
- Use async I/O for concurrent operations
- Implement connection pooling for databases
- Use batch operations for bulk inserts/updates
- Implement pagination for large datasets
- Use streaming for large responses
- Optimize serialization (MessagePack over JSON for internal)

### Caching Strategy
```
Layer 1: Browser/CDN (static assets, API responses)
Layer 2: Application (in-memory, Redis, Memcached)
Layer 3: Database (query cache, materialized views)
Layer 4: Database (connection pooling, prepared statements)
```
- Cache read-heavy, slow-changing data
- Use cache invalidation strategies (TTL, event-driven)
- Implement cache warming for critical data
- Monitor cache hit/miss ratios
- Use `Cache-Control` headers properly

### Database Optimization
- Run EXPLAIN ANALYZE on slow queries
- Add indexes for frequently queried columns
- Use covering indexes for read-heavy queries
- Implement read replicas for scaling reads
- Use connection pooling (PgBouncer, HikariCP)
- Avoid N+1 queries; use eager loading
- Use materialized views for complex aggregations

### Frontend Optimization
- Optimize Core Web Vitals (LCP, FID, CLS)
- Implement code splitting and lazy loading
- Use image optimization (WebP, AVIF, responsive)
- Minimize third-party scripts
- Implement service workers for caching
- Use font-display: swap for web fonts
- Prefetch critical resources
- Implement skeleton screens for perceived performance

### Animation & Rendering Performance
- **GPU Acceleration**: Use `transform` and `opacity` only for animations (composited without layout/paint)
- **Avoid Layout Triggers**: Never animate `width`, `height`, `top`, `left`, `margin`, `padding`
- **will-change**: Add before animation starts, remove after it ends (don't leave permanently)
- **requestAnimationFrame**: Use for all JS-driven animations (syncs with display refresh rate)
- **IntersectionObserver**: Trigger animations only when elements enter viewport (not scroll events)
- **Throttle/Debounce**: Throttle scroll handlers (16ms = 60fps), debounce resize handlers
- **CSS Containment**: Use `contain: layout style paint` for isolated animation regions
- **Layer Promotion**: Use `transform: translateZ(0)` or `will-change: transform` to promote layers
- **Reduced Motion**: Respect `prefers-reduced-motion: reduce` — disable non-essential animations
- **Three.js/3D**: Use LOD (Level of Detail), frustum culling, instanced meshes, texture atlasing
- **Particles**: Limit particle count, use `devicePixelRatio` scaling, avoid per-frame DOM queries
- **GSAP**: Use `gsap.matchMedia()` for responsive animations, clean up with `kill()`
- **Canvas 2D**: Use `offscreenCanvas` for heavy drawing, batch operations, avoid `getImageData` in loops
- **Profiling**: Use Chrome DevTools Performance panel to identify layout thrashing and long frames

### Load Testing
- Test at expected peak load + 2x
- Gradually increase load (ramp-up)
- Monitor response times, error rates, throughput
- Test different scenarios (read-heavy, write-heavy)
- Identify breaking points and bottlenecks
- Test with realistic data volumes

### Monitoring
- Implement distributed tracing (OpenTelemetry)
- Set up alerting on latency and error rate SLOs
- Monitor p50, p95, p99 latencies (not just average)
- Track database query performance
- Monitor memory and CPU usage trends
- Use real user monitoring (RUM) for frontend

## Project Structure

```
performance/
├── benchmarks/
│   ├── api-benchmark.sh          # k6 load test script
│   ├── database-benchmark.sql
│   └── frontend-lighthouse.js
├── monitoring/
│   ├── dashboards/
│   │   ├── api-overview.json
│   │   └── database-performance.json
│   ├── alerts/
│   │   ├── latency.yml
│   │   └── error-rate.yml
│   └── traces/
│       └── sampling-config.yaml
├── profiling/
│   ├── backend/
│   │   ├── cpu-profile.sh
│   │   └── memory-profile.sh
│   └── frontend/
│       └── lighthouse-config.json
├── caching/
│   ├── redis-config.yaml
│   ├── cache-strategy.md
│   └── invalidation-rules.yaml
├── load-tests/
│   ├── scenarios/
│   │   ├── normal-load.js
│   │   ├── peak-load.js
│   │   └── stress-test.js
│   └── config.yaml
├── scripts/
│   ├── profile.sh
│   └── analyze-bundle.sh
└── docs/
    ├── optimization-checklist.md
    └── performance-budget.md
```
