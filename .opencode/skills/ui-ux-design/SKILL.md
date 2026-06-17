---
name: ui-ux-design
description: Expert UI/UX design with design systems, CSS frameworks, animation engines, 3D/particle effects, landing pages, accessibility (WCAG), responsive design, typography, color theory, motion design, and modern design tools
metadata:
  domains: ui,ux,design-systems,accessibility,animation,3d,landing-pages
  tools: figma,css,tailwind,bootstrap,bulma,vuetify,gsap,threejs,framer-motion
---

## What I do

I create accessible, beautiful, and consistent user interfaces with immersive experiences:

- **Design Systems**: Component libraries, design tokens, documentation
- **Accessibility**: WCAG 2.1 AA compliance, screen reader support, keyboard navigation
- **Responsive Design**: Mobile-first, fluid typography, container queries
- **Typography**: Scale systems, font pairing, line height, readability
- **Color Theory**: Color systems, contrast ratios, dark mode, colorblind-safe palettes
- **Motion Design**: Micro-interactions, transitions, animation principles, scroll-triggered effects
- **CSS Frameworks**: Tailwind CSS, Bootstrap 5, Bulma, Vuetify, Material UI
- **CSS Architecture**: Custom properties, modern layouts (Grid, Flexbox), animations, styled-components
- **Design Tokens**: CSS variables, theme switching, multi-platform tokens
- **Component Design**: Atomic design, compound components, headless patterns
- **User Research**: Usability heuristics, accessibility audits, user testing
- **Landing Pages**: High-conversion layouts, hero sections, CTAs, social proof, A/B testing patterns
- **Animation Engines**: GSAP, Motion (Framer Motion), Anime.js, CSS keyframe animations
- **3D & Particle Effects**: Three.js, Particles.js, Atropos parallax, WebGL canvas
- **Interactive Effects**: Kinetic typography, particle reconstruction, scroll storytelling

## When to use me

- Building design systems from scratch
- Auditing and fixing accessibility issues
- Designing responsive layouts with CSS frameworks
- Creating CSS custom property theming systems
- Implementing dark mode
- Designing component APIs
- Creating animation and motion guidelines
- Conducting usability evaluations
- Building high-conversion landing pages
- Implementing complex scroll-triggered animations
- Creating immersive 3D or particle-based backgrounds
- Adding kinetic typography and interactive text effects

## CSS Frameworks

### Tailwind CSS
- Utility-first approach with custom design tokens
- Extend `tailwind.config.ts` with project-specific scales
- Use `@apply` sparingly; prefer utility composition
- Implement dark mode with `dark:` variant
- Use container queries for component-level responsiveness
- Purge unused classes in production builds

### Bootstrap 5
- Grid system (container, row, col-{breakpoint})
- Utility classes for spacing, typography, colors
- Custom Sass variables for theming
- Components: modals, dropdowns, tooltips, popovers
- Responsive helpers: `d-none`, `d-lg-block`, `visually-hidden`

### Bulma
- Modifier-based syntax (`.is-primary`, `.is-large`)
- Flexbox-first grid with `.columns` and `.column`
- Form elements with consistent styling
- Color palette: `is-link`, `is-info`, `is-success`, `is-warning`, `is-danger`
- Responsive breakpoints: `mobile`, `tablet`, `desktop`, `widescreen`, `fullhd`

### Vuetify (Vue/Angular)
- Material Design Component Framework
- Vuetify 3 with Vue 3 Composition API
- Grid system: `v-container`, `v-row`, `v-col`
- Pre-built components: `v-btn`, `v-card`, `v-data-table`, `v-dialog`
- Theming with SASS variables and dark mode support
- Accessibility built-in with ARIA attributes

## Animation & Motion Libraries

### GSAP (GreenSock Animation Platform)
- **Industry standard** for complex, high-performance web animations
- Timeline-based sequencing with `gsap.timeline()`
- Scroll-triggered animations with `ScrollTrigger` plugin
- SVG morphing and path animations
- Text splitting and kinetic typography with `SplitText`
- Flip animations for layout transitions
- Elastic and bounce easing with `CustomEase`
- Performance: GPU-accelerated transforms, `will-change` management

```javascript
// GSAP ScrollTrigger example
gsap.registerPlugin(ScrollTrigger);

gsap.from(".hero-title", {
  y: 100,
  opacity: 0,
  duration: 1,
  ease: "power3.out",
  scrollTrigger: {
    trigger: ".hero",
    start: "top center",
    end: "bottom top",
    scrub: true,
  },
});
```

