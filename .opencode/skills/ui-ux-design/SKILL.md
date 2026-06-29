---
name: ui-ux-design
description: "Expert UI/UX design with 67 styles, 161 color palettes, 57 font pairings, 99 UX guidelines, 25 chart types, design systems, CSS frameworks, animation engines, 3D/particle effects, landing pages, accessibility (WCAG), responsive design, typography, color theory, motion design, and reasoning engine for industry-specific design system generation."
metadata:
  domains: ui,ux,design-systems,accessibility,animation,3d,landing-pages,styles,typography,color-palettes,charts
  tools: figma,css,tailwind,bootstrap,bulma,vuetify,gsap,threejs,framer-motion,animejs
  data: 67-styles,161-colors,57-typography,99-ux-guidelines,25-charts,8-landing-patterns
---

## What I do

I create accessible, beautiful, and consistent user interfaces with immersive experiences. I use a **reasoning engine** to generate complete design systems tailored to your product type and industry.

### Core Capabilities
- **Design System Generation**: Complete systems with style, colors, typography, effects
- **67 UI Styles**: From Minimalism to AI-Native UI, each with implementation checklists
- **161 Color Palettes**: Industry-specific palettes with WCAG compliance built-in
- **57 Font Pairings**: Curated Google Fonts combinations with mood matching
- **99 UX Guidelines**: Prioritized rules from CRITICAL to LOW
- **25 Chart Types**: Data visualization recommendations by data type
- **8 Landing Page Patterns**: Conversion-optimized layouts
- **CSS Frameworks**: Tailwind, Bootstrap, Bulma, Vuetify, Material UI
- **Animation Engines**: GSAP, Motion (Framer Motion), Anime.js, CSS keyframes
- **3D & Particles**: Three.js, Particles.js, Atropos, WebGL canvas
- **Accessibility**: WCAG 2.1 AA/AAA compliance, screen readers, keyboard nav

## When to use me

### Must Use
- Designing new pages (Landing, Dashboard, Admin, SaaS, Mobile App)
- Creating or refactoring UI components
- Choosing color schemes, typography, spacing, or layout systems
- Reviewing UI code for accessibility or visual consistency
- Implementing animations, transitions, or responsive behavior
- Building design systems or reusable component libraries

### Recommended
- UI looks "not professional enough" but reason is unclear
- Pre-launch UI quality optimization
- Aligning cross-platform design (Web / iOS / Android)
- Receiving feedback on usability or experience

## Reasoning Engine Workflow

### Step 1: Analyze Requirements
Extract from user request:
- **Product type**: SaaS, e-commerce, healthcare, gaming, etc.
- **Target audience**: B2B, B2C, developers, consumers
- **Style keywords**: playful, minimal, dark mode, immersive
- **Stack**: React, Next.js, Vue, Angular, Flutter, etc.

### Step 2: Generate Design System
Combine data from `data/` CSVs:
1. Match product type → `data/colors.csv` row
2. Select style → `data/styles.csv` matching entry
3. Choose typography → `data/typography.csv` pairing
4. Apply UX rules → `data/ux-guidelines.csv` by priority
5. Select landing pattern → `data/landing-patterns.csv`
6. Choose chart types → `data/chart-types.csv`

### Step 3: Validate with Pre-Delivery Checklist
Run through the checklist below before delivering code.

## Rule Categories by Priority

| Priority | Category | Impact | Key Checks | Anti-Patterns |
|----------|----------|--------|------------|---------------|
| 1 | Accessibility | CRITICAL | Contrast 4.5:1, Alt text, Keyboard nav, Aria-labels | Removing focus rings, Icon-only buttons without labels |
| 2 | Touch & Interaction | CRITICAL | Min 44×44px, 8px+ spacing, Loading feedback | Hover-only reliance, Instant state changes |
| 3 | Performance | HIGH | WebP/AVIF, Lazy loading, CLS < 0.1 | Layout thrashing, unoptimized images |
| 4 | Style Selection | HIGH | Match product type, Consistency, SVG icons | Mixing flat & skeuomorphic, Emoji as icons |
| 5 | Layout & Responsive | HIGH | Mobile-first, Viewport meta, No horizontal scroll | Fixed px widths, Disable zoom |
| 6 | Typography & Color | MEDIUM | Base 16px, Line-height 1.5, Semantic tokens | Text < 12px, Gray-on-gray, Raw hex |
| 7 | Animation | MEDIUM | 150–300ms, Motion has meaning, Reduced motion | Decorative-only, Animating width/height |
| 8 | Forms & Feedback | MEDIUM | Visible labels, Error near field, Progressive disclosure | Placeholder-only labels, Errors at top |
| 9 | Navigation | HIGH | Predictable back, Bottom nav ≤5, Deep links | Overloaded nav, Broken back |
| 10 | Charts & Data | LOW | Legends, Tooltips, Accessible colors | Color-only meaning |

