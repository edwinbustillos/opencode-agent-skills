#!/usr/bin/env bash
# ============================================================================
# OpenCode Agent Team - Setup Cross-Platform (Linux/macOS)
# ============================================================================
# Uso: ./setup.sh install
#      ./setup.sh uninstall
#      ./setup.sh uninstall --hard   # Remove TUDO, inclusive ~/.opencode/
# ============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

OPENCODE_CONFIG="${HOME}/.config/opencode"
OPENCODE_DATA="${HOME}/.opencode"
OPENCODE_SHARE="${HOME}/.local/share/opencode"
OPENCODE_CACHE="${HOME}/.cache/opencode"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info()  { echo -e "${BLUE}▸${NC} $1"; }
ok()    { echo -e "${GREEN}  ✓${NC} $1"; }
warn()  { echo -e "${YELLOW}  ⚠${NC} $1"; }
err()   { echo -e "${RED}  ✗${NC} $1"; }
has()   { command -v "$1" &>/dev/null; }

# ============================================================================
# FUNÇÃO: Instalar
# ============================================================================
do_install() {
    local skill_dir="${OPENCODE_CONFIG}/skills"
    local agent_dir="${OPENCODE_CONFIG}/agents"

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║   OpenCode Agent Team - Instalador              ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""

    if ! has opencode; then
        info "opencode não encontrado — instalando via curl..."
        if has curl; then
            curl -fsSL https://opencode.ai/install | bash
            echo ""
            if ! has opencode; then
                err "Instalação falhou. Tente manualmente: https://opencode.ai/docs/installation"
                exit 1
            fi
            ok "opencode instalado com sucesso"
        else
            err "curl não disponível. Instale o opencode manualmente: https://opencode.ai/docs/installation"
            exit 1
        fi
    fi
    ok "opencode $(opencode --version 2>/dev/null || echo 'detectado')"

    info "Criando diretórios..."
    for d in "$OPENCODE_CONFIG" "$skill_dir" "$agent_dir"; do
        mkdir -p "$d"
        ok "$d"
    done

    copy_if_new() {
        local src="$1" dst="$2"
        if [ ! -f "$dst" ] || ! diff -q "$src" "$dst" &>/dev/null; then
            cp "$src" "$dst"
            return 0
        fi
        return 1
    }

    info "Instalando configuração..."
    copy_if_new "${SOURCE_DIR}/opencode.json" "${OPENCODE_CONFIG}/opencode.json" && \
        ok "opencode.json" || ok "opencode.json (sem alterações)"
    copy_if_new "${SOURCE_DIR}/AGENTS.md" "${OPENCODE_CONFIG}/AGENTS.md" && \
        ok "AGENTS.md" || ok "AGENTS.md (sem alterações)"

    info "Instalando skills..."
    local installed=0 skipped=0
    for skill in "${SOURCE_DIR}/.opencode/skills/"*/; do
        [ -d "$skill" ] || continue
        name=$(basename "$skill")
        src="${skill}/SKILL.md"
        dst_dir="${skill_dir}/${name}"
        dst="${dst_dir}/SKILL.md"

        if [ ! -f "$src" ]; then
            warn "Fonte não encontrada: ${name}"
            ((skipped++))
            continue
        fi
        mkdir -p "$dst_dir"
        if copy_if_new "$src" "$dst"; then
            ok "${name}"
            ((installed++))
        else
            ok "${name} (sem alterações)"
            ((skipped++))
        fi
    done
    echo -e "  ${CYAN}Skills: ${installed} novas, ${skipped} mantidas${NC}"

    info "Instalando agentes..."
    installed=0; skipped=0
    if [ -d "${SOURCE_DIR}/.opencode/agents" ]; then
        for agent_file in "${SOURCE_DIR}/.opencode/agents/"*.md; do
            [ -f "$agent_file" ] || continue
            name=$(basename "$agent_file")
            dst="${agent_dir}/${name}"
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

    info "Verificando ferramentas opcionais..."
    has pyright       && ok "pyright (Python LSP)"    || true
    has gopls         && ok "gopls (Go LSP)"          || true
    has rust-analyzer && ok "rust-analyzer (Rust)"    || true
    has clangd        && ok "clangd (C/C++ LSP)"      || true
    has arduino-cli   && ok "arduino-cli"             || true
    has pio           && ok "PlatformIO"              || true

    local total_skills=0 total_agents=0
    [ -d "$skill_dir" ] && total_skills=$(ls -1 "$skill_dir" 2>/dev/null | wc -l | tr -d ' ')
    [ -d "$agent_dir" ] && total_agents=$(ls -1 "$agent_dir"/*.md 2>/dev/null | wc -l | tr -d ' ')

    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Instalação Concluída                         ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  Config:   ${OPENCODE_CONFIG}/opencode.json"
    echo -e "  Skills:   ${total_skills} em ${skill_dir}/"
    echo -e "  Agentes:  ${total_agents} em ${agent_dir}/"
    echo -e "  Regras:   ${OPENCODE_CONFIG}/AGENTS.md"
    echo ""
    echo -e "  ${YELLOW}Inicie com: opencode${NC}"
    echo ""
}

# ============================================================================
# FUNÇÃO: Desinstalar
# ============================================================================
do_uninstall() {
    local hard_mode=false
    [[ "${1:-}" == "--hard" ]] && hard_mode=true

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║   OpenCode Agent Team - Desinstalador           ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""

    if $hard_mode; then
        warn "MODO HARD: removendo TUDO (config + dados + providers + binário)"
        echo ""
    else
        warn "Removendo config, skills, agentes e providers. Use --hard para remover também o binário."
        echo ""
    fi

    read -p "Remover config skills agentes do opencode? (y/N): " confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { echo -e "${YELLOW}Cancelado.${NC}"; exit 0; }
    echo ""

    # --- Remove ~/.config/opencode/ ---
    if [ -d "$OPENCODE_CONFIG" ]; then
        info "Removendo ${OPENCODE_CONFIG}..."
        rm -rf "$OPENCODE_CONFIG"
        ok "Configuração removida"
    else
        info "${OPENCODE_CONFIG} não encontrado, ignorando"
    fi

    # --- Remove ~/.opencode/ (binário, plugins, node_modules) ---
    if [ -d "$OPENCODE_DATA" ]; then
        info "Removendo ${OPENCODE_DATA}..."
        rm -rf "$OPENCODE_DATA"
        ok "Binário e plugins removidos"
    else
        info "${OPENCODE_DATA} não encontrado, ignorando"
    fi

    # --- Remove ~/.local/share/opencode/ (auth, providers, banco de dados) ---
    if [ -d "$OPENCODE_SHARE" ]; then
        info "Removendo ${OPENCODE_SHARE}..."
        rm -rf "$OPENCODE_SHARE"
        ok "Credenciais, providers e banco de dados removidos"
    else
        info "${OPENCODE_SHARE} não encontrado, ignorando"
    fi

    # --- Remove ~/.cache/opencode/ (cache, modelos, binários auxiliares) ---
    if [ -d "$OPENCODE_CACHE" ]; then
        info "Removendo ${OPENCODE_CACHE}..."
        rm -rf "$OPENCODE_CACHE"
        ok "Cache removido"
    else
        info "${OPENCODE_CACHE} não encontrado, ignorando"
    fi

    # --- Remove binário do PATH (apenas em --hard) ---
    if $hard_mode; then
        for loc in "/usr/local/bin/opencode" "${HOME}/.local/bin/opencode"; do
            if [ -f "$loc" ]; then
                rm -f "$loc"
                ok "Binário removido: $loc"
            fi
        done
    fi

    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   Desinstalação Concluída                      ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "  ${YELLOW}Resumo:${NC}"
    echo -e "  - ~/.config/opencode/       : removido"
    echo -e "  - ~/.opencode/              : removido (binário, plugins)"
    echo -e "  - ~/.local/share/opencode/  : removido (auth, providers, banco de dados)"
    echo -e "  - ~/.cache/opencode/        : removido (cache, modelos)"
    if $hard_mode; then
        echo -e "  - binário PATH         : removido"
    else
        echo -e "  - binário PATH         : mantido"
    fi
    echo ""
    echo -e "  ${CYAN}Para reinstalar complete:${NC}"
    echo -e "  ${YELLOW}  ${SOURCE_DIR}/install.sh${NC}"
    echo ""
}

# ============================================================================
# MAIN
# ============================================================================
case "${1:-}" in
    install)
        do_install
        ;;
    uninstall)
        do_uninstall "${2:-}"
        ;;
    *)
        echo ""
        echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║   OpenCode Agent Team - Setup                  ║${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "  Uso: ./setup.sh ${GREEN}install${NC}           Instalar skills/agentes/config"
        echo -e "       ./setup.sh ${RED}uninstall${NC}         Remover config/skills/agentes/providers"
        echo -e "       ./setup.sh ${RED}uninstall --hard${NC}  Remover TUDO (+ binário do PATH)"
        echo ""
        echo -e "  ${YELLOW}Legenda:${NC}"
    echo -e "  - install      : Instala opencode (se ausente), copia skills/agentes/config"
    echo -e "  - uninstall    : Remove ~/.config/opencode/ + ~/.opencode/ + ~/.local/share/opencode/ + ~/.cache/opencode/"
        echo -e "  - uninstall --hard : Idem + remove binário do PATH"
        echo ""
        ;;
esac