### Motion (formerly Framer Motion)
- Lightweight motion engine for React
- Declarative animations with `<motion.div>`
- Layout animations with `layout` prop
- Shared layout animations between components
- Gesture-based animations (hover, tap, drag)
- Scroll-driven animations with `useScroll` and `useInView`
- Spring physics with configurable stiffness/damping
- Exit animations with `AnimatePresence`

```jsx
// Motion example
<motion.div
  initial={{ opacity: 0, y: 50 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ type: "spring", stiffness: 100 }}
  whileHover={{ scale: 1.05 }}
>
  {content}
</motion.div>
```

### Anime.js
- Flexible, lightweight graphics engine
- CSS properties, SVG attributes, DOM manipulation
- Stagger animations with `anime.stagger()`
- Timeline sequencing and callbacks
- SVG stroke animations and path drawing
- DOM class/attribute manipulation
- Cross-browser compatible

```javascript
// Anime.js example
anime({
  targets: ".square",
  translateX: 250,
  rotate: "1turn",
  duration: 800,
  easing: "easeInOutQuad",
  delay: anime.stagger(100),
});
```

## 3D & Particle Canvas Engines

### Three.js
- Essential library for hardware-accelerated 3D graphics
- Scene, camera, renderer architecture
- Geometry, materials, lighting systems
- Raycasting for mouse interaction
- GLTF/GLB model loading
- Post-processing effects (bloom, DOF, SSAO)
- Responsive canvas with `ResizeObserver`
- Performance: LOD, frustum culling, instanced meshes

```javascript
// Three.js scene setup
const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, w/h, 0.1, 1000);
const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
const geometry = new THREE.IcosahedronGeometry(1, 1);
const material = new THREE.MeshStandardMaterial({ color: 0x00ff88 });
const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);
```

### Particles.js
- Plug-and-play particle systems
- Floating particles, node webs, interactive backgrounds
- Configuration-driven (JSON config object)
- Mouse interaction (hover, click effects)
- Responsive particle density
- Custom colors, shapes, connections
- Light performance footprint

### Atropos
- Touch-friendly 3D parallax hover effects
- Maps cursor movements to dynamic parallax
- Smooth, physics-based response
- Works on mobile with gyroscope support
- Customizable intensity and perspective
- Lightweight, no dependencies

```javascript
// Atropos example
Atropos({
  el: ".my-element",
  rotateX: true,
  rotateY: true,
  rotateZ: true,
  stretchX: 1,
  stretchY: 1,
  commonOrigin: true,
});
```

## Landing Page Design

### High-Conversion Layout Patterns
- **Hero Section**: Bold headline, sub-headline, primary CTA, social proof badge
- **Feature Grid**: 3-column icons + text, alternating image-text sections
- **Social Proof**: Logos bar, testimonials carousel, case study cards
- **Pricing Table**: 3-tier comparison, feature checklist, highlighted recommended
- **FAQ Accordion**: Common objections addressed, schema markup
- **Footer CTA**: Final conversion push with urgency elements
- **Sticky Header**: Navigation that compacts on scroll, CTA always visible

### Conversion Optimization
- A/B test headline variations (benefit vs. feature vs. social proof)
-above-the-fold CTA placement with no scroll required
- Reduce form fields to minimum required
- Use micro-copy to reduce friction ("No credit card required")
- Progressive disclosure for complex products
- Exit-intent popups with value proposition
- Trust signals near conversion points (badges, reviews, guarantees)

### Performance for Landing Pages
- Critical CSS inlined for above-the-fold
- Lazy load below-the-fold sections
- Preload hero images and fonts
- Minimize third-party scripts
- Use `loading="lazy"` for images
- Implement skeleton screens for perceived performance
- Target LCP < 2.5s, CLS < 0.1

## Interactive Effects to Implement

### Kinetic Typography
- Split text headers into moving layers
- Advanced clipping masks with cursor tracking
- Parallax text movement on scroll
- Text reveal animations (clip-path, mask-image)
- Letter-by-letter stagger with color shifts

### Particle Image Reconstruction
- Deconstruct raster images into autonomous particles
- Morph particle positions on hover
- Reassemble on mouse leave
- Use Canvas 2D or Three.js point sprites
- Control particle size, speed, connection distance

### Scroll-Triggered Storytelling
- Synchronize scroll position with 3D transformations
- Object scaling and viewport reveals
- Cinematic transitions between sections
- Parallax layer depth (foreground, mid, background)
- Pin sections during animation sequences

## Curated Repositories & Inspiration

### FreeFrontend JavaScript Galleries
- Live code blocks for JS animations
- Immersive background effects collection
- Interactive component demos

### Syaning's Awesome Frontend
- Modern SVG charting extensions
- Styling tools and script combinations
- Curated frontend resource aggregation

### Olivier3lanc Frontend-Links
- Scrolling trackers and micro-interactions
- Gradient shader examples
- Open-source indexing tools for frontend inspiration

