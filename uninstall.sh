#!/usr/bin/env bash
# ============================================================================
# OpenCode Agent Team - Desinstalador (Linux/macOS)
# ============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; NC='\033[0m'

OPENCODE_DIR="${HOME}/.config/opencode"

echo -e "${CYAN}╔══════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   OpenCode Agent Team - Desinstalador            ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════╝${NC}"
echo ""

read -p "Remover skills, agentes e config do opencode? (y/N): " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo -e "${YELLOW}Cancelado.${NC}"; exit 0; }

echo ""

# Skills
if [ -d "${OPENCODE_DIR}/skills" ]; then
    count=$(ls -1 "${OPENCODE_DIR}/skills" 2>/dev/null | wc -l | tr -d ' ')
    rm -rf "${OPENCODE_DIR}/skills"
    echo -e "  ${GREEN}✓${NC} ${count} skills removidas"
fi

# Agents (apenas .md files)
if [ -d "${OPENCODE_DIR}/agents" ]; then
    count=$(ls -1 "${OPENCODE_DIR}/agents"/*.md 2>/dev/null | wc -l | tr -d ' ')
    rm -f "${OPENCODE_DIR}/agents"/*.md
    echo -e "  ${GREEN}✓${NC} ${count} agentes removidos"
fi

# Config
for f in opencode.json AGENTS.md; do
    if [ -f "${OPENCODE_DIR}/${f}" ]; then
        rm -f "${OPENCODE_DIR}/${f}"
        echo -e "  ${GREEN}✓${NC} ${f} removido"
    fi
done

echo -e "\n${GREEN}Desinstalação concluída.${NC}\n"
