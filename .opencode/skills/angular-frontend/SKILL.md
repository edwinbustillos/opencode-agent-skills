---
name: angular-frontend
description: Expert Angular development with TypeScript, RxJS, NgRx, signals, standalone components, Vuetify, animation engines (GSAP, Angular Animations), CSS frameworks (Tailwind, Bootstrap, Bulma), landing pages, and enterprise patterns
metadata:
  languages: typescript
  frameworks: angular,rxjs,ngrx,vuetify,tailwind,gsap
---

## What I do

I build production-grade Angular applications with enterprise patterns and immersive experiences:

- **Angular 17+**: Standalone components, signals, new control flow syntax
- **RxJS**: Operators, Subject patterns, switchMap, mergeMap, debounce
- **State Management**: NgRx (store, effects, entity adapter), signals
- **Routing**: Lazy loading, route guards, resolvers, child routes
- **Forms**: Reactive forms, form validation, dynamic forms
- **CSS Frameworks**: Tailwind CSS, Bootstrap 5, Bulma, Vuetify 3
- **Animation**: Angular Animations, GSAP (ScrollTrigger), Anime.js
- **3D/Particles**: Three.js integration, particle backgrounds
- **Testing**: Jasmine, Karma, Jest (optional), Cypress/Playwright for E2E
- **Material**: Angular Material, CDK, custom theming, responsive breakpoints
- **Performance**: OnPush change detection, lazy loading, tree shaking
- **SSR**: Angular Universal, hydration, incremental hydration
- **Tooling**: Angular CLI, nx monorepos, ng-add schematics
- **Landing Pages**: High-conversion layouts, hero sections, scroll storytelling

## When to use me

- Building new Angular applications
- Migrating Angular versions (15→17, modules→standalone)
- Implementing NgRx state management
- Designing reactive forms with complex validation
- Setting up lazy-loaded routing
- Optimizing change detection performance
- Creating reusable component libraries
- Implementing Angular Material or Vuetify themes
- Building immersive landing pages with scroll animations
- Adding 3D backgrounds or particle effects to Angular apps
- Integrating GSAP animations with Angular lifecycle

## CSS Frameworks in Angular

### Tailwind CSS with Angular
- Install via `ng add @tailwindcss/cli` or manual setup
- Use `tailwind.config.js` for project-specific tokens
- Integrate with Angular Material themes
- Utility-first approach in templates

```html
<div class="flex items-center gap-4 p-6 bg-white rounded-lg shadow-md
            dark:bg-gray-800 dark:text-white">
  <h2 class="text-xl font-semibold">{{ title }}</h2>
</div>
```

### Bootstrap 5 with Angular
- Use `ng-bootstrap` for native Angular Bootstrap components
- Grid system: `container`, `row`, `col-{breakpoint}`
- Avoid jQuery dependency (ng-bootstrap replaces it)
- Custom Sass theming with Bootstrap variables

### Bulma with Angular
- Pure CSS framework, no JS dependency
- Modifier-based syntax: `.is-primary`, `.is-large`
- Flexbox grid: `.columns`, `.column`
- Form elements with consistent styling

### Vuetify 3 with Angular
- Material Design Component Framework
- Grid system: `v-container`, `v-row`, `v-col`
- Rich component library: `v-btn`, `v-card`, `v-data-table`, `v-dialog`
- Built-in theming with SASS variables
- Dark mode support out of the box
- Responsive breakpoints and display utilities
- Accessibility built-in with ARIA attributes

```html
<v-container>
  <v-row>
    <v-col cols="12" md="6">
      <v-card elevation="2">
        <v-card-title>{{ title }}</v-card-title>
        <v-card-text>{{ content }}</v-card-text>
        <v-card-actions>
          <v-btn color="primary" variant="flat">Action</v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</v-container>
```

## Animation in Angular

### Angular Animations (`@angular/animations`)
- Trigger-based animations with `trigger()`, `state()`, `transition()`
- Enter/leave animations with `:enter` and `:leave`
- Group animations with `group()` and `sequence()`
- Query-based animations with `query()` and `stagger()`
- Route transition animations with `@routeAnimations`

```typescript
@Component({
  animations: [
    trigger('fadeIn', [
      transition(':enter', [
        style({ opacity: 0, transform: 'translateY(20px)' }),
        animate('300ms ease-out', style({ opacity: 1, transform: 'translateY(0)' })),
      ]),
      transition(':leave', [
        animate('200ms ease-in', style({ opacity: 0, transform: 'translateY(-20px)' })),
      ]),
    ]),
    trigger('staggerList', [
      transition('* => *', [
        query(':enter', [
          style({ opacity: 0, transform: 'translateY(20px)' }),
          stagger('50ms', [
            animate('300ms ease-out', style({ opacity: 1, transform: 'translateY(0)' })),
          ]),
        ], { optional: true }),
      ]),
    ]),
  ],
})
```

### GSAP in Angular
- Use `AfterViewInit` lifecycle for DOM-ready animations
- ScrollTrigger with `IntersectionObserver` fallback
- Timeline sequencing for orchestrated reveals
- Register plugins in app initialization

