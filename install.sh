#!/usr/bin/env bash
# ============================================================================
# OpenCode Agent Team - Instalador (Linux/macOS)
# ============================================================================
# Delegates to setup.sh for the actual logic.
# ============================================================================
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "${DIR}/setup.sh" install
