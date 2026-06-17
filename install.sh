#!/usr/bin/env bash
# ============================================================================
# OpenCode Agent Team - Instalador Cross-Platform (Linux/macOS)
# ============================================================================
# Instala skills, agentes e configuração global do opencode.
# Requer: opencode já instalado e funcionando.
# ============================================================================
set -euo pipefail

# --- Cores ---
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

# --- Diretórios ---
OPENCODE_DIR="${HOME}/.config/opencode"
SKILLS_DIR="${OPENCODE_DIR}/skills"
AGENTS_DIR="${OPENCODE_DIR}/agents"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Helpers ---
info()  { echo -e "${BLUE}▸${NC} $1"; }
ok()    { echo -e "${GREEN}  ✓${NC} $1"; }
warn()  { echo -e "${YELLOW}  ⚠${NC} $1"; }
err()   { echo -e "${RED}  ✗${NC} $1"; }

has() { command -v "$1" &>/dev/null; }

copy_if_new() {
    local src="$1" dst="$2"
    if [ ! -f "$dst" ] || ! diff -q "$src" "$dst" &>/dev/null; then
        cp "$src" "$dst"
        return 0
    fi
    return 1
}

# ============================================================================
# Verificar opencode
# ============================================================================
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   OpenCode Agent Team - Instalador              ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
echo ""

if ! has opencode; then
    err "opencode não encontrado no PATH"
    echo -e "  Instale: ${YELLOW}https://opencode.ai/docs/installation${NC}"
    exit 1
fi
ok "opencode $(opencode --version 2>/dev/null || echo 'detectado')"

# ============================================================================
# Criar diretórios
# ============================================================================
info "Criando diretórios..."
for d in "$OPENCODE_DIR" "$SKILLS_DIR" "$AGENTS_DIR"; do
    mkdir -p "$d"
    ok "$d"
done

# ============================================================================
# Copiar configuração global
# ============================================================================
info "Instalando configuração..."

copy_if_new "${SOURCE_DIR}/opencode.json" "${OPENCODE_DIR}/opencode.json" && \
    ok "opencode.json" || ok "opencode.json (sem alterações)"

copy_if_new "${SOURCE_DIR}/AGENTS.md" "${OPENCODE_DIR}/AGENTS.md" && \
    ok "AGENTS.md" || ok "AGENTS.md (sem alterações)"

# ============================================================================
# Instalar Skills (20)
# ============================================================================
info "Instalando skills..."

SKILLS=(
    python-backend javascript-typescript flutter-mobile
    java-backend golang-backend rust-systems cpp-systems
    react-frontend angular-frontend api-design
    database-orm cloud-aws cloud-azure
    devops-cicd ui-ux-design security-audit
    testing-strategy performance-optimization project-setup
    arduino-embedded
)

installed=0; skipped=0

for skill in "${SKILLS[@]}"; do
    src="${SOURCE_DIR}/.opencode/skills/${skill}/SKILL.md"
    dst_dir="${SKILLS_DIR}/${skill}"
    dst="${dst_dir}/SKILL.md"

    if [ ! -f "$src" ]; then
        warn "Fonte não encontrada: ${skill}"
        ((skipped++))
        continue
    fi

    mkdir -p "$dst_dir"
    if copy_if_new "$src" "$dst"; then
        ok "${skill}"
        ((installed++))
    else
        ok "${skill} (sem alterações)"
        ((skipped++))
    fi
done

echo -e "  ${CYAN}Skills: ${installed} novas, ${skipped} mantidas${NC}"

# ============================================================================
# Instalar Agentes (6 do projeto)
# ============================================================================
info "Instalando agentes..."

installed=0; skipped=0

if [ -d "${SOURCE_DIR}/.opencode/agents" ]; then
    for agent_file in "${SOURCE_DIR}/.opencode/agents/"*.md; do
        [ -f "$agent_file" ] || continue
        name=$(basename "$agent_file")
        dst="${AGENTS_DIR}/${name}"

        if copy_if_new "$agent_file" "$dst"; then
            ok "${name%.md}"
            ((installed++))
        else
            ok "${name%.md} (sem alterações)"
            ((skipped++))
        fi
    done
fi

echo -e "  ${CYAN}Agentes: ${installed} novos, ${skipped} mantidos${NC}"

# ============================================================================
# Verificar LSP / Arduino
# ============================================================================
info "Verificando ferramentas opcionais..."

has pyright     && ok "pyright (Python LSP)"    || true
has gopls       && ok "gopls (Go LSP)"          || true
has rust-analyzer && ok "rust-analyzer (Rust)"  || true
has clangd      && ok "clangd (C/C++ LSP)"      || true
has arduino-cli && ok "arduino-cli"              || true
has pio         && ok "PlatformIO"               || true

# ============================================================================
# Resumo
# ============================================================================
echo ""
total_skills=$(ls -1 "${SKILLS_DIR}" 2>/dev/null | wc -l | tr -d ' ')
total_agents=$(ls -1 "${AGENTS_DIR}"/*.md 2>/dev/null | wc -l | tr -d ' ')

echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ Instalação Concluída                       ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Config:   ${OPENCODE_DIR}/opencode.json"
echo -e "  Skills:   ${total_skills} instaladas em ${SKILLS_DIR}/"
echo -e "  Agentes:  ${total_agents} instalados em ${AGENTS_DIR}/"
echo -e "  Regras:   ${OPENCODE_DIR}/AGENTS.md"
echo ""
echo -e "  ${YELLOW}Inicie com: opencode${NC}"
echo -e "  ${YELLOW}Use Tab para alternar agentes, @nome para subagentes${NC}"
echo ""
