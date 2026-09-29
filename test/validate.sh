#!/usr/bin/env bash
# ==============================================================================
# brutal-code-review Integrity & Smoke Test Suite
# Validates symlinks, rule books indexing, and repository sanity.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

FAILED=0
CHECK_COUNT=0

log_success() {
  echo -e "\033[32m[PASS]\033[0m $1"
}

log_fail() {
  echo -e "\033[31m[FAIL]\033[0m $1"
  FAILED=1
}

run_check() {
  local desc="$1"
  shift
  CHECK_COUNT=$((CHECK_COUNT + 1))
  if "$@"; then
    log_success "${desc}"
  else
    log_fail "${desc}"
  fi
}

echo "=== Running brutal-code-review sanity checks ==="

# 1. Symlink Validations
check_symlink() {
  local file="$1"
  if [[ -L "${file}" && -e "${file}" ]]; then
    return 0
  fi
  return 1
}

run_check "Symlink .cursorrules resolves correctly" check_symlink ".cursorrules"
run_check "Symlink CLAUDE.md resolves correctly" check_symlink "CLAUDE.md"
run_check "Symlink .github/copilot-instructions.md resolves correctly" check_symlink ".github/copilot-instructions.md"

# 2. Base files existence
run_check "SKILL.md exists" test -f "SKILL.md"
run_check "KNOWLEDGE.md exists" test -f "KNOWLEDGE.md"
run_check "README.md exists" test -f "README.md"
run_check ".gitignore exists" test -f ".gitignore"

# 3. Check for unwanted NTFS Zone.Identifier artifacts
check_no_zone_identifiers() {
  local count
  count="$(find . -name "*:Zone.Identifier" | wc -l)"
  if [[ "${count}" -eq 0 ]]; then
    return 0
  fi
  echo "Found ${count} *:Zone.Identifier files."
  return 1
}
run_check "No NTFS Zone.Identifier artifact files exist" check_no_zone_identifiers

# 4. Extract and validate book directories from SKILL.md index
check_books_integrity() {
  local missing=0
  local book_dirs
  # Extract book paths defined in SKILL.md under RULES BOOKS INDEX
  book_dirs=$(grep -oE '\./agent-rules-books/[a-zA-Z0-9_-]+/?' SKILL.md | sed 's|^\./||' | sed 's|/$||' | sort -u)

  local book_count=0
  for bdir in ${book_dirs}; do
    book_count=$((book_count + 1))
    if [[ ! -d "${bdir}" ]]; then
      echo "Missing book directory: ${bdir}"
      missing=$((missing + 1))
    elif [[ ! -f "${bdir}/SKILL.md" ]]; then
      echo "Missing SKILL.md in: ${bdir}"
      missing=$((missing + 1))
    fi
  done

  if [[ "${book_count}" -lt 14 ]]; then
    echo "Expected at least 14 books in index, found ${book_count}."
    return 1
  fi

  return "${missing}"
}
run_check "All 14 rule books in SKILL.md exist physically with SKILL.md" check_books_integrity

# 5. Check .gitignore rules
check_gitignore_rules() {
  grep -q "\.code-review/logs/" .gitignore && \
  grep -q "Zone\.Identifier" .gitignore
}
run_check ".gitignore contains .code-review/logs/ and Zone.Identifier" check_gitignore_rules

echo "================================================="
if [[ "${FAILED}" -eq 0 ]]; then
  echo -e "\033[32mAll ${CHECK_COUNT} validation checks passed successfully!\033[0m"
  exit 0
else
  echo -e "\033[31mValidation failed!\033[0m"
  exit 1
fi
