#!/bin/bash

# ============================================
# 系统资源监控脚本
# 检查存储和内存使用情况
# ============================================

REPORT_FILE="/root/.openclaw/workspace/memory/api_status.md"

echo "============================================"
echo "  系统资源监控 - $(date '+%Y-%m-%d %H:%M')"
echo "============================================"

# 磁盘使用
DISK=$(df -h / | tail -1 | awk '{print $5}')
DISK_USED=$(df -h / | tail -1 | awk '{print $3}')
DISK_TOTAL=$(df -h / | tail -1 | awk '{print $2}')

echo ""
echo "💾 存储使用"
echo "  已用: $DISK_USED / $DISK_TOTAL ($DISK)"

# 内存使用
MEM_TOTAL=$(free -h | grep Mem | awk '{print $2}')
MEM_USED=$(free -h | grep Mem | awk '{print $3}')
MEM_FREE=$(free -h | grep Mem | awk '{print $7}')

echo ""
echo "🧠 内存使用"
echo "  已用: $MEM_USED / $MEM_TOTAL"
echo "  可用: $MEM_FREE"

# 检查是否需要告警
DISK_PCT=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
MEM_PCT=$(free | grep Mem | awk '{print $3/$2 * 100}' | cut -d. -f1)

echo ""
echo "⚠️ 告警检查"

if [ "$DISK_PCT" -gt 80 ]; then
    echo "  ⚠️ 存储使用超过 80%！"
else
    echo "  ✅ 存储正常"
fi

if [ "$MEM_PCT" -gt 80 ]; then
    echo "  ⚠️ 内存使用超过 80%！"
else
    echo "  ✅ 内存正常"
fi

echo ""
echo "============================================"
