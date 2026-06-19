# OpenCode Agent Team

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![OpenCode](https://img.shields.io/badge/OpenCode-compatible-green.svg)](https://opencode.ai)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey.svg)]()

Equipe de desenvolvimento de elite para o [OpenCode](https://opencode.ai). Instalador cross-platform que configura **20 skills especializadas**, **10 agentes**, LSP e MCP servers globalmente.

## Sumario

- [Requisitos](#requisitos)
- [Instalacao](#instalacao)
- [O que e instalado](#o-que-e-instalado)
- [Uso](#uso)
- [Agentes](#agentes)
- [Skills](#skills)
- [Configuracao](#configuracao)
- [Desinstalacao](#desinstalacao)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuicao](#contribuicao)
- [Licenca](#licenca)

## Requisitos

| Requisito | Obrigatorio | Notas |
|-----------|-------------|-------|
| **OpenCode** | Sim | `opencode --version` deve funcionar |
| **curl** | Linux/macOS | Para instalacao automatica do OpenCode |
| **PowerShell 5.1+** | Windows | Ja incluso no Windows 10+ |

### Ferramentas Opcionais (LSP)

Ferramentas de Language Server Protocol para auto-complete e analise de codigo:

| Ferramenta | Linguagem | Instalacao |
|------------|-----------|------------|
| `pyright` | Python | `npm install -g pyright` |
| `gopls` | Go | `go install golang.org/x/tools/gopls@latest` |
| `rust-analyzer` | Rust | `rustup component add rust-analyzer` |
| `clangd` | C/C++ | Via LLVM/Clang |
| `arduino-cli` | Arduino | [arduino-cli](https://arduino.github.io/arduino-cli/) |
| `dart` | Dart/Flutter | Via Flutter SDK |

## Instalacao

### Linux / macOS

```bash
git clone https://github.com/edwinbustillos/opencode-agent-skills.git
cd opencode-agent-skills
chmod +x install.sh
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/edwinbustillos/opencode-agent-skills.git
cd opencode-agent-skills
.\install.ps1
```

### Windows (clique duplo)

Execute `install.bat` - abre o PowerShell automaticamente.

### Instalacao sem git

```bash
curl -fsSL https://github.com/edwinbustillos/opencode-agent-skills/archive/main.tar.gz | tar xz
cd opencode-agent-skills-main
./install.sh
```

## O que e instalado

### Configuracao Global

| Arquivo | Destino | Funcao |
|---------|---------|--------|
| `opencode.json` | `~/.config/opencode/` | Configuracao global do OpenCode |
| `AGENTS.md` | `~/.config/opencode/` | Regras globais para todos os agentes |

### 20 Skills Especializadas

Skills sao carregadas automaticamente pelo agente baseado no contexto da solicitacao.

| Skill | Stack | Descricao |
|-------|-------|-----------|
| `python-backend` | Python | FastAPI, Django, Flask, SQLAlchemy, Pydantic, Clean Architecture |
| `javascript-typescript` | JS/TS | Node.js, Express, NestJS, Next.js, Deno, Bun |
| `flutter-mobile` | Dart | Flutter, Riverpod, Clean Architecture, platform channels |
| `java-backend` | Java | Spring Boot 3.x, Hibernate, JUnit 5, Maven/Gradle |
| `golang-backend` | Go | Gin, Echo, Fiber, gRPC, concorrencia |
| `rust-systems` | Rust | Actix, Axum, Tokio, WebAssembly |
| `cpp-systems` | C/C++ | C++17/20, CMake, RAII, templates |
| `react-frontend` | React | React 18+, Next.js 14+, Zustand, Framer Motion |
| `angular-frontend` | Angular | Angular 17+, RxJS, NgRx, signals |
| `api-design` | API | REST, GraphQL, gRPC, JWT, OAuth2, OpenAPI 3.1 |
| `database-orm` | Database | Prisma, SQLAlchemy, Hibernate, GORM, Drizzle |
| `cloud-aws` | AWS | Lambda, ECS, RDS, DynamoDB, Terraform |
| `cloud-azure` | Azure | AKS, Functions, Cosmos DB, Bicep |
| `devops-cicd` | DevOps | Docker, Kubernetes, Helm, ArgoCD, GitHub Actions |
| `ui-ux-design` | UI/UX | Design systems, Tailwind, Bootstrap, GSAP, Three.js |
| `security-audit` | Security | OWASP Top 10, SAST/DAST, threat modeling |
| `testing-strategy` | Testing | Test pyramid, TDD, BDD, E2E, property-based |
| `performance-optimization` | Perf | Profiling, caching, load testing, optimization |
| `project-setup` | Setup | Scaffolding universal para qualquer stack |
| `arduino-embedded` | Embedded | ESP8266/ESP32, ATmega, sensores, displays, I2C/SPI |

### 10 Agentes Especializados

| Agente | Modo | Funcao | Permissoes |
|--------|------|--------|------------|
| `@tech-lead` | Primary | Coordena equipe, define arquitetura | Leitura + Escrita |
| `@backend-developer` | Subagent | APIs, autenticacao, microsservicos | Leitura + Escrita |
| `@frontend-developer` | Subagent | React, Angular, Flutter, UI/UX | Leitura + Escrita |
| `@qa-engineer` | Subagent | Testes automatizados, TDD/BDD | Leitura + Escrita |
| `@code-reviewer` | Subagent | Revisao de codigo, qualidade | Somente leitura |
| `@security-specialist` | Subagent | Auditoria de seguranca, OWASP | Somente leitura |
| `@data-engineer` | Subagent | Modelagem, ETL, queries | Leitura + Escrita |
| `@devops-engineer` | Subagent | CI/CD, Docker, Kubernetes | Leitura + Escrita |
| `@ui-ux-designer` | Subagent | Design de interfaces, animacoes | Leitura + Escrita |
| `@arduino-engineer` | Subagent | Dispositivos embarcados, IoT | Leitura + Escrita |

### MCP Servers

| Server | Funcao |
|--------|--------|
| [Context7](https://context7.com) | Documentacao atualizada de bibliotecas |
| [Grep by Vercel](https://grep.app) | Busca em repositorios publicos do GitHub |

## Uso

### Iniciar o OpenCode

```bash
opencode
```

### Navegacao

| Tecla/Acao | Funcao |
|------------|--------|
| **Tab** | Alternar entre modo Build (escrita) e Plan (analise) |
| **@nome** | Invocar subagente especifico |
| **@general** | Executar tarefas em paralelo |

### Exemplos de Uso

```
# Desenvolvimento de hardware
@arduino-engineer Crie um sistema de monitoramento com ESP32 + DHT22 + OLED

# Design de API
@api-design Projete uma REST API para gestao de pedidos com autenticacao JWT

# Revisao de codigo
@code-reviewer Revise este codigo buscando vulnerabilidades e problemas de performance

# DevOps
@devops-engineer Crie um pipeline CI/CD com GitHub Actions para este projeto

# Testes
@qa-engineer Escreva testes E2E para o fluxo de checkout

# Seguranca
@security-specialist Faca uma auditoria de seguranca nesta API

# Frontend
@frontend-developer Crie uma landing page responsiva com animacoes GSAP

# Backend
@backend-developer Implemente um sistema de cache com Redis
```

### Como os Agentes Funcionam

1. **Skills automaticas**: O agente detecta qual skill usar baseado na sua solicitacao
2. **Subagentes**: Use `@nome` para delegar tarefas especificas
3. **Modo Plan**: Use Tab para alternar para modo analise (somente leitura)
4. **Paralelo**: `@general` executa multiplas tarefas simultaneamente

## Agentes

### Tech Lead (`@tech-lead`)

Coordena a equipe de agentes, define arquitetura e revisa decisoes tecnicas.

**Use quando:**
- Precisar de decisoes arquiteturais
- Quiser coordenar multiplos agentes
- Precisar de uma visao geral do projeto

### Code Reviewer (`@code-reviewer`)

Revisao de codigo focada em qualidade, seguranca e performance. **Somente leitura**.

**Use quando:**
- Quiser revisar um PR
- Buscar vulnerabilidades no codigo
- Verificar conformidade com padroes

### Security Specialist (`@security-specialist`)

Auditoria de seguranca, OWASP Top 10, hardening. **Somente leitura**.

**Use quando:**
- Precisar de auditoria de seguranca
- Quiser verificar vulnerabilidades OWASP
- Precisar de recomendacoes de hardening

### DevOps Engineer (`@devops-engineer`)

CI/CD, Docker, Kubernetes, infraestrutura e automacao.

**Use quando:**
- Precisar de pipelines CI/CD
- Quiser configurar Docker/Kubernetes
- Precisar de automacao de infraestrutura

### Data Engineer (`@data-engineer`)

Modelagem de dados, ETL, queries otimizadas e pipelines.

**Use quando:**
- Precisar de modelagem de banco de dados
- Quiser otimizar queries SQL
- Precisar de pipelines de dados

### Backend Developer (`@backend-developer`)

APIs REST/GraphQL, autenticacao, microsservicos, Clean Architecture.

**Use quando:**
- Precisar criar APIs
- Quiser implementar autenticacao
- Precisar de arquitetura de microsservicos

### Frontend Developer (`@frontend-developer`)

React, Angular, Flutter, UI/UX e performance.

**Use quando:**
- Precisar de componentes React/Angular
- Quiser criar interfaces Flutter
- Precisar de otimizacao de performance frontend

### QA Engineer (`@qa-engineer`)

Testes automatizados, TDD/BDD e garantia de qualidade.

**Use quando:**
- Precisar de testes unitarios
- Quiser implementar TDD/BDD
- Precisar de testes E2E

### UI/UX Designer (`@ui-ux-designer`)

Design de interfaces, frameworks CSS, animacoes, 3D/particles.

**Use quando:**
- Precisar de design systems
- Quiser animacoes (GSAP, Framer Motion)
- Precisar de efeitos 3D (Three.js)

### Arduino Engineer (`@arduino-engineer`)

Dispositivos embarcados, IoT, hardware, sensores e displays.

**Use quando:**
- Precisar de codigo Arduino/ESP32
- Quiser projetos IoT
- Precisar de integracao com sensores

## Skills

Skills sao instrucoes especializadas carregadas automaticamente. Nao e necessario carrega-las manualmente.

### Como Skills Funcionam

1. Voce faz uma solicitacao em linguagem natural
2. O agente identifica a skill relevante
3. A skill e carregada automaticamente
4. O agente segue as instrucoes especializadas da skill

### Exemplo

```
Voce: "Crie uma API REST com FastAPI e SQLAlchemy"
Agente: [carrega python-backend automaticamente] → segue padroes Clean Architecture
```

## Configuracao

### opencode.json

Configuracao principal do OpenCode. Instalado em `~/.config/opencode/opencode.json`.

**Permissoes configuradas:**
- Comandos seguros: auto-aprovados (git status, ls, npm, etc.)
- Comandos de escrita: perguntar antes (git commit, git push)
- Comandos perigosos: bloqueados (rm, sudo, chmod 777)

### AGENTS.md

Regras globais aplicadas a todos os agentes. Inclui:
- Padroes de codigo (SOLID, DRY, YAGNI)
- Convencoes de commit (feat:, fix:, docs:, etc.)
- Regras de seguranca
- Padroes de arquitetura

### Personalizacao

Para personalizar, edite os arquivos em `~/.config/opencode/`:

```bash
# Editar configuracao global
nano ~/.config/opencode/opencode.json

# Editar regras dos agentes
nano ~/.config/opencode/AGENTS.md

# Editar skill especifica
nano ~/.config/opencode/skills/python-backend/SKILL.md
```

## Desinstalacao

### Linux / macOS

```bash
./uninstall.sh
```

### Windows

```powershell
.\uninstall.ps1
```

Ou clique duplo em `uninstall.bat`.

### Modo Hard

Remove tudo, incluindo o binario do OpenCode:

```bash
./uninstall.sh --hard
```

### O que e removido

| Diretorio | Conteudo |
|-----------|----------|
| `~/.config/opencode/` | Config, skills, agentes |
| `~/.opencode/` | Binario, plugins |
| `~/.local/share/opencode/` | Auth, providers, banco de dados |
| `~/.cache/opencode/` | Cache, modelos |

## Estrutura do Projeto

```
opencode-agent-skills/
├── opencode.json          # Configuracao global
├── AGENTS.md              # Regras globais
├── LICENSE                # MIT License
├── README.md              # Este arquivo
├── .gitignore             # Arquivos ignorados pelo git
│
├── install.sh             # Instalador Linux/macOS
├── install.ps1            # Instalador Windows
├── install.bat            # Wrapper Windows (clique duplo)
│
├── setup.sh               # Logica de instalacao Linux/macOS
├── setup.ps1              # Logica de instalacao Windows
│
├── uninstall.sh           # Desinstalador Linux/macOS
├── uninstall.ps1          # Desinstalador Windows
├── uninstall.bat          # Wrapper Windows (clique duplo)
│
└── .opencode/
    ├── skills/            # 20 skills especializadas
    │   ├── python-backend/
    │   │   └── SKILL.md
    │   ├── javascript-typescript/
    │   │   └── SKILL.md
    │   └── ... (20 total)
    │
    └── agents/            # 10 agentes especializados
        ├── tech-lead.md
        ├── backend-developer.md
        └── ... (10 total)
```

## Contribuicao

Contribuicoes sao bem-vindas! Para contribuir:

1. Fork o projeto
2. Crie uma branch (`git checkout -b feat/nova-skill`)
3. Faca suas alteracoes
4. Commit (`git commit -m 'feat: adiciona nova skill'`)
5. Push (`git push origin feat/nova-skill`)
6. Abra um Pull Request

### Adicionando uma Nova Skill

1. Crie o diretorio: `.opencode/skills/nome-da-skill/`
2. Crie o arquivo `SKILL.md` com as instrucoes
3. Siga o padrao das skills existentes
4. Teste localmente antes de enviar

### Adicionando um Novo Agente

1. Crie o arquivo: `.opencode/agents/nome-do-agente.md`
2. Defina o agente no `opencode.json`
3. Siga o padrao dos agentes existentes

### Padrao de Commit

```
feat: adiciona nova funcionalidade
fix: corrige bug
docs: atualiza documentacao
refactor: refatora codigo
test: adiciona testes
chore: tarefas de manutencao
```

## Licenca

Este projeto esta licenciado sob a licenca MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## Links

- [OpenCode](https://opencode.ai) - Site oficial
- [OpenCode Docs](https://opencode.ai/docs) - Documentacao
- [OpenCode GitHub](https://github.com/anomalyco/opencode) - Repositorio oficial

## Autor

**Edwin Bustillos** - [GitHub](https://github.com/edwinbustillos)

---

Feito com ♥ para a comunidade OpenCode
