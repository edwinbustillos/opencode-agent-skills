# OpenCode Agent Team

Equipe de desenvolvimento de elite para o [OpenCode](https://opencode.ai). Instalador cross-platform (Linux, macOS, Windows) que configura skills especializadas, agentes, LSP e MCP servers globalmente.

## Requisitos

- **OpenCode** instalado e funcionando (`opencode --version`)

## Instalação

### Linux / macOS

```bash
git clone https://github.com/seu-usuario/opencode-agent.git
cd opencode-agent
chmod +x install.sh
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/seu-usuario/opencode-agent.git
cd opencode-agent
.\install.ps1
```

### Windows (clique duplo)

Execute `install.bat` — abre o PowerShell automaticamente.

## O que é instalado

### 20 Skills Especializadas

| Skill | Descrição |
|-------|-----------|
| `python-backend` | FastAPI, Django, Flask, SQLAlchemy, Pydantic |
| `javascript-typescript` | Node.js, TypeScript, Express, NestJS, Next.js |
| `flutter-mobile` | Flutter/Dart, Riverpod, Clean Architecture |
| `java-backend` | Spring Boot 3.x, Hibernate, JUnit 5 |
| `golang-backend` | Gin, Echo, Fiber, gRPC, Cloud-native |
| `rust-systems` | Actix, Axum, Tokio, WebAssembly |
| `cpp-systems` | C++17/20, CMake, RAII, performance |
| `react-frontend` | React 18+, Next.js 14+, Zustand |
| `angular-frontend` | Angular 17+, RxJS, NgRx, signals |
| `api-design` | REST, GraphQL, gRPC, JWT, OAuth2 |
| `database-orm` | Prisma, SQLAlchemy, Hibernate, GORM |
| `cloud-aws` | Lambda, ECS, RDS, DynamoDB, Terraform |
| `cloud-azure` | AKS, Functions, Cosmos DB, Bicep |
| `devops-cicd` | Docker, Kubernetes, Helm, ArgoCD |
| `ui-ux-design` | Design systems, WCAG, responsividade |
| `security-audit` | OWASP Top 10, SAST/DAST |
| `testing-strategy` | Test pyramid, TDD, E2E |
| `performance-optimization` | Profiling, caching, load testing |
| `project-setup` | Scaffolding universal |
| `arduino-embedded` | ESP8266/ESP32, ATmega, sensores, displays, motores |

### 6 Agentes Especializados

| Agente | Função |
|--------|--------|
| `@tech-lead` | Coordenação e decisões arquiteturais (primary) |
| `@code-reviewer` | Revisão de código (somente leitura) |
| `@devops-engineer` | CI/CD, Docker, Kubernetes |
| `@security-specialist` | Auditoria de segurança (somente leitura) |
| `@data-engineer` | Modelagem e queries de banco |
| `@arduino-engineer` | Dispositivos embarcados, IoT, hardware |

### Configuração

- **LSP**: Auto-detectado para Python, TypeScript, Go, Rust, Java, Dart, C/C++, Arduino
- **MCP**: Context7 (documentação), Grep by Vercel (busca de código)
- **Permissões**: Comandos seguros auto-aprovados, comandos perigosos bloqueados

## Uso

```bash
opencode
```

### Navegação

- **Tab** — Alternar entre Build e Plan
- **@nome** — Invocar subagente
- **@general** — Tarefas paralelas

### Exemplos

```
@arduino-engineer Crie um sistema de monitoramento com ESP32 + DHT22 + OLED

@api-design Projete uma REST API para gestão de pedidos

@code-reviewer Revise este código buscando vulnerabilidades

@devops-engineer Crie um pipeline CI/CD com GitHub Actions
```

### Skills são carregadas sob demanda

O agente detecta automaticamente qual skill usar baseado na sua solicitação. Não precisa pedir explicitamente.

## Desinstalação

### Linux / macOS
```bash
./uninstall.sh
```

### Windows
```powershell
.\uninstall.ps1
```

Ou clique duplo em `uninstall.bat`.

## Estrutura

```
opencode-agent/
├── opencode.json          # Configuração global
├── AGENTS.md              # Regras globais
├── install.sh             # Instalador Linux/macOS
├── install.ps1            # Instalador Windows
├── install.bat            # Wrapper Windows
├── uninstall.sh           # Desinstalador Linux/macOS
├── uninstall.ps1          # Desinstalador Windows
├── uninstall.bat          # Wrapper Windows
├── README.md
├── .gitignore
└── .opencode/
    ├── skills/            # 20 skills
    │   ├── python-backend/
    │   ├── arduino-embedded/
    │   └── ... (20 total)
    └── agents/            # 6 agentes
        ├── tech-lead.md
        ├── arduino-engineer.md
        └── ... (6 total)
```

## Licença

MIT
