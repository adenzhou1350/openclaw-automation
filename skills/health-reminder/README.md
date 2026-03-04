# 💪 Health Reminder Skill

> OpenClaw 健康提醒技能 - 定时提醒喝水、运动、休息

## 功能特点

- ⏰ 定时提醒：可配置提醒间隔
- 💧 喝水提醒：保持身体水分
- 🏃 运动提醒：久坐提醒活动
- 👀 护眼提醒：20-20-20 法则
- 🌙 睡眠提醒：养成良好作息

## 使用方法

```bash
# 在 OpenClaw 中加载技能
skill install ./skills/health-reminder

# 设置提醒
@bot 设置健康提醒 每小时
@bot 关闭健康提醒
```

## 定时配置

通过 cron 配置定时检查：

```bash
# 每小时提醒
0 * * * * /path/to/health_reminder.sh "water"

# 每2小时运动提醒
0 */2 * * * /path/to/health_reminder.sh "exercise"

# 下午3点护眼提醒
0 15 * * * /path/to/health_reminder.sh "eyes"
```

## 消息示例

```
💧 喝水提醒
该喝水啦！已经工作了1小时，
建议喝一杯温水补充水分。

🏃 运动提醒
久坐1小时了该活动一下！
起来走动5分钟，伸展身体。

👀 护眼提醒
让眼睛休息一下吧～
遵循 20-20-20 法则：
看20英尺外的物体20秒

🌙 睡眠提醒
该睡觉啦！
建议在23:00前入睡，
保证7-8小时睡眠。
```

## 环境变量

```bash
export WECOM_WEBHOOK="your-webhook-url"
export REMINDER_INTERVAL=60  # 分钟
```

## 配合 Cron 使用

```bash
# 添加到 crontab
crontab -e

# 每小时喝水提醒
0 * * * * /path/to/scripts/health_reminder.sh water

# 每2小时运动提醒
0 */2 * * * /path/to/health_reminder.sh exercise
```

---

💡 提示：结合天气早报使用效果更佳！
