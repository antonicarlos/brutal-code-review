# Global Review Knowledge (Cross-Project Learnings)

## Engineering Anti-Patterns & Production Pitfalls
- **Filesystem Drift & Inconsistent Paths:** Directories referenced across documentation, skills, test suites, and `.gitignore` must maintain strict 1:1 naming consistency (e.g., `logs/` vs `review/`).
- **Windows Symlink Fragility:** Repositories relying on symlinks for multi-agent aliases (`.cursorrules`, `CLAUDE.md`) must provide direct file copy commands for Windows environments without Developer Mode enabled.
- **Submodule Misdirection:** Never document a directory as a Git submodule unless `.gitmodules` is formally configured and committed in the repository root.
- **NTFS Zone Identifiers in POSIX:** Always filter out Windows/WSL ADS artifacts (`*:Zone.Identifier`) via `.gitignore` and pre-commit cleanup scripts to avoid breaking tarballs, linters, and CI runners.
