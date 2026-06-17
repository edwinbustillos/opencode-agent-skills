---
name: javascript-typescript
description: Expert JavaScript/TypeScript development with Node.js, Deno, Bun, Express, NestJS, Next.js, pure JS animations, DOM manipulation, GSAP, Anime.js, Three.js, Particles.js, and modern tooling
metadata:
  languages: javascript,typescript
  frameworks: node,express,nestjs,nextjs,gsap,threejs,animejs
---

## What I do

I build production-grade JavaScript/TypeScript applications across all major runtimes and frameworks, including immersive frontend experiences:

- **TypeScript**: Strict mode, advanced generics, utility types, declaration files
- **Node.js**: Event-driven architecture, streams, worker threads, cluster mode
- **Express/Fastify/Koa**: REST APIs with middleware, routing, error handling
- **NestJS**: Enterprise apps with dependency injection, modules, guards, interceptors
- **Next.js**: Full-stack React with SSR, ISR, API routes, middleware
- **Bun/Deno**: Modern runtime adoption, native TypeScript support
- **Pure JS Animations**: GSAP, Anime.js, CSS keyframes, Web Animations API
- **DOM Manipulation**: Modern DOM APIs, IntersectionObserver, MutationObserver
- **3D/Particles**: Three.js, Particles.js, WebGL, Canvas 2D
- **Tooling**: ESLint, Prettier, Vitest/Jest, tsx/ts-node, turbo/nx monorepos
- **Validation**: Zod, Joi, class-validator schemas
- **Database**: Prisma, Drizzle, TypeORM with migrations

## When to use me

- Building new TypeScript/JavaScript APIs or full-stack apps
- Migrating JavaScript projects to TypeScript
- Setting up monorepos with turborepo or nx
- Configuring ESLint, Prettier, and build tools
- Implementing authentication (NextAuth, Passport)
- Designing type-safe APIs with tRPC or Zod
- Optimizing Node.js performance
- Debugging async/event-loop issues
- Implementing complex DOM animations without frameworks
- Building Canvas 2D or WebGL interactive experiences
- Creating reusable animation utilities and libraries

## Pure JavaScript Animation

### Web Animations API
- Native browser animation API (no dependencies)
- `element.animate()` for keyframe animations
- `Animation` object for control (play, pause, reverse, cancel)
- Timeline coordination with `AnimationTimeline`
- GPU-accelerated transforms and opacity

```javascript
// Web Animations API example
element.animate(
  [
    { transform: 'translateY(0)', opacity: 1 },
    { transform: 'translateY(-20px)', opacity: 0 },
  ],
  {
    duration: 300,
    easing: 'ease-in-out',
    fill: 'forwards',
  }
);
```

### GSAP (GreenSock Animation Platform)
- Industry standard for complex web timelines
- ScrollTrigger for scroll-driven animations
- SplitText for kinetic typography
- Flip animations for layout transitions
- MorphSVG for shape morphing
- CustomEase for unique easing curves
- Timeline sequencing with `.timeline()`

```javascript
// GSAP timeline example
const tl = gsap.timeline({ defaults: { ease: 'power3.out' } });
tl.from('.hero-title', { y: 80, opacity: 0, duration: 1 })
  .from('.hero-subtitle', { y: 40, opacity: 0, duration: 0.8 }, '-=0.4')
  .from('.hero-cta', { scale: 0.8, opacity: 0, duration: 0.6 }, '-=0.2');

// ScrollTrigger
gsap.from('.feature-card', {
  y: 60,
  opacity: 0,
  stagger: 0.15,
  scrollTrigger: {
    trigger: '.features-section',
    start: 'top 80%',
  },
});
```

### Anime.js
- Flexible, lightweight graphics engine
- CSS properties, SVG attributes, DOM manipulation
- Stagger animations with `anime.stagger()`
- SVG stroke animations and path drawing
- Timeline sequencing with callbacks
- Direction control (alternate, reverse)
- Loop animations with `loop: true`

```javascript
// Anime.js examples
// Stagger list items
anime({
  targets: '.list-item',
  translateX: [50, 0],
  opacity: [0, 1],
  delay: anime.stagger(100),
  duration: 600,
  easing: 'easeOutQuad',
});

// SVG path drawing
anime({
  targets: 'svg path',
  strokeDashoffset: [anime.setDashoffset, 0],
  duration: 2000,
  easing: 'easeInOutSine',
  direction: 'alternate',
  loop: true,
});
```

## DOM Manipulation (Modern APIs)

### Intersection Observer
- Performance-efficient scroll detection
- Lazy loading images and components
- Infinite scroll implementation
- Scroll-triggered animations (replaces scroll events)
- Visibility tracking for analytics

```javascript
const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target); // One-time trigger
      }
    });
  },
  { threshold: 0.2, rootMargin: '0px 0px -50px 0px' }
);

document.querySelectorAll('.animate-on-scroll').forEach((el) => {
  observer.observe(el);
});
```

