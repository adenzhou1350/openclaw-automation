#!/bin/bash
# Health Reminder Script - 健康提醒脚本
# 用法: ./health_reminder.sh [water|exercise|eyes|sleep]

TYPE=${1:-water}
WECOM_WEBHOOK=${WECOM_WEBHOOK:-""}

get_message() {
    case $TYPE in
        water)
            echo "💧 喝水提醒
该喝水啦！已经工作了1小时，
建议喝一杯温水补充水分。

保持水分有助于：
✓ 提高注意力
✓ 促进新陈代谢
✓ 保持皮肤健康"
            ;;
        exercise)
            echo "🏃 运动提醒
久坐1小时了该活动一下！
起来走动5分钟，伸展身体。

简易运动：
✓ 颈部旋转
✓ 肩部耸动
✓ 腰部扭转
✓ 站立走动"
            ;;
        eyes)
            echo "👀 护眼提醒
让眼睛休息一下吧～

遵循 20-20-20 法则：
✓ 看20英尺（约6米）外的物体20秒
✓ 每次工作20分钟休息20秒

闭眼休息片刻，让眼睛放松！"
            ;;
        sleep)
            echo "🌙 睡眠提醒
该睡觉啦！

建议：
✓ 在23:00前入睡
✓ 保证7-8小时睡眠
✓ 睡前1小时远离电子设备

晚安！好梦 🌟"
            ;;
        *)
            echo "💪 健康提醒 - $TYPE"
            ;;
    esac
}

send_notification() {
    local message="$1"
    
    if [ -n "$WECOM_WEBHOOK" ]; then
        # 企业微信 webhook
        curl -s -X POST "$WECOM_WEBHOOK" \
            -H "Content-Type: application/json" \
            -d "{\"msgtype\": \"text\", \"text\": {\"content\": \"$message\"}}"
        echo "✅ 已发送企业微信通知"
    else
        echo "$message"
    fi
}

# 主逻辑
MESSAGE=$(get_message)
echo "$MESSAGE"
send_notification "$MESSAGE"
