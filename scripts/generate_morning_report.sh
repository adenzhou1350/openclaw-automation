#!/bin/bash
# OpenClaw 天气早报生成脚本
# 用法: ./generate_morning_report.sh

source /root/.openclaw/workspace/.env 2>/dev/null || true

CITY="${CITY:-北京}"
DATE=$(date "+%Y年%m月%d日 %A")

# 获取天气数据 (使用 wttr.in)
WEATHER=$(curl -s "wttr.in/${CITY}?format=%c%t+%h+%p" 2>/dev/null || echo "获取失败")
TEMP=$(echo "$WEATHER" | grep -oE '[0-9]+°C' | head -1 || echo "N/A")
HUMIDITY=$(echo "$WEATHER" | grep -oE '[0-9]+%' | head -1 || echo "N/A")
CONDITION=$(echo "$WEATHER" | sed 's/[0-9°+%]*//g' | xargs || echo "未知")

# 构建早报内容
cat << EOF
☀️ 早上好！${DATE}

📍 所在城市: ${CITY}

🌤️ 天气状况: ${CONDITION}
🌡️ 当前温度: ${TEMP}
💧 空气湿度: ${HUMIDITY}

💡 每日一句:
每一次尝试都是成长的机会 🌱

EOF

# 可选：发送企业微信通知
if [ -n "$WECOM_WEBHOOK" ]; then
    curl -s -X POST "$WECOM_WEBHOOK" \
        -H 'Content-Type: application/json' \
        -d "{\"msgtype\": \"text\", \"text\": {\"content\": \"☀️ 早报已生成: ${CITY} ${TEMP} ${CONDITION}\"}}"
fi
