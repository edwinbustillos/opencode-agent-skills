---
name: react-frontend
description: Expert React/Next.js frontend development with TypeScript, state management, animation engines (GSAP, Framer Motion), styled-components, Tailwind CSS, landing pages, performance optimization, and modern UI patterns
metadata:
  languages: typescript,javascript
  frameworks: react,nextjs,remix,styled-components,tailwind,gsap,framer-motion
---

## What I do

I build production-grade React applications with modern patterns and immersive experiences:

- **React 18+**: Server Components, Suspense, transitions, concurrent features
- **Next.js 14+**: App Router, Server Actions, ISR, middleware, image optimization
- **State Management**: Zustand (preferred), TanStack Query, Jotai, Redux Toolkit
- **Forms**: React Hook Form + Zod validation, server actions
- **Styling**: Tailwind CSS, CSS Modules, styled-components, Radix UI primitives
- **Animation**: GSAP (ScrollTrigger, SplitText), Framer Motion (layout animations), Anime.js
- **3D/Particles**: Three.js (React Three Fiber), Particles.js, Atropos parallax
- **Testing**: Vitest, React Testing Library, Playwright, Storybook
- **Performance**: Code splitting, lazy loading, memoization, bundle analysis
- **Accessibility**: WCAG 2.1, semantic HTML, ARIA, keyboard navigation
- **Type Safety**: TypeScript strict mode, type-safe API calls
- **Landing Pages**: High-conversion layouts, hero sections, scroll storytelling

## When to use me

- Building new React/Next.js applications
- Migrating from Pages Router to App Router
- Implementing state management solutions
- Designing accessible UI components
- Setting up testing strategies (unit, integration, E2E)
- Optimizing bundle size and Core Web Vitals
- Creating design system components with Storybook
- Implementing authentication flows (NextAuth, Clerk)
- Building immersive landing pages with scroll animations
- Adding 3D backgrounds or particle effects
- Implementing kinetic typography and text animations
- Creating shared layout animations between routes

## CSS & Styling

### Tailwind CSS
- Utility-first composition with custom design tokens
- Extend `tailwind.config.ts` for project-specific scales
- Use `clsx` or `cn` (cva) for conditional classes
- Implement dark mode with `dark:` variant
- Container queries for component-level responsiveness

### styled-components
- CSS-in-JS with full TypeScript support
- Dynamic props for conditional styling
- Theme provider for design token distribution
- Global styles with `createGlobalStyle`
- Server-side rendering with `ServerStyleSheet`
- Polymorphic `as` prop for component composition
- Atomic CSS extraction with `babel-plugin-styled-components`

