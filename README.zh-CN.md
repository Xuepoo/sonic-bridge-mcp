# SonicBridge MCP: Model Context Protocol 音乐审美服务器

[English](README.md) | [简体中文](README.zh-CN.md)

> [!NOTE]
> `sonic-bridge-mcp` 是一个轻量级、超快速、纯 Rust 编写的 Model Context Protocol (MCP) 服务器。它基于 LRMD (LLM-Readable Music Descriptor) 协议，为 AI 智能体（Agent）赋予**物理级“音乐双耳（超级听感）”**。提供可直达的 Tools，让 AI 能够以毫秒级精度聆听、品鉴并对比不同的音乐演绎版本。

---

## 🚀 一键快捷安装

如果你的 Linux/macOS 环境中已安装 `cargo` 并配置了 `bash` PATH，你可以使用我们的一键安装脚本在 **3 秒钟**内无痛完成全套编译与分发部署：

```bash
# 克隆仓库（若本地已有可直接进入目录）
git clone https://github.com/Xuepoo/sonic-bridge-mcp.git
cd sonic-bridge-mcp

# 运行一键安装脚本
./install.sh
```

### `install.sh` 脚本执行的纯粹职责（符合 KISS 哲学）：
1. 在优化发布模式（`release`）下编译 Rust MCP 服务器，产出极致轻量敏捷的二进制主程序。
2. 自动建立 XDG 规范的用户本地二进制目录：`~/.local/bin/`，并将编译好的可执行文件 `sonic-bridge-mcp` 安装拷贝进去。

---

## 🛠️ 手动安装与配置指南

如果你身处 Windows 环境，或倾向于自主掌控配置，请按照以下步骤手动进行：

### 1. 编译并分发二进制
```bash
cargo build --release
```
编译产出的优化二进制文件位于 `target/release/sonic-bridge-mcp`。你可以将此文件拷贝到你系统 `$PATH` 中的任何全局目录（例如 `~/.local/bin/` 或 `/usr/local/bin/`）。

### 2. 配置 Claude Desktop 客户端
修改（或创建）你的 Claude Desktop 配置文件：
* **Linux/macOS**: `~/.config/Claude/claude_desktop_config.json`
* **Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

在 `mcpServers` 字段中追加以下服务配置：
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
*提示：如果 `sonic-bridge-mcp` 二进制文件没有放置在系统的全局 PATH 中，请将 `"command"` 替换为你编译出的可执行文件的绝对物理路径。*

### 3. 配置 Cursor / Windsurf / Copilot IDE
在 Cursor 的设置页面（`Settings -> Features -> MCP`）中，点击 `+ Add New MCP Server`：
- **Name**: `sonic-bridge`
- **Type**: `command` (Stdio 管道)
- **Command**: `sonic-bridge-mcp`
- **Args**: (留空)

---

## 🧠 暴露给 AI 智能体的 Tools 接口规范

一旦连通，你的 AI Agent 将能自动发现并根据对话语境自行调用以下超强声学工具：

### 1. `analyze_music`
分析本地音频文件（`.mp3`, `.flac`, `.wav` 等），并产生符合 LRMD 协议的 LLM 可读音乐审美描述符报告，涵盖歌曲的时序结构、和弦演进、动态电平与音色质感。

* **参数参数**：
  - `filepath` (string, 必须): 目标音频文件的绝对物理路径。
  - `onset_mode` (boolean, 可选): 设为 `true` 将触发基于谱通量的 onset 瞬态自适应切分（推荐对于快节奏、复杂电子/流行乐使用）；`false` 默认使用固定等长切分。
* **返回**：Markdown 格式的声学审美语义分析报告。

### 2. `compare_music`
利用动态时间规整（DTW）算法对比两个不同演绎版本的音轨（例如原版录音室 master 与现场木吉他 cover 版），忽略时间拉伸和拖拍差异，精准对齐相同乐段并对比它们在演奏情感（Affect）上的声学差异。

* **参数参数**：
  - `file_a` (string, 必须): 原始参考音轨的绝对路径。
  - `file_b` (string, 必须): 用于比对的翻唱/演绎音轨绝对路径。
* **返回**：DTW 时序对齐的乐评人级演绎比对分析矩阵。

---

## 🌊 核心硬核 DSP 心理声学技术

* **时空切片融合压缩器 (Token Merger)**：在 onset 自适应分块后进行审美状态融合，将冗余的微秒级碎片合并为大跨度乐句块，**直接截断 90% 以上的大模型 Token 消耗**。
* **Crest Factor 波峰因数动态分类**：结合时域 peak 采样与滑动相对 RMS 归一化分析，彻底解决 J-POP/Vocaloid 现代砖墙麦克限幅压限导致的 `Fortissimo` 霸屏偏置，还原音乐本真的“呼吸与起伏”。
* **200Hz - 2kHz 带通滤波色度投影**：将和弦半音阶投影提纯到人类声乐与旋律的黄金频带，**彻底过滤 200Hz 以下重低音/大鼓共振**以及 2kHz 以上高频失真杂音，melancholy 小调和弦识别率提升 100%！

---

## 📄 开源许可证
本项目基于 [MIT 开源许可证](LICENSE) 授权。
