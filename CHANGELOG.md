# Changelog - sonic-bridge-mcp

All notable changes to the `sonic-bridge-mcp` server will be documented in this file.

---

## [0.1.2] - 2026-05-31

### Added
- **ALRC Format Validation Gate (Issue #17)**: Introduced regex-free, high-performance structured syntax verification (`validate_alrc`) inside the `save_alrc` tool to prevent corrupted or syntactically invalid lyric formatting from corrupting the workspace database.

### Changed
- Synchronized with `sonic-bridge` core library release `v0.3.6`.
- Bumped JSON-RPC server version declaration to `v0.1.2` in `initialize` capabilities handshake.

---

## [0.1.1] - 2026-05-30

### Added
- **Aesthetic Lyric Persistence (`save_alrc` tool)**: Added a new JSON-RPC tool exposing physical `.alrc` file saving to the AI agent. The agent can now securely save LLM-synthesized synesthetic lyrical critiques co-located next to target audio tracks.
- **Robust Local Re-install Mechanism**: Upgraded `install.sh` by adding active process unlinking (`rm -f`) before copying the release binary. This prevents typical `Text file busy` deployment failures when client IDEs or desktop wrappers are running the MCP background daemon.

### Changed
- Synchronized with `sonic-bridge` core library release `v0.3.5`.
- Updated server info metadata to return `v0.1.1` on JSON-RPC `initialize`.

---

## [0.1.0] - 2026-05-29

### Added
- First industrial release of `sonic-bridge-mcp` server.
- Supported `analyze_music` and `compare_music` RPC commands.
