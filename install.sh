#!/bin/sh
# 把 ccm 安装到 ~/.local/bin（或 $CCM_INSTALL_DIR）
set -e

INSTALL_DIR="${CCM_INSTALL_DIR:-$HOME/.local/bin}"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v python3 >/dev/null 2>&1; then
    echo "需要 python3（3.8+），请先安装。" >&2
    exit 1
fi
if ! python3 -c 'import curses' 2>/dev/null; then
    echo "当前 python3 缺少 curses 模块（原生 Windows 不支持，请在 WSL 中使用）。" >&2
    exit 1
fi
command -v claude >/dev/null 2>&1 || echo "提示: 没有找到 claude 命令，打开会话时会失败。"

mkdir -p "$INSTALL_DIR"
cp "$SRC_DIR/ccm" "$INSTALL_DIR/ccm"
chmod +x "$INSTALL_DIR/ccm"
echo "已安装到 $INSTALL_DIR/ccm"

case ":$PATH:" in
    *":$INSTALL_DIR:"*) ;;
    *) echo "注意: $INSTALL_DIR 不在 PATH 中，请在 shell 配置文件里加上:"
       echo "    export PATH=\"$INSTALL_DIR:\$PATH\"" ;;
esac
