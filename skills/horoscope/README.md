# 🌟 星座运势 Skill

> 基于 OpenClaw 的每日星座运势自动推送方案

## 功能简介

- 每日定时推送星座运势
- 支持 12 星座
- 个性化运势分析（事业、爱情、健康、财务）
- 可配置推送时间和频道

## 文件结构

```
horoscope/
├── README.md              # 本文件
├── SKILL.md              # Skill 定义
└── scripts/
    └── horoscope.py       # 运势数据获取脚本
```

## 快速开始

### 1. 配置星座

在 OpenClaw 中设置用户星座：

```
/set zodiac Aries  # 白羊座
/set zodiac Taurus # 金牛座
```

支持的星座：
- Aries (白羊座)
- Taurus (金牛座)
- Gemini (双子座)
- Cancer (巨蟹座)
- Leo (狮子座)
- Virgo (处女座)
- Libra (天秤座)
- Scorpio (天蝎座)
- Sagittarius (射手座)
- Capricorn (摩羯座)
- Aquarius (水瓶座)
- Pisces (双鱼座)

### 2. 设置定时任务

配置每日运势推送：

```
/cron add 8 * * * horoscope.daily
```

### 3. 获取运势数据

脚本会自动从免费星座 API 获取运势数据。

## 进阶用法

### 自定义运势模板

编辑 `SKILL.md` 修改输出格式。

### 对接其他 API

支持对接 AstrologyAPI、HoroscopeAPI 等付费 API。

## 示例输出

```
♈ 今日星座运势 - 白羊座 (03月04日)

💼 事业: ⭐⭐⭐⭐ 今日工作运势不错，适合开展新项目
💕 爱情: ⭐⭐⭐ 感情运势平稳，单身者可多参加社交活动
💪 健康: ⭐⭐⭐⭐ 注意休息，避免过度劳累
💰 财运: ⭐⭐⭐ 财务状况良好，可适当理财

✨ 幸运色: 红色
✨ 幸运数字: 7
```

## 相关资源

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [lunar-calendar Skill](../lunar-calendar) - 农历查询，配合使用更佳