```tsx
const StyledButton = styled.button<{ $variant: 'primary' | 'secondary' }>`
  background: ${({ $variant, theme }) =>
    $variant === 'primary' ? theme.colors.primary : theme.colors.secondary};
  padding: ${({ theme }) => theme.spacing.md};
  border-radius: ${({ theme }) => theme.radius.sm};
  transition: all 0.2s ease;

  &:hover {
    transform: translateY(-2px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  }

  &:focus-visible {
    outline: 2px solid ${({ theme }) => theme.colors.focus};
    outline-offset: 2px;
  }
`;
```

### CSS Modules
- Scoped class names by default
- Compose classes with `classNames` library
- Type-safe with `*.module.css.d.ts` declarations
- Zero runtime overhead

## Animation & Motion

### GSAP in React
- Use `useGSAP` hook for cleanup-safe animations
- ScrollTrigger with React refs for scroll-driven effects
- SplitText for kinetic typography
- Timeline sequencing for orchestrated reveals
- Flip animations for route transitions

```tsx
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

function HeroSection() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(".hero-title", {
      y: 80,
      opacity: 0,
      duration: 1,
      ease: "power3.out",
      scrollTrigger: {
        trigger: containerRef.current,
        start: "top center",
        scrub: true,
      },
    });
  }, { scope: containerRef });

  return <div ref={containerRef}>...</div>;
}
```

### Framer Motion (Motion)
- Declarative animations with `<motion.div>`
- Layout animations with `layout` and `layoutId`
- Shared layout animations between routes (`AnimatePresence`)
- Gesture animations (hover, tap, drag)
- Scroll-driven with `useScroll` and `useInView`
- Spring physics with configurable stiffness/damping
- Exit animations for unmounting components

```tsx
import { motion, AnimatePresence } from "framer-motion";

function Card({ children, id }: { children: React.ReactNode; id: string }) {
  return (
    <motion.div
      layoutId={`card-${id}`}
      initial={{ opacity: 0, scale: 0.9 }}
      animate={{ opacity: 1, scale: 1 }}
      exit={{ opacity: 0, scale: 0.9 }}
      transition={{ type: "spring", stiffness: 300, damping: 30 }}
      whileHover={{ y: -4 }}
    >
      {children}
    </motion.div>
  );
}
```

### React Three Fiber (Three.js)
- Declarative 3D scenes in React
- `<Canvas>` component for renderer setup
- `<mesh>`, `<boxGeometry>`, `<meshStandardMaterial>` primitives
- `useFrame` for animation loops
- `@react-three/drei` for helpers (OrbitControls, Text, Float)
- `@react-three/postprocessing` for bloom, DOF effects
- Suspense-bound model loading

```tsx
import { Canvas, useFrame } from "@react-three/fiber";
import { Float, Text3D, OrbitControls } from "@react-three/drei";

function Scene() {
  const meshRef = useRef<THREE.Mesh>(null);
  useFrame((state) => {
    meshRef.current.rotation.y = state.clock.elapsedTime * 0.5;
  });

  return (
    <Canvas>
      <ambientLight intensity={0.5} />
      <pointLight position={[10, 10, 10]} />
      <Float>
        <mesh ref={meshRef}>
          <icosahedronGeometry args={[1, 1]} />
          <meshStandardMaterial color="#00ff88" wireframe />
        </mesh>
      </Float>
      <OrbitControls />
    </Canvas>
  );
}
```

## Project Structure

```
src/
├── app/                         # App Router
│   ├── layout.tsx               # Root layout
│   ├── page.tsx                 # Home page
│   ├── loading.tsx              # Loading UI
│   ├── error.tsx                # Error boundary
│   ├── not-found.tsx
│   ├── (auth)/                  # Route group
│   │   ├── login/
│   │   │   └── page.tsx
│   │   └── layout.tsx
│   └── dashboard/
│       ├── page.tsx
│       └── settings/
│           └── page.tsx
├── components/
│   ├── ui/                      # Design system primitives
│   │   ├── button.tsx
│   │   ├── input.tsx
│   │   └── card.tsx
│   ├── features/                # Feature-specific components
│   │   └── auth/
│   │       └── login-form.tsx
│   ├── layout/
│   │   ├── header.tsx
│   │   └── sidebar.tsx
│   ├── animations/              # Reusable animation wrappers
│   │   ├── fade-in.tsx
│   │   ├── slide-up.tsx
│   │   ├── stagger-container.tsx
│   │   └── text-reveal.tsx
│   └── three/                   # 3D components
│       ├── scene.tsx
│       ├── particles.tsx
│       └── hero-background.tsx
├── lib/
│   ├── api.ts                   # API client
│   ├── utils.ts                 # Utility functions
│   └── constants.ts
├── hooks/
│   ├── use-user.ts
│   ├── use-debounce.ts
│   ├── use-scroll-position.ts
│   ├── use-in-view.ts
│   └── use-reduced-motion.ts
├── stores/
│   └── ui-store.ts              # Zustand store
├── types/
│   ├── api.ts
│   └── models.ts
├── styles/
│   └── globals.css
├── middleware.ts
├── tailwind.config.ts
├── tsconfig.json
├── next.config.js
├── vitest.config.ts
└── playwright.config.ts
```

## Best Practices

### Component Design
- Use Server Components by default; add `"use client"` only when needed
- Keep components small and focused (single responsibility)
- Use composition over prop drilling
- Implement proper error boundaries
- Use `React.memo` judiciously (only when profiling shows benefit)
- Co-locate animations with their components

### State Management
- Use TanStack Query for server state (caching, refetching, optimistic updates)
- Use Zustand for simple client state (preferred over Redux)
- Avoid useState for derived state; use useMemo/useCallback instead
- Keep state as close to where it's used as possible
- Use URL state for filter/sort/pagination

### Animation Performance
- Use `transform` and `opacity` for GPU-accelerated animations
- Lazy-load heavy 3D scenes with `next/dynamic`
- Respect `prefers-reduced-motion` with a shared hook
- Use `IntersectionObserver` to trigger animations only when visible
- Remove `will-change` after animation completes
- Profile with Chrome DevTools Performance panel

### Performance
- Use Next.js `Image` and `Link` components
- Implement dynamic imports with `next/dynamic`
- Use `loading.tsx` and `Suspense` for streaming
- Analyze bundle with `@next/bundle-analyzer`
- Avoid dynamic tailwind classes in production

### Type Safety
- Enable `"strict": true` in tsconfig
- Use type-safe API routes with Zod validation
- Define types for all component props
- Use `satisfies` operator for type narrowing
- Avoid `any`; use `unknown` and type guards

### Accessibility
- Use semantic HTML elements (`nav`, `main`, `article`, `button`)
- Implement focus management with `ref` and `tabIndex`
- Add `aria-label` for icon-only buttons
- Test with screen readers (VoiceOver, NVDA)
- Ensure keyboard navigation for all interactive elements
- Provide `aria-live` regions for dynamic content
- Respect `prefers-reduced-motion` for all animations
