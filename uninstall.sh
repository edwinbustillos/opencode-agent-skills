#!/usr/bin/env bash
# ============================================================================
# OpenCode Agent Team - Desinstalador (Linux/macOS)
# ============================================================================
# Delegates to setup.sh for the actual logic.
# Uso: ./uninstall.sh          (remove config/skills/agentes)
#      ./uninstall.sh --hard   (remove TUDO)
# ============================================================================
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "${DIR}/setup.sh" uninstall "$@"