### Mutation Observer
- Watch for DOM changes
- Dynamic content detection
- Form state monitoring
- Custom element lifecycle

### ResizeObserver
- Responsive component sizing
- Canvas/container resize handling
- Dynamic layout adjustments

```javascript
const resizeObserver = new ResizeObserver((entries) => {
  for (const entry of entries) {
    const { width, height } = entry.contentRect;
    canvas.width = width * devicePixelRatio;
    canvas.height = height * devicePixelRatio;
  }
});
resizeObserver.observe(containerElement);
```

### requestAnimationFrame
- Smooth 60fps animations
- Physics-based simulations
- Parallax scrolling
- Custom easing functions

```javascript
function animate(duration, callback) {
  const start = performance.now();
  function frame(time) {
    const elapsed = time - start;
    const progress = Math.min(elapsed / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3); // easeOutCubic
    callback(eased);
    if (progress < 1) requestAnimationFrame(frame);
  }
  requestAnimationFrame(frame);
}
```

## 3D & Particle Engines

### Three.js (Vanilla)
- Scene, camera, renderer architecture
- Geometry primitives (Box, Sphere, Torus, Icosahedron)
- Materials (Standard, Physical, Shader, Points)
- Lighting (Ambient, Directional, Point, Spot)
- Raycasting for mouse/touch interaction
- GLTF/GLB model loading
- Post-processing (Bloom, DOF, SSAO)
- Responsive canvas with `ResizeObserver`

```javascript
// Three.js vanilla setup
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, w / h, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
document.getElementById('canvas-container').appendChild(renderer.domElement);

const geometry = new THREE.IcosahedronGeometry(1, 1);
const material = new THREE.MeshStandardMaterial({
  color: 0x00ff88,
  wireframe: true,
});
const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);

function animate() {
  requestAnimationFrame(animate);
  mesh.rotation.y += 0.005;
  renderer.render(scene, camera);
}
animate();
```

### Particles.js (Vanilla)
- Configuration-driven particle systems
- Floating particles, node webs, connections
- Mouse interaction (hover, click effects)
- Responsive particle density
- Custom shapes, colors, opacities

```javascript
// Particles.js config
particlesJS('particles-container', {
  particles: {
    number: { value: 80 },
    color: { value: '#00ff88' },
    shape: { type: 'circle' },
    opacity: { value: 0.5 },
    size: { value: 3 },
    line_linked: {
      enable: true,
      distance: 150,
      color: '#00ff88',
      opacity: 0.4,
      width: 1,
    },
    move: { enable: true, speed: 2 },
  },
  interactivity: {
    detect_on: 'canvas',
    events: {
      onhover: { enable: true, mode: 'grab' },
      onclick: { enable: true, mode: 'push' },
    },
  },
});
```

### Canvas 2D API
- Custom drawing and animation
- 2D games and interactive visualizations
- Image manipulation and effects
- Text rendering with custom fonts
- Particle systems without WebGL

```javascript
const canvas = document.getElementById('canvas');
const ctx = canvas.getContext('2d');

function drawFrame() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = '#00ff88';
  ctx.beginPath();
  ctx.arc(x, y, radius, 0, Math.PI * 2);
  ctx.fill();
  requestAnimationFrame(drawFrame);
}
```

## Backend Architecture (Clean Architecture / Hexagonal)

### SOLID in TypeScript

```typescript
// Single Responsibility
class CreateUserUseCase {
  constructor(
    private readonly userRepo: UserRepository,      // Port
    private readonly emailSvc: EmailService,         // Port
    private readonly eventBus: EventBus,             // Port
  ) {}

  async execute(cmd: CreateUserCommand): Promise<User> {
    const user = User.create(cmd.name, cmd.email);
    await this.userRepo.save(user);
    await this.eventBus.publish(new UserCreatedEvent(user.id));
    return user;
  }
}

// Interface Segregation
interface ReadRepository<T> {
  findById(id: string): Promise<T | null>;
  findAll(filter: Filter): Promise<T[]>;
}

interface WriteRepository<T> {
  save(entity: T): Promise<void>;
  delete(id: string): Promise<void>;
}

// Dependency Inversion
interface UserRepository extends ReadRepository<User>, WriteRepository<User> {
  findByEmail(email: string): Promise<User | null>;
}
```