## UI Styles (67)

### General Styles (49)

| # | Style | Best For | Complexity |
|---|-------|----------|------------|
| 1 | Minimalism & Swiss Style | Enterprise, dashboards, docs | Low |
| 2 | Neumorphism | Health/wellness, meditation | Medium |
| 3 | Glassmorphism | Modern SaaS, financial dashboards | Medium |
| 4 | Brutalism | Design portfolios, artistic projects | Low |
| 5 | 3D & Hyperrealism | Gaming, product showcase, immersive | High |
| 6 | Vibrant & Block-based | Startups, creative agencies, gaming | Medium |
| 7 | Dark Mode (OLED) | Night-mode, coding platforms | Low |
| 8 | Accessible & Ethical | Government, healthcare, education | Low |
| 9 | Claymorphism | Educational apps, children's apps | Medium |
| 10 | Aurora UI | Modern SaaS, creative agencies | Medium |
| 11 | Retro-Futurism | Gaming, entertainment, music | Medium |
| 12 | Flat Design | Web apps, mobile apps, MVPs | Low |
| 13 | Skeuomorphism | Legacy apps, gaming, premium | High |
| 14 | Liquid Glass | Premium SaaS, high-end e-commerce | High |
| 15 | Motion-Driven | Portfolio sites, storytelling | High |
| 16 | Micro-interactions | Mobile apps, touchscreen UIs | Medium |
| 17 | Inclusive Design | Public services, education, healthcare | Low |
| 18 | Zero Interface | Voice assistants, AI platforms | Low |
| 19 | Soft UI Evolution | Modern enterprise, SaaS | Medium |
| 20 | Neubrutalism | Gen Z brands, startups | Low |
| 21 | Bento Box Grid | Dashboards, product pages | Medium |
| 22 | Y2K Aesthetic | Fashion, music, Gen Z | Medium |
| 23 | Cyberpunk UI | Gaming, tech products, crypto | Medium |
| 24 | Organic Biophilic | Wellness, sustainability brands | Medium |
| 25 | AI-Native UI | AI products, chatbots, copilots | Medium |
| 26 | Memphis Design | Creative agencies, music, youth | Medium |
| 27 | Vaporwave | Music platforms, gaming | Medium |
| 28 | Dimensional Layering | Dashboards, card layouts | Medium |
| 29 | Exaggerated Minimalism | Fashion, architecture | Medium |
| 30 | Kinetic Typography | Hero sections, marketing sites | Medium |
| 31 | Parallax Storytelling | Brand storytelling, product launches | High |
| 32 | Swiss Modernism 2.0 | Corporate, architecture, editorial | Low |
| 33 | HUD / Sci-Fi FUI | Sci-fi games, space tech, cybersecurity | High |
| 34 | Pixel Art | Indie games, retro tools | Medium |
| 35 | Bento Grids | Product features, dashboards | Medium |
| 36 | Spatial UI (VisionOS) | Spatial computing, VR/AR | High |
| 37 | E-Ink / Paper | Reading apps, digital newspapers | Low |
| 38 | Gen Z Chaos / Maximalism | Gen Z lifestyle, music artists | Medium |
| 39 | Biomimetic / Organic 2.0 | Sustainability tech, biotech | Medium |
| 40 | Anti-Polish / Raw Aesthetic | Creative portfolios, artist sites | Low |
| 41 | Tactile Digital / Deformable UI | Modern mobile apps, playful brands | High |
| 42 | Nature Distilled | Wellness brands, sustainable products | Low |
| 43 | Interactive Cursor Design | Creative portfolios, interactive | High |
| 44 | Voice-First Multimodal | Voice assistants, accessibility | Medium |
| 45 | 3D Product Preview | E-commerce, furniture, fashion | High |
| 46 | Gradient Mesh / Aurora Evolved | Hero sections, backgrounds | Medium |
| 47 | Editorial Grid / Magazine | News sites, blogs, magazines | Low |
| 48 | Chromatic Aberration / RGB Split | Music platforms, gaming | Medium |
| 49 | Vintage Analog / Retro Film | Photography, music/vinyl brands | Medium |

