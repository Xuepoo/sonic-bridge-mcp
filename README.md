# SonicBridge MCP: Model Context Protocol Music Aesthetic Server

> [!NOTE]
> `sonic-bridge-mcp` is a lightweight, ultra-fast, pure-Rust Model Context Protocol (MCP) server that empowers AI companion agents with **"physical listening double-ears (超级听感)"** under the LRMD protocol. It provides direct tools to analyze and compare musical versions with millisecond-level precision.

---

## 🚀 Quick One-Click Installation

If you are using a standard Linux/macOS environment with `cargo` and `bash` in your PATH, you can configure everything in **3 seconds** using our one-click installer:

```bash
# Clone the repository (if not already local)
git clone https://github.com/Xuepoo/sonic-bridge-mcp.git
cd sonic-bridge-mcp

# Run the automated installer
./install.sh
```

### What `install.sh` does:
1. Compiles the Rust MCP server in optimized `release` mode.
2. Installs the executable binary directly into your XDG-compliant user binary directory: `~/.local/bin/sonic-bridge-mcp`.
3. Creates and automatically configures your **Claude Desktop** config file (`~/.config/Claude/claude_desktop_config.json`) with zero absolute-path dependencies.

---

## 🛠️ Manual Installation & Configurations

If you prefer to configure manually or are on a different environment, follow the steps below:

### 1. Build the Binary
```bash
cargo build --release
```
The optimized executable will be generated at `target/release/sonic-bridge-mcp`. 
You can copy this executable to any directory in your system `$PATH` (e.g., `~/.local/bin/` or `/usr/local/bin/`).

### 2. Configure Claude Desktop
Modify (or create) your Claude Desktop configuration file:
* **Linux/macOS**: `~/.config/Claude/claude_desktop_config.json`
* **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

Append the following server config:
```json
{
  "mcpServers": {
    "sonic-bridge": {
      "command": "sonic-bridge-mcp",
      "args": []
    }
  }
}
```
*Note: If `sonic-bridge-mcp` is not in your global system PATH, replace `"command"` with the absolute path to your compiled binary.*

### 3. Configure Cursor / Windsurf / Copilot IDE
In your Cursor settings (`Settings -> Features -> MCP`), click `+ Add New MCP Server`:
- **Name**: `sonic-bridge`
- **Type**: `command` (Stdio)
- **Command**: `sonic-bridge-mcp`
- **Args**: (Leave Blank)

---

## 🧠 Provided AI Tools Reference

Once connected, your AI Agent will automatically discover and call the following acoustic tools:

### 1. `analyze_music`
Analyze a local audio track (`.mp3`, `.flac`, `.wav`, etc.) and return an LLM-Readable Music Descriptor (LRMD) report outlining temporal structures, chords, dynamics, and timbres.

* **Arguments**:
  - `filepath` (string, required): The absolute path to the target music file.
  - `onset_mode` (boolean, optional): Set to `true` to use dynamic transient-driven onset segmentation (recommended for complex electronic/pop music). `false` defaults to static intervals.
* **Return**: A Markdown formatted semantic music description.

### 2. `compare_music`
Compare two different versions of the same track (e.g., a studio master vs. an acoustic cover version) using Dynamic Time Warping (DTW) to align temporal indices and contrast performance affects.

* **Arguments**:
  - `file_a` (string, required): The absolute path to the original track.
  - `file_b` (string, required): The absolute path to the comparative cover track.
* **Return**: A detailed comparative warp-matrix table tracking structural difference.

---

## 🌊 Under the Hood: Pure DSP Aesthetics

* **Token-Optimized Chunk Merger**: Automatic adjacent slice fusion that compresses redundant micro-segments into Phrase Blocks, cutting down downstream Agent token consumption by over 90%.
* **Crest Factor Adaptive Classification**: Combines wave peak-to-RMS ratios with sliding relative RMS levels to detect the "breathing" and dynamic fluctuations of modern brickwall-limited masters.
* **200Hz - 2kHz Bandpass Chroma Projection**: Restricts harmonic tracking to the human vocal and melodic mid-range, preventing heavy sub-bass kick drums from muddying minor scale classifications.

---

## 📄 License
This project is licensed under the [MIT License](LICENSE).
