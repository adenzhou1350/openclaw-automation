#!/bin/bash

# ============================================
# 每3小时复盘脚本 v5
# 记录前三小时做了什么，和之前对比
# ============================================

REPORT_DIR="/root/.openclaw/workspace/memory/checkpoints"
TIMESTAMP=$(date +%Y%m%d%H)
REPORT_FILE="$REPORT_DIR/hourly_$TIMESTAMP.md"

NOW=$(date "+%Y-%m-%d %H:%M")
CURRENT_HOUR=$(date +%Y%m%d%H)
THREE_HOURS_AGO=$(date -d "3 hours ago" +%Y%m%d%H)
SIX_HOURS_AGO=$(date -d "6 hours ago" +%Y%m%d%H)

echo "# ⏰ 每3小时复盘 - $NOW" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ===== 1. 当前状态 =====
echo "## 📊 当前状态" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

API_REMAIN="未知"
API_USED="未知"
if [ -f "/root/.openclaw/workspace/memory/api_status.md" ]; then
    API_REMAIN=$(grep "剩余次数" /root/.openclaw/workspace/memory/api_status.md | sed 's/.*: *//')
    API_USED=$(grep "已  用" /root/.openclaw/workspace/memory/api_status.md | sed 's/.*: *//')
    echo "- **API 已用**: $API_USED" >> "$REPORT_FILE"
    echo "- **API 剩余**: $API_REMAIN" >> "$REPORT_FILE"
fi

# 存储/内存
DISK=$(df -h / | tail -1 | awk '{print $5}')
MEM=$(free -h | grep Mem | awk '{print $3 "/" $2}')
echo "- **存储**: $DISK | **内存**: $MEM" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ===== 2. 这3小时我做了什么 =====
echo "## 🔧 这3小时我做了什么" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 查找这3小时修改的文件
HOUR_DIRTY=$(date -d "3 hours ago" +%Y-%m-%d\ %H:00)
MODIFIED_FILES=$(find /root/.openclaw/workspace -name "*.sh" -newermt "$HOUR_DIRTY" 2>/dev/null | grep -v ".git" | head -10)
if [ -n "$MODIFIED_FILES" ]; then
    echo "### 📝 修改的文件" >> "$REPORT_FILE"
    for f in $MODIFIED_FILES; do
        echo "- $(basename $f)" >> "$REPORT_FILE"
    done
    echo "" >> "$REPORT_FILE"
fi

# 记录最近 session 的关键操作
echo "### 💬 最近对话摘要" >> "$REPORT_FILE"
LATEST_SESSION=$(ls -t ~/.openclaw/agents/main/sessions/*.jsonl 2>/dev/null | head -1)
if [ -n "$LATEST_SESSION" ]; then
    # 提取最近几次 tool call 的名称
    TOOLS=$(tail -200 "$LATEST_SESSION" 2>/dev/null | grep -o '"name":"[^"]*"' | cut -d'"' -f4 | sort | uniq -c | sort -rn | head -5)
    if [ -n "$TOOLS" ]; then
        echo "调用次数最多的工具:" >> "$REPORT_FILE"
        echo "$TOOLS" | while read count name; do
            echo "- $name: $count 次" >> "$REPORT_FILE"
        done
    else
        echo "- 暂无工具调用记录" >> "$REPORT_FILE"
    fi
fi
echo "" >> "$REPORT_FILE"

# ===== 3. 和3小时前对比 =====
echo "## 📈 和3小时前对比" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查3小时前的复盘
PREV_REPORT="$REPORT_DIR/hourly_$THREE_HOURS_AGO.md"
if [ -f "$PREV_REPORT" ]; then
    echo "### 🔄 相比3小时前" >> "$REPORT_FILE"
    
    # 统计文件变化
    PREV_FILES=$(find /root/.openclaw/workspace -newermt "$HOUR_DIRTY" -name "*.sh" 2>/dev/null | wc -l)
    echo "- 新增/修改文件: $PREV_FILES 个" >> "$REPORT_FILE"
    
    # 目标进度
    TOTAL_NOW=$(grep -c "\[x\]" /root/.openclaw/workspace/GOALS.md 2>/dev/null || echo 0)
    echo "- 当前已完成目标: $TOTAL_NOW 个" >> "$REPORT_FILE"
else
    echo "- 暂无3小时前数据对比" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# ===== 4. 当前大目标是什么 =====
echo "## 🎯 当前大目标" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 从 GOALS.md 获取
if [ -f "/root/.openclaw/workspace/GOALS.md" ]; then
    echo "### 📋 今日/本周目标" >> "$REPORT_FILE"
    grep -E "^\- \[ \]" /root/.openclaw/workspace/GOALS.md 2>/dev/null | head -3 >> "$REPORT_FILE" || echo "- 暂无待处理目标" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    
    echo "### ✅ 最近完成" >> "$REPORT_FILE"
    grep -E "^\- \[x\]" /root/.openclaw/workspace/GOALS.md 2>/dev/null | tail -3 >> "$REPORT_FILE" || echo "- 暂无已完成" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# ===== 5. 待处理任务 =====
echo "## ⚠️ 需要你帮忙" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
grep -E "^\- \[ \]" /root/.openclaw/workspace/GOALS.md 2>/dev/null | head -3 >> "$REPORT_FILE" || echo "- 无待处理任务" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ===== 6. 后台任务状态 =====
echo "## 📋 后台任务" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "### ⏰ 最近执行的定时任务" >> "$REPORT_FILE"
for task in monitor_light hourly_review cycle_check research_task; do
    LAST_RUN=$(ls -lt /root/.openclaw/workspace/scripts/${task}.sh 2>/dev/null | awk '{print $6,$7,$8}')
    if [ -n "$LAST_RUN" ]; then
        echo "- $task: $LAST_RUN" >> "$REPORT_FILE"
    fi
done
echo "" >> "$REPORT_FILE"

echo "---" >> "$REPORT_FILE"
echo "*复盘时间: $(date)*" >> "$REPORT_FILE"

echo "✅ 已生成: $REPORT_FILE"