### Landing Page Styles (8)

| # | Style | Best For |
|---|-------|----------|
| 1 | Hero-Centric Design | Products with strong visual identity |
| 2 | Conversion-Optimized | Lead generation, sales pages |
| 3 | Feature-Rich Showcase | SaaS, complex products |
| 4 | Minimal & Direct | Simple products, apps |
| 5 | Social Proof-Focused | Services, B2C products |
| 6 | Interactive Product Demo | Software, tools |
| 7 | Trust & Authority | B2B, enterprise, consulting |
| 8 | Storytelling-Driven | Brands, agencies, nonprofits |

### Dashboard Styles (10)

| # | Style | Best For |
|---|-------|----------|
| 1 | Data-Dense Dashboard | Complex data analysis |
| 2 | Heat Map Style | Geographic/behavior data |
| 3 | Executive Dashboard | C-suite summaries |
| 4 | Real-Time Monitoring | Operations, DevOps |
| 5 | Drill-Down Analytics | Detailed exploration |
| 6 | Comparative Analysis | Side-by-side comparisons |
| 7 | Predictive Analytics | Forecasting, ML insights |
| 8 | User Behavior Analytics | UX research, product analytics |
| 9 | Financial Dashboard | Finance, accounting |
| 10 | Sales Intelligence | Sales teams, CRM |

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
gsap.registerPlugin(ScrollTrigger);
gsap.from(".hero-title", {
  y: 100, opacity: 0, duration: 1, ease: "power3.out",
  scrollTrigger: { trigger: ".hero", start: "top center", end: "bottom top", scrub: true },
});
```

### Motion (formerly Framer Motion)
- Lightweight motion engine for React
- Declarative animations with `<motion.div>`
- Layout animations with `layout` prop
- Gesture-based animations (hover, tap, drag)
- Spring physics with configurable stiffness/damping
- Exit animations with `AnimatePresence`

```jsx
<motion.div
  initial={{ opacity: 0, y: 50 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ type: "spring", stiffness: 100 }}
  whileHover={{ scale: 1.05 }}