```typescript
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

@Component({
  selector: 'app-hero',
  template: `
    <section #heroSection class="hero">
      <h1 #heroTitle>{{ title }}</h1>
      <p #heroSubtitle>{{ subtitle }}</p>
    </section>
  `,
})
export class HeroComponent implements AfterViewInit, OnDestroy {
  @ViewChild('heroSection') heroSection!: ElementRef;
  @ViewChild('heroTitle') heroTitle!: ElementRef;
  @ViewChild('heroSubtitle') heroSubtitle!: ElementRef;
  private timeline?: gsap.core.Timeline;

  ngAfterViewInit() {
    gsap.registerPlugin(ScrollTrigger);
    this.timeline = gsap.timeline();

    this.timeline
      .from(this.heroTitle.nativeElement, { y: 80, opacity: 0, duration: 1 })
      .from(this.heroSubtitle.nativeElement, { y: 40, opacity: 0, duration: 0.8 }, '-=0.4');
  }

  ngOnDestroy() {
    this.timeline?.kill();
    ScrollTrigger.getAll().forEach(t => t.kill());
  }
}
```

### Anime.js in Angular
- Lightweight alternative for CSS/SVG/DOM animations
- Stagger animations with `anime.stagger()`
- SVG stroke animations
- Works well with Angular template refs

```typescript
import anime from 'animejs';

@Component({
  selector: 'app-animated-list',
  template: `
    <div #listContainer>
      <div *ngFor="let item of items" class="list-item">{{ item.name }}</div>
    </div>
  `,
})
export class AnimatedListComponent implements AfterViewInit {
  @ViewChild('listContainer') listContainer!: ElementRef;

  ngAfterViewInit() {
    anime({
      targets: this.listContainer.nativeElement.querySelectorAll('.list-item'),
      translateX: [50, 0],
      opacity: [0, 1],
      delay: anime.stagger(100),
      duration: 600,
      easing: 'easeOutQuad',
    });
  }
}
```

## Project Structure

```
src/
├── app/
│   ├── app.component.ts
│   ├── app.config.ts            # Standalone config
│   ├── app.routes.ts            # Route definitions
│   ├── core/
│   │   ├── services/
│   │   │   ├── auth.service.ts
│   │   │   └── api.service.ts
│   │   ├── guards/
│   │   │   └── auth.guard.ts
│   │   ├── interceptors/
│   │   │   └── jwt.interceptor.ts
│   │   └── models/
│   │       └── user.model.ts
│   ├── features/
│   │   ├── auth/
│   │   │   ├── login/
│   │   │   │   ├── login.component.ts
│   │   │   │   ├── login.component.html
│   │   │   │   └── login.component.spec.ts
│   │   │   └── auth.routes.ts
│   │   ├── landing/
│   │   │   ├── hero/
│   │   │   │   └── hero.component.ts
│   │   │   ├── features/
│   │   │   │   └── features.component.ts
│   │   │   ├── pricing/
│   │   │   │   └── pricing.component.ts
│   │   │   └── landing.routes.ts
│   │   └── dashboard/
│   │       ├── dashboard.component.ts
│   │       └── dashboard.routes.ts
│   ├── shared/
│   │   ├── components/
│   │   │   └── button/
│   │   ├── directives/
│   │   │   └── scroll-reveal.directive.ts
│   │   ├── pipes/
│   │   └── animations/
│   │       ├── fade-in.animation.ts
│   │       ├── slide-up.animation.ts
│   │       └── route-animations.ts
│   └── store/
│       ├── auth/
│       │   ├── auth.actions.ts
│       │   ├── auth.reducer.ts
│       │   ├── auth.effects.ts
│       │   └── auth.selectors.ts
│       └── app.state.ts
├── assets/
├── environments/
│   ├── environment.ts
│   └── environment.prod.ts
├── styles/
│   ├── _variables.scss
│   ├── _tailwind.scss
│   └── styles.scss
├── angular.json
├── tsconfig.json
├── tailwind.config.js
└── package.json
```

## Best Practices

### Architecture
- Use standalone components (default in Angular 17+)
- Organize by feature modules, not by type
- Use `OnPush` change detection everywhere
- Implement smart/dumb component pattern
- Use signals for simple state; NgRx for complex state

### RxJS Patterns
- Prefer `signal()` over `BehaviorSubject` for simple values
- Use `switchMap` for API calls (cancels previous)
- Use `combineLatest` for dependent observables
- Implement `takeUntilDestroyed()` for cleanup
- Avoid nested subscriptions; use higher-order mapping operators

### Forms
- Use reactive forms over template-driven forms
- Create custom validators as functions
- Use `FormGroup` for related controls
- Implement `ControlValueAccessor` for custom form controls
- Validate on blur, not on every keystroke

### Animation Performance
- Use `@angular/animations` for simple enter/leave
- Use GSAP for complex timelines and scroll-triggered effects
- Respect `prefers-reduced-motion` with `@media` queries or JS checks
- Use `OnPush` with `markForCheck()` when animations update state
- Lazy-load heavy animation libraries with `import()`
- Clean up GSAP timelines in `ngOnDestroy`

### Performance
- Use `OnPush` change detection on all components
- Implement `trackBy` in `*ngFor` loops
- Lazy load feature modules/routes
- Use `NgZone.runOutsideAngular` for non-UI work
- Optimize images with `NgOptimizedImage`

### Testing
- Unit test services and components with Jasmine/Jest
- Use `TestBed` for dependency injection in tests
- Mock HTTP calls with `HttpTestingController`
- Test accessibility with axe-core
- E2E test critical flows with Playwright
