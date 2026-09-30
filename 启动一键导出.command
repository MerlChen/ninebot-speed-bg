#!/bin/zsh
set -e

cd "$(dirname "$0")"
port=8765
url="http://127.0.0.1:${port}/bg.html"

if lsof -nP -iTCP:${port} -sTCP:LISTEN >/dev/null 2>&1; then
  open "$url"
  exit 0
fi

python3 -m http.server "$port" --bind 127.0.0.1 >/tmp/ninebot-speed-export-server.log 2>&1 &
server_pid=$!
sleep 1
open "$url"
echo "一键导出页面已打开。保持此终端窗口开启；关闭窗口会停止本地服务。"
wait "$server_pid"
