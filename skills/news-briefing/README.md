# 📰 News Briefing Skill - 每日新闻简报

> 自动获取并整理每日热点新闻，生成简报推送

## 功能特性

- 🎯 **多源聚合**: 整合科技、财经、热点新闻
- 📝 **智能摘要**: 自动提取关键信息
- ⏰ **定时推送**: 每日早上自动发送
- 📱 **多平台支持**: 企业微信、Telegram、Discord

## 使用方法

### 1. 安装依赖

```bash
pip install requests beautifulsoup4
```

### 2. 配置环境变量

```bash
# 在 .env 中添加
export NEWS_API_KEY="your_api_key"  # 可选，使用免费源可不填
export WECOM_WEBHOOK="your_webhook_url"
```

### 3. 运行脚本

```bash
# 生成今日简报
./scripts/news_briefing.sh

# 仅获取科技新闻
./scripts/news_briefing.sh --category tech
```

## 定时任务配置

在 crontab 中添加:

```cron
# 每天早上 7:30 自动发送新闻简报
30 7 * * * cd /path/to/skills/news-briefing && ./scripts/news_briefing.sh
```

## 输出示例

```
📰 每日新闻简报 - 2026年3月4日

【科技热点】
1. OpenClaw 发布新版本，AI Agent 能力再升级
2. 具身智能领域取得新突破

【财经要闻】
1. A 股三大指数全线上涨
2. 新能源板块持续火热

【今日天气】
上海: ☀️ 晴 15-22°C

🔗 了解更多: news.example.com
```

## 文件结构

```
news-briefing/
├── README.md           # 本文件
├── SKILL.md            # OpenClaw 技能定义
└── scripts/
    └── news_briefing.sh # 主脚本
```

## 扩展定制

- 添加更多新闻源
- 自定义摘要长度
- 过滤特定关键词
- 个性化推荐

---

**配合 OpenClaw 使用**: 可以设置为每日定时任务，自动生成并发送到你的通讯工具！
