# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2026-02-19

### Changed
- Updated SKILL.md frontmatter to modern OpenClaw conventions
  - Added `user-invocable` and `disable-model-invocation` fields
  - Added `metadata.openclaw` block with emoji, requires, and homepage
  - Removed deprecated `allowed-tools` field (not in official OpenClaw spec)
- Added dependency check to `scripts/optimize.sh` for `openclaw` CLI
- Improved README.md with version badge and OpenClaw documentation link

### Fixed
- Script now exits gracefully with helpful error if `openclaw` CLI is not installed

## [1.0.0] - 2026-02-19

### Added
- Initial release of Clawtimizer
- Core optimization script (`scripts/optimize.sh`)
- OpenClaw skill definition (`SKILL.md`)
- Workspace documentation reference (`references/workspace-docs.md`)
- Support for multiple free LLM models with automatic fallback
- Automatic backup system with date-stamped directories
- Word count reduction statistics and monthly savings calculation
- User confirmation before applying changes

### Features
- Optimizes `AGENTS.md`, `SOUL.md`, `TOOLS.md`, `USER.md` workspace files
- Target compression: <40% of original word count
- Preserves all operational instructions and OpenClaw conventions
- Configurable via `OPTIMIZER_MODEL` environment variable

---

[Unreleased]: https://github.com/plater7/clawtimizer/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/plater7/clawtimizer/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/plater7/clawtimizer/releases/tag/v1.0.0
