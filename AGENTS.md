# AGENTS.md - Regras Globais do Opencode

## Visão Geral
Equipe de desenvolvimento de elite com agentes especializados para todas as stacks tecnológicas.

## Regras Gerais

### Código
- Sempre usar tipagem estrita quando disponível
- Seguir SOLID e princípios DRY/YAGNI
- Escrever código autoexplicativo; comentários apenas para "porquê"
- Usar convenções de nomenclatura da linguagem
- Tratar erros explicitamente; nunca ignorar exceções
- Usar environment variables para configuração

### Arquitetura (Backend Enterprise)
- **Clean Architecture**: Domain → Application → Infrastructure → Presentation
- **Hexagonal (Ports & Adapters)**: Core depende apenas de abstrações (interfaces)
- **SOLID**: SRP, OCP, LSP, ISP, DIP em todos os componentes
- **CQRS**: Separar operações de leitura (Query) de escrita (Command)
- **DDD**: Aggregates, Value Objects, Domain Events, Bounded Contexts
- **Repository Pattern**: Abstrair acesso a dados por trás de interfaces
- **Unit of Work**: Gerenciar transações atomicamente
- **Dependency Rule**: Camadas internas NUNCA dependem de externas

### Git
- Commits convencionais: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- Branch naming: `feat/`, `fix/`, `chore/` + descrição curta
- Nunca commitar segredos ou credenciais

### Segurança
- Nunca expor variáveis de ambiente em código
- Usar parameterized queries contra SQL injection
- Validar e sanitizar todas as entradas
- Implementar autenticação em todos os endpoints
- Usar HTTPS em produção

### Performance
- Otimizar consultas de banco (EXPLAIN ANALYZE)
- Implementar caching quando apropriado
- Usar lazy loading para recursos pesados
- Implementar paginação para listas grandes

### Testes
- Cobrir happy path E edge cases
- Testes unitários para lógica de negócio
- Testes de integração para APIs
- Testes E2E para fluxos críticos

### Documentação
- Manter README atualizado
- Documentar APIs com OpenAPI/Swagger
- Usar docstrings/JSDoc para funções públicas

## Uso de Skills
Carregue a skill correspondente à stack do projeto:
- Python: `python-backend` — inclui Clean Architecture, Ports & Adapters, SOLID, async patterns
- JavaScript/TypeScript: `javascript-typescript` — inclui DOM manipulation, GSAP, Anime.js, Three.js vanilla, Canvas 2D, Web Animations API, Clean Architecture backend
- React/Next.js: `react-frontend` — inclui Framer Motion, React Three Fiber, styled-components, GSAP, landing pages
- Angular: `angular-frontend` — inclui Vuetify, Angular Animations, GSAP, landing pages
- Flutter/Dart: `flutter-mobile`
- Java/Spring: `java-backend` — inclui Hexagonal, CQRS, DDD, enterprise patterns
- Go: `golang-backend` — inclui Clean Architecture, Hexagonal, concorrência
- Rust: `rust-systems`
- C/C++: `cpp-systems`
- APIs: `api-design` — REST, GraphQL, gRPC, OpenAPI 3.1, idempotência, contratos, API gateway
- Banco de dados: `database-orm` — Repository, Unit of Work, DDD, Data Mapper, migrations, queries otimizadas
- AWS: `cloud-aws`
- Azure: `cloud-azure`
- DevOps: `devops-cicd`
- UI/UX Design: `ui-ux-design` — design systems, CSS frameworks (Tailwind, Bootstrap, Bulma, Vuetify), animação (GSAP, Motion, Anime.js), 3D/particle (Three.js, Particles.js, Atropos), landing pages, acessibilidade
- Segurança: `security-audit`
- Testes: `testing-strategy`
- Performance: `performance-optimization` — inclui Animation & Rendering Performance (GPU acceleration, will-change, RAF, IntersectionObserver)
- Setup: `project-setup`
- Arduino/Embarcados: `arduino-embedded`
- 3D/Immersive Web: `frontend-3d` — React Three Fiber, Three.js, GLSL shaders, GSAP, Post-Processing, sites Awwwards

## Agentes Disponíveis
- `tech-lead` — Coordenação e arquitetura
- `backend-developer` — APIs, autenticação, microsserviços, SOLID, Clean Architecture, Hexagonal, CQRS, DDD, padrões enterprise
- `frontend-developer` — React, Angular, Flutter, UI/UX, performance
- `ui-ux-designer` — Design de interfaces, frameworks CSS, animações GSAP/Motion/Anime.js, 3D/Three.js/Particles.js, landing pages de alta conversão, acessibilidade
- `qa-engineer` — Testes automatizados, TDD/BDD, E2E
- `code-reviewer` — Revisão de código, qualidade, segurança
- `data-engineer` — Modelagem, ETL, pipelines
- `devops-engineer` — CI/CD, Docker, Kubernetes, infraestrutura
- `security-specialist` — Auditoria de segurança, OWASP, hardening
- `arduino-engineer` — Arduino, ESP, embarcados
- `frontend-3d` — Sites 3D imersivos, React Three Fiber, Three.js, GLSL shaders, GSAP, Post-Processing, efeitos visuais Awwwards