## Best Practices

### Accessibility (WCAG 2.1 AA)
- Maintain 4.5:1 contrast ratio for normal text, 3:1 for large text
- Use semantic HTML elements (`button`, `nav`, `main`, `article`)
- Implement visible focus indicators on all interactive elements
- Add `alt` text to all meaningful images
- Ensure keyboard navigation for all interactive elements
- Use ARIA landmarks and labels when semantic HTML isn't sufficient
- Test with screen readers (VoiceOver, NVDA, JAWS)
- Provide skip navigation links
- **Motion**: Respect `prefers-reduced-motion` media query
- **3D/Particles**: Provide fallback static backgrounds for reduced motion

### Design Systems
- Define spacing scale (4px base: 4, 8, 12, 16, 24, 32, 48, 64, 96)
- Create consistent border radius scale
- Define type scale with modular ratio (1.250 or 1.333)
- Use design tokens for all visual properties
- Document component usage, variants, and accessibility requirements
- Implement compound components for complex UI patterns

### CSS Architecture
- Use CSS custom properties for theming
- Implement mobile-first media queries
- Use CSS Grid for page layouts, Flexbox for component layouts
- Prefer `rem`/`em` over `px` for typography
- Use `clamp()` for fluid typography
- Implement `prefers-reduced-motion` for motion sensitivity
- Use `contain` property for layout containment
- Leverage `@layer` for cascade management

### Animation Performance
- Use `transform` and `opacity` for GPU-accelerated animations
- Avoid animating `width`, `height`, `top`, `left` (triggers layout)
- Use `will-change` sparingly and remove after animation
- Prefer `requestAnimationFrame` for JS-driven animations
- Use `IntersectionObserver` to trigger animations only when visible
- Throttle scroll event handlers
- Use CSS `@media (prefers-reduced-motion: reduce)` to disable non-essential animations
- Profile with Chrome DevTools Performance panel

### Color & Theming
- Design with a limited color palette (5-7 colors)
- Use HSL for color manipulation
- Implement dark mode with `prefers-color-scheme`
- Ensure all states have sufficient contrast (hover, focus, active, disabled)
- Use color as enhancement, not the only indicator

### Typography
- Limit to 2-3 font families maximum
- Use system font stacks for performance
- Set line-height to 1.4-1.6 for body text
- Limit line length to 60-80 characters
- Use responsive font sizes with `clamp()`
- Implement `font-display: swap` for web fonts

## Project Structure

```
design-system/
├── tokens/
│   ├── colors.ts                # Color tokens
│   ├── typography.ts            # Type scale
│   ├── spacing.ts               # Spacing scale
│   ├── shadows.ts               # Elevation system
│   ├── animations.ts            # Animation tokens (durations, easings)
│   └── index.ts                 # Export all tokens
├── components/
│   ├── Button/
│   │   ├── Button.tsx
│   │   ├── Button.stories.tsx   # Storybook stories
│   │   ├── Button.test.tsx
│   │   └── Button.module.css
│   ├── Input/
│   ├── Card/
│   ├── Modal/
│   └── index.ts
├── animations/
│   ├── gsap-config.ts           # GSAP registration and defaults
│   ├── scroll-animations.ts     # ScrollTrigger presets
│   ├── transitions.ts           # CSS transition classes
│   └── keyframes.ts             # CSS keyframe definitions
├── three/
│   ├── scene-setup.ts           # Three.js boilerplate
│   ├── particles.ts             # Particle system configs
│   └── post-processing.ts       # Bloom, DOF effects
├── landing/
│   ├── Hero.tsx                 # Hero section component
│   ├── Features.tsx             # Feature grid
│   ├── Pricing.tsx              # Pricing table
│   ├── Testimonials.tsx         # Social proof
│   └── FAQ.tsx                  # FAQ accordion
├── styles/
│   ├── globals.css              # Global styles, CSS variables
│   ├── reset.css                # CSS reset/normalize
│   ├── themes/
│   │   ├── light.css
│   │   └── dark.css
│   └── utilities.css            # Utility classes
├── hooks/
│   ├── use-media-query.ts
│   ├── use-theme.ts
│   ├── use-escape.ts
│   ├── use-scroll-position.ts
│   ├── use-in-view.ts
│   └── use-reduced-motion.ts
├── docs/
│   ├── accessibility.md
│   ├── color.md
│   ├── typography.md
│   ├── spacing.md
│   ├── animation-guidelines.md
│   └── landing-page-patterns.md
├── storybook/
│   └── preview.ts
├── tailwind.config.ts           # Tailwind with design tokens
├── bootstrap.config.scss        # Bootstrap customization
└── package.json
```
