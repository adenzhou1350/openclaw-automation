---
name: horoscope
version: v1.0.0
description: |
  每日星座运势查询与推送。提供 12 星座的今日运势，支持定时自动推送。
---

<skill_body>

## 🎯 Purpose

为用户提供每日星座运势查询服务，支持定时自动推送。可获取事业、爱情、健康、财务四个维度的运势分析。

## ⏰ When to Use

- ✅ 用户询问"今天运势如何"、"星座运势"
- ✅ 用户询问特定星座的运势（如"白羊座今天怎么样"）
- ✅ 定时任务触发每日运势推送
- ❌ 用户询问具体日期的运势（非今日）

## 🧠 Process

### 步骤1：识别星座

解析用户输入或配置获取星座：

```
白羊座 → Aries
金牛座 → Taurus
双子座 → Gemini
巨蟹座 → Cancer
狮子座 → Leo
处女座 → Virgo
天秤座 → Libra
天蝎座 → Scorpio
射手座 → Sagittarius
摩羯座 → Capricorn
水瓶座 → Aquarius
双鱼座 → Pisces
```

### 步骤2：获取运势数据

调用本地脚本获取今日运势：

```bash
python scripts/horoscope.py --zodiac Aries
```

### 步骤3：格式化输出

使用固定模板输出：

```
♈ 今日星座运势 - {星座名} ({日期})

💼 事业: {⭐ x 5} {运势描述}
💕 爱情: {⭐ x 5} {运势描述}
💪 健康: {⭐ x 5} {运势描述}
💰 财运: {⭐ x 5} {运势描述}

✨ 幸运色: {颜色}
✨ 幸运数字: {数字}
```

### 步骤4：定时推送配置

对于 cron 任务，遍历所有已配置用户并发送运势。

## 📋 Command Reference

| 命令 | 说明 |
|------|------|
| `/horoscope` | 查询默认星座今日运势 |
| `/horoscope [星座]` | 查询指定星座今日运势 |
| `/set zodiac [星座]` | 设置我的星座 |
| `/cron add 8 * * * horoscope.daily` | 设置每日早8点推送 |

## ⚠️ Constraints

1. 仅支持今日运势，不支持查询历史或未来运势
2. 运势数据来源于免费 API，可能有延迟
3. 每日 0 点更新当日运势

</skill_body>

## 📁 File Structure

```
horoscope/
├── README.md          # 使用文档
├── SKILL.md          # Skill 定义
└── scripts/
    └── horoscope.py  # 运势获取脚本
```

## 🔗 Related Skills

- [lunar-calendar](../lunar-calendar) - 农历查询，中国传统历法
- [weather](../weather) - 天气查询，配合做早报
- [cron](../cron) - 定时任务配置
