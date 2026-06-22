#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-JimmFly/slack-first-company-os}"
REF="${REF:-main}"
SKILL_NAME="${SKILL_NAME:-slack-first-company-os}"
DEST_ROOT="${CODEX_HOME:-$HOME/.codex}/skills"
DEST="${DEST_ROOT}/${SKILL_NAME}"

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

if [ -e "$DEST" ]; then
  if [ "${OVERWRITE:-0}" != "1" ]; then
    echo "Skill already exists: $DEST"
    echo "Run with OVERWRITE=1 to replace it."
    exit 1
  fi
  rm -rf "$DEST"
fi

mkdir -p "$DEST_ROOT"

archive_url="https://codeload.github.com/${REPO}/tar.gz/${REF}"
curl -fsSL "$archive_url" | tar -xz -C "$tmp_dir"

skill_src="$(find "$tmp_dir" -maxdepth 3 -type d -name "$SKILL_NAME" | head -n 1)"
if [ -z "$skill_src" ] || [ ! -f "$skill_src/SKILL.md" ]; then
  echo "Could not find ${SKILL_NAME}/SKILL.md in ${REPO}@${REF}."
  exit 1
fi

cp -R "$skill_src" "$DEST"

echo "Installed ${SKILL_NAME} to ${DEST}"
echo "Restart Codex to pick up the new skill."