### Clean Architecture Structure
```
src/
├── domain/                        # Enterprise Business Rules
│   ├── entities/
│   │   ├── user.ts                # Domain Entity
│   │   └── order.ts
│   ├── value-objects/
│   │   ├── email.ts
│   │   └── money.ts
│   ├── events/
│   │   ├── user-created.event.ts
│   │   └── event-bus.ts           # Interface
│   ├── exceptions/
│   │   └── domain.exception.ts
│   └── interfaces/
│       ├── repositories/
│       │   └── user.repository.ts
│       └── services/
│           └── email.service.ts
│
├── application/                   # Application Business Rules
│   ├── use-cases/
│   │   ├── create-user.use-case.ts
│   │   └── get-user.use-case.ts
│   ├── dto/
│   │   ├── create-user.dto.ts
│   │   └── user-response.dto.ts
│   └── mappers/
│       └── user.mapper.ts
│
├── infrastructure/                 # Frameworks & Drivers
│   ├── persistence/
│   │   ├── prisma/
│   │   │   └── user.repository.ts
│   │   ├── drizzle/
│   │   │   └── user.repository.ts
│   │   └── unit-of-work.ts
│   ├── messaging/
│   │   ├── rabbitmq.publisher.ts
│   │   └── redis-event-bus.ts
│   └── config/
│       └── env.ts
│
├── presentation/                   # Interface Adapters
│   ├── controllers/
│   │   └── user.controller.ts     # Thin handler
│   ├── middleware/
│   │   ├── error-handler.ts
│   │   ├── auth.ts
│   │   └── validate.ts
│   └── routes/
│       └── user.routes.ts
│
├── animations/                     # Frontend animation modules
│   ├── gsap-config.ts
│   ├── scroll-reveal.ts
│   └── text-split.ts
├── canvas/                         # Canvas/WebGL modules
├── dom/                            # DOM utility modules
├── types/
├── utils/
└── __tests__/
```

### NestJS Enterprise Patterns
```typescript
// Module
@Module({
  imports: [TypeOrmModule.forFeature([User])],
  controllers: [UserController],
  providers: [
    { provide: UserRepository, useClass: PrismaUserRepository },
    CreateUserUseCase,
    GetUserUseCase,
  ],
})
export class UserModule {}

// Use Case (NestJS Injectable)
@Injectable()
export class CreateUserUseCase {
  constructor(
    @Inject(UserRepository) private readonly userRepo: UserRepository,
    @Inject(EventBus) private readonly eventBus: EventBus,
  ) {}

  async execute(cmd: CreateUserCommand): Promise<User> {
    const user = User.create(cmd.name, cmd.email);
    await this.userRepo.save(user);
    await this.eventBus.publish(new UserCreatedEvent(user.id));
    return user;
  }
}

// Thin Controller
@Controller('v1/users')
export class UserController {
  constructor(private readonly createUserUseCase: CreateUserUseCase) {}

  @Post()
  @HttpCode(201)
  async create(@Body() body: CreateUserRequest): Promise<UserResponse> {
    const user = await this.createUserUseCase.execute(CreateUserMapper.toCommand(body));
    return UserMapper.toResponse(user);
  }
}
```

### Unit of Work (NestJS)
```typescript
@Injectable()
export class PrismaUnitOfWork {
  constructor(private readonly prisma: PrismaService) {}

  async runInTransaction<T>(fn: (tx: PrismaClient) => Promise<T>): Promise<T> {
    return this.prisma.$transaction(async (tx) => {
      return fn(tx);
    });
  }
}
```

## Best Practices

### TypeScript
- Enable `"strict": true` in tsconfig.json
- Use `interface` for object shapes, `type` for unions/intersections
- Prefer `unknown` over `any`; use type guards
- Use `as const` assertions for literal types
- Leverage template literal types for string patterns
- Use branded types for domain identifiers

### Code Quality
- ESLint with `@typescript-eslint` and strict config
- Prettier for consistent formatting
- Use `vitest` for unit tests (faster than Jest)
- Use `tsx` for quick TypeScript execution without build step
- Pre-commit hooks with `lint-staged` and `husky`

### Backend Architecture
- **Dependency Rule**: Domain NEVER imports from infrastructure/presentation
- Use dependency injection (NestJS or custom containers)
- Separate concerns: controllers → use cases → repositories
- Use middleware for cross-cutting concerns (logging, auth, validation)
- Implement centralized error handling with custom error classes
- Use `Result<T, E>` pattern for errors
- Mock at port boundaries in tests

### Animation Performance
- Use `transform` and `opacity` for GPU-accelerated animations
- Prefer CSS animations over JS for simple transitions
- Use `will-change` sparingly; remove after animation
- Lazy-load heavy libraries (Three.js, GSAP) with dynamic `import()`
- Use `IntersectionObserver` to trigger only when visible
- Respect `prefers-reduced-motion`
- Profile with browser DevTools Performance panel

### DOM Manipulation
- Use `querySelector`/`querySelectorAll` over older methods
- Prefer `classList.add/remove/toggle` over `className` manipulation
- Use `dataset` for custom data attributes
- Batch DOM reads and writes to avoid layout thrashing
- Use `DocumentFragment` for batch DOM insertions
- Use `AbortController` to clean up event listeners

### Validation
- Define schemas with Zod at API boundaries
- Validate request bodies, params, and query strings
- Use Zod for environment variable validation
- Generate TypeScript types from Zod schemas with `z.infer<>`

### Performance
- Use connection pooling for databases
- Implement caching with Redis or in-memory LRU
- Use `cluster` module for multi-core utilization
- Stream large files instead of buffering
- Use `--max-old-space-size` for memory management