/>
```

### Anime.js
- Flexible, lightweight graphics engine
- CSS properties, SVG attributes, DOM manipulation
- Stagger animations with `anime.stagger()`
- Timeline sequencing and callbacks
- SVG stroke animations and path drawing

```javascript
anime({
  targets: ".square", translateX: 250, rotate: "1turn",
  duration: 800, easing: "easeInOutQuad", delay: anime.stagger(100),
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
- Performance: LOD, frustum culling, instanced meshes

### Particles.js
- Plug-and-play particle systems
- Floating particles, node webs, interactive backgrounds
- Configuration-driven (JSON config object)
- Mouse interaction (hover, click effects)
- Responsive particle density

### Atropos
- Touch-friendly 3D parallax hover effects
- Maps cursor movements to dynamic parallax
- Works on mobile with gyroscope support
- Customizable intensity and perspective

## Quick Reference

### 1. Accessibility (CRITICAL)
- **color-contrast**: Min 4.5:1 normal text, 3:1 large text
- **focus-states**: Visible focus rings 2–4px on all interactive elements
- **alt-text**: Descriptive alt for meaningful images
- **aria-labels**: aria-label for icon-only buttons
- **keyboard-nav**: Tab order matches visual order; full keyboard support
- **form-labels**: Use `<label>` with `for` attribute
- **skip-links**: Skip to main content for keyboard users
- **heading-hierarchy**: Sequential h1→h6, no level skip
- **color-not-only**: Don't convey info by color alone
- **reduced-motion**: Respect `prefers-reduced-motion`
- **touch-target-size**: Min 44×44pt (Apple) / 48×48dp (Material)

### 2. Touch & Interaction (CRITICAL)
- **touch-spacing**: Min 8px gap between touch targets
- **hover-vs-tap**: Use click/tap for primary; don't rely on hover alone
- **loading-buttons**: Disable during async; show spinner
- **cursor-pointer**: Add to clickable elements (Web)
- **tap-delay**: Use `touch-action: manipulation` to reduce 300ms delay

### 3. Performance (HIGH)
- **image-optimization**: WebP/AVIF, responsive srcset/sizes, lazy load
- **image-dimension**: Declare width/height to prevent CLS
- **font-loading**: `font-display: swap/optional` to avoid FOIT
- **critical-css**: Inline above-the-fold CSS
- **lazy-loading**: Dynamic import / route-level splitting
- **virtualize-lists**: For 50+ items
- **main-thread-budget**: Keep per-frame work under ~16ms for 60fps

### 4. Layout & Responsive (HIGH)
- **viewport-meta**: `width=device-width initial-scale=1` (never disable zoom)
- **mobile-first**: Design mobile-first, then scale up
- **breakpoint-consistency**: 375 / 768 / 1024 / 1440
- **readable-font-size**: Min 16px body on mobile
- **line-length**: Mobile 35–60 chars; desktop 60–75 chars
- **horizontal-scroll**: No horizontal scroll on mobile
- **spacing-scale**: 4pt/8dp incremental system
- **z-index-management**: Define layered scale (0/10/20/40/100/1000)
- **viewport-units**: Prefer `min-h-dvh` over `100vh` on mobile

### 5. Typography & Color (MEDIUM)
- **line-height**: 1.5–1.75 for body text
- **font-pairing**: Match heading/body font personalities (see `data/typography.csv`)
- **font-scale**: Consistent type scale (12 14 16 18 24 32)
- **color-semantic**: Define tokens (primary, secondary, error, surface) not raw hex
- **color-dark-mode**: Desaturated/lighter variants, not inverted colors
- **number-tabular**: Use tabular figures for data columns

### 6. Animation (MEDIUM)
- **duration-timing**: 150–300ms micro-interactions; ≤400ms complex transitions
- **transform-performance**: Use `transform`/`opacity` only; avoid width/height
- **easing**: ease-out entering, ease-in exiting
- **motion-meaning**: Every animation must express cause-effect
- **exit-faster-than-enter**: Exit ~60–70% of enter duration
- **stagger-sequence**: 30–50ms per item for lists/grids
- **spring-physics**: Prefer spring curves for natural feel
- **interruptible**: User tap/gesture cancels in-progress animation

### 7. Forms & Feedback (MEDIUM)
- **input-labels**: Visible label per input (not placeholder-only)
- **error-placement**: Below the related field
- **inline-validation**: On blur, not keystroke
- **input-type-keyboard**: Semantic types (email, tel, number)
- **progressive-disclosure**: Reveal complex options progressively
- **error-recovery**: Messages must include clear recovery path
- **multi-step-progress**: Step indicator + back navigation
- **form-autosave**: Auto-save drafts for long forms

### 8. Navigation (HIGH)
- **bottom-nav-limit**: Max 5 items with labels
- **back-behavior**: Predictable and consistent; preserve scroll/state
- **deep-linking**: All key screens reachable via URL
- **nav-label-icon**: Both icon and text label; icon-only harms discoverability
- **nav-state-active**: Current location visually highlighted
- **adaptive-navigation**: Large screens (≥1024px) sidebar; small screens bottom/top nav

### 9. Charts & Data (LOW)
- **chart-type**: Match chart to data (trend→line, comparison→bar, proportion→pie)
- **color-guidance**: Accessible palettes; avoid red/green only
- **data-table**: Provide table alternative for accessibility
- **legend-visible**: Always show legend near chart
- **tooltip-on-interact**: Show exact values on hover/tap
- **empty-data-state**: Meaningful empty state with guidance

## Landing Page Patterns

| Pattern | Sections | Best For |
|---------|----------|----------|
| Hero-Centric | Hero → Features → CTA | Strong visual products |
| Conversion-Optimized | Form → Trust → Urgency | Lead gen, sales |
| Feature-Rich | Hero → Grid → Comparison → CTA | SaaS, complex products |
| Minimal & Direct | Hero → Brief → Single CTA | Simple products |
| Social Proof | Hero → Logos → Testimonials → CTA | Services, B2C |
| Interactive Demo | Hero → Demo → Features → CTA | Software, tools |
| Trust & Authority | Hero → Badges → Case Studies → CTA | B2B, enterprise |
| Storytelling | Chapter 1 → 2 → 3 → CTA | Brands, nonprofits |

## Chart Type Recommendations

| Data Type | Recommended Chart | Avoid |
|-----------|-------------------|-------|
| Trend over time | Line chart | Pie chart |
| Comparison | Bar chart | Line chart |
| Proportion | Donut chart | Bar chart (>5 categories) |
| Correlation | Scatter plot | Pie chart |
| Distribution | Histogram | Line chart |
| Geographic | Choropleth map | Bar chart |
| Flow/Funnel | Funnel chart | Pie chart |
| Hierarchical | Treemap | Bar chart |
| Real-time | Streaming line | Static chart |
| Multi-dimensional | Radar/Spider | Pie chart |

## Pre-Delivery Checklist

### Visual Quality
- [ ] No emojis as icons (use SVG: Heroicons, Lucide)
- [ ] All icons from consistent icon family
- [ ] Pressed states don't shift layout bounds
- [ ] Semantic theme tokens used (no ad-hoc hex)
- [ ] Dark mode contrast verified independently

### Interaction
- [ ] All tappable elements have pressed feedback
- [ ] Touch targets ≥44pt (iOS) / ≥48dp (Android)
- [ ] Micro-interactions 150–300ms with native easing
- [ ] Disabled states visually clear and non-interactive
- [ ] Screen reader focus order matches visual order

### Accessibility
- [ ] Primary text contrast ≥4.5:1 in both light/dark
- [ ] Secondary text contrast ≥3:1
- [ ] Color is not the only indicator
- [ ] Reduced motion respected
- [ ] Dynamic text size supported without breakage
- [ ] All images have alt text

### Layout
- [ ] Safe areas respected for headers, tab bars, CTAs
- [ ] Scroll content not hidden behind fixed bars
- [ ] Verified on 375px, 768px, 1024px, 1440px
- [ ] 4/8dp spacing rhythm maintained
- [ ] No horizontal scroll on mobile

### Performance
- [ ] Images optimized (WebP/AVIF)
- [ ] Lazy loading for below-the-fold
- [ ] CLS < 0.1
- [ ] LCP < 2.5s
- [ ] No layout thrashing

## Animation Performance

- Use `transform` and `opacity` for GPU-accelerated animations
- Avoid animating `width`, `height`, `top`, `left` (triggers layout)
- Use `will-change` sparingly and remove after animation
- Prefer `requestAnimationFrame` for JS-driven animations
- Use `IntersectionObserver` to trigger animations only when visible
- Throttle scroll event handlers
- Use CSS `@media (prefers-reduced-motion: reduce)` to disable non-essential animations
- Profile with Chrome DevTools Performance panel

## Color & Theming

- Design with a limited color palette (5-7 colors)
- Use HSL for color manipulation
- Implement dark mode with `prefers-color-scheme`
- Ensure all states have sufficient contrast (hover, focus, active, disabled)
- Use color as enhancement, not the only indicator
- **See `data/colors.csv` for 161 industry-specific palettes**

## Typography

- Limit to 2-3 font families maximum
- Use system font stacks for performance
- Set line-height to 1.4-1.6 for body text
- Limit line length to 60-80 characters
- Use responsive font sizes with `clamp()`
- Implement `font-display: swap` for web fonts
- **See `data/typography.csv` for 57 curated font pairings**

## Project Structure

```
design-system/
├── tokens/
│   ├── colors.ts
│   ├── typography.ts
│   ├── spacing.ts
│   ├── shadows.ts
│   ├── animations.ts
│   └── index.ts
├── components/
│   ├── Button/
│   │   ├── Button.tsx
│   │   ├── Button.stories.tsx
│   │   ├── Button.test.tsx
│   │   └── Button.module.css
│   ├── Input/
│   ├── Card/
│   ├── Modal/
│   └── index.ts
├── animations/
│   ├── gsap-config.ts
│   ├── scroll-animations.ts
│   ├── transitions.ts
│   └── keyframes.ts
├── three/
│   ├── scene-setup.ts
│   ├── particles.ts
│   └── post-processing.ts
├── landing/
│   ├── Hero.tsx
│   ├── Features.tsx
│   ├── Pricing.tsx
│   ├── Testimonials.tsx
│   └── FAQ.tsx
├── styles/
│   ├── globals.css
│   ├── reset.css
│   ├── themes/
│   │   ├── light.css
│   │   └── dark.css
│   └── utilities.css
├── hooks/
│   ├── use-media-query.ts
│   ├── use-theme.ts
│   ├── use-reduced-motion.ts
│   └── use-in-view.ts
├── tailwind.config.ts
└── package.json
```

## Curated Resources

### FreeFrontend
- Live code blocks for JS animations
- Immersive background effects collection
- Interactive component demos

### Syaning's Awesome Frontend
- Modern SVG charting extensions
- Styling tools and script combinations

### Olivier3lanc Frontend-Links
- Scrolling trackers and micro-interactions
- Gradient shader examples
