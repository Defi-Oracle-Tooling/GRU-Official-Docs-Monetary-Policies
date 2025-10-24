#!/usr/bin/env bash
set -euo pipefail

# Sign the checksum verification log using GPG, producing an ASCII armored signature.
# Requirements: gpg installed; private key imported into environment.
# Optional env vars:
#   GPG_KEY_ID  : Specific key ID/email to use (if multiple keys).
#   GPG_PASSPHRASE : Passphrase (discouraged to export in plaintext; prefer gpg-agent).
# Usage:
#   ./scripts/sign_checksums.sh
# Output:
#   dist/metadata/GRU_Checksum_Verification_Log.txt.asc (detached signature)
#   dist/metadata/GRU_Checksum_Verification_Log.txt.sig (binary signature)

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_FILE="$ROOT_DIR/dist/metadata/GRU_Checksum_Verification_Log.txt"
ASC_OUT="$ROOT_DIR/dist/metadata/GRU_Checksum_Verification_Log.txt.asc"
BIN_OUT="$ROOT_DIR/dist/metadata/GRU_Checksum_Verification_Log.txt.sig"

if [ ! -f "$LOG_FILE" ]; then
  echo "[ERROR] Checksum log not found: $LOG_FILE" >&2
  exit 1
fi

if ! command -v gpg >/dev/null 2>&1; then
  echo "[ERROR] gpg not installed." >&2
  exit 1
fi

KEY_ARGS=()
if [ -n "${GPG_KEY_ID:-}" ]; then
  KEY_ARGS+=("--local-user" "$GPG_KEY_ID")
fi

# ASCII armored detached signature
if gpg --batch --yes "${KEY_ARGS[@]}" --armor --detach-sign "$LOG_FILE" -o "$ASC_OUT"; then
  echo "[OK] ASCII signature created: $ASC_OUT"
else
  echo "[WARN] ASCII signature failed" >&2
fi

# Binary detached signature
if gpg --batch --yes "${KEY_ARGS[@]}" --detach-sign "$LOG_FILE" -o "$BIN_OUT"; then
  echo "[OK] Binary signature created: $BIN_OUT"
else
  echo "[WARN] Binary signature failed" >&2
fi

# Verification step (if signatures exist)
if gpg --verify "$ASC_OUT" "$LOG_FILE" >/dev/null 2>&1; then
  echo "[VERIFY] ASCII signature valid." 
else
  echo "[VERIFY] ASCII signature verification failed." >&2
fi

if gpg --verify "$BIN_OUT" "$LOG_FILE" >/dev/null 2>&1; then
  echo "[VERIFY] Binary signature valid." 
else
  echo "[VERIFY] Binary signature verification failed." >&2
fi
