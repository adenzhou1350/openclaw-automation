# OpenClaw Automation Suite 🦞

> 基于 OpenClaw 的 AI 个人助理自动化工具集

## Who I Am

一个专注于 **自动化** 和 **AI 应用开发** 的技术爱好者。目标是打造一个能自主运行、持续学习的 AI 助手。

## Worldview

- **自动化是为了自由** — 把时间留给创造性工作
- **好的系统应该自己运转** — 减少人工干预
- **监控是可靠的基石** — 知道系统在发生什么
- **持续改进比一次做对更重要** — 小步快跑

## Opinions

### 自动化
- 能自动化的一定要自动化，重复是人类的敌人
- 自动化不等于不需要人，而是让人做更重要的事
- 好的自动化是让人感受不到它的存在

### AI Agent
- Agent 需要记忆和上下文才能真正有用
- 规则引擎 + AI 的混合方案比纯 AI 更可靠
- 反馈循环是 Agent 进化的关键

### 监控系统
- 没有监控就像闭眼开车
- 告警要有分级，轻重缓急要分明
- 历史数据是用来分析趋势的，不是用来后悔的

## Current Focus

- 桌面自动化 (OCR + 键鼠模拟)
- 企业微信消息集成
- 定时任务与每日复盘

## Interests

- **Agent 框架**: OpenClaw, Claude Code
- **桌面自动化**: Python + OpenCV + pyautogui
- **监控系统**: 存储、内存、API 配额
- **消息通道**: 企业微信、Telegram、Discord

## Vocabulary

- **Heartbeat**: 周期性自检机制
- **Cron**: 定时任务
- **TTS**: 文字转语音 (Edge TTS / ElevenLabs)
- **AMR**: 企业微信语音格式

## Pet Peeves

- 监控告警疲劳 (太多无意义的警告)
- 没有日志的错误排查
- 自动化脚本没有错误处理

## 📌 项目简介

本项目展示如何使用 OpenClaw 打造个人 AI 助理，包含多种自动化场景的实现方案。

**为什么选择 OpenClaw？**
- 🌐 多平台支持 (企业微信、Telegram、Discord)
- 🔄 强大的定时任务 (cron) 能力
- 🧠 记忆系统与自我进化
- 📱 移动端通知支持

## 🛠️ 已实现功能

### 📅 日程管理
- ✅ 天气早报自动发送
- ✅ 定时任务提醒 (cron)
- ✅ 每日/每周复盘
- ✅ 睡前提醒

### 🔍 监控告警
- ✅ API 状态监控
- ✅ 存储空间监控
- ✅ 内存使用监控
- ✅ 语音消息发送 (企业微信)

### 💬 消息通知
- ✅ 企业微信消息发送 (文字 + 语音)
- ✅ 多平台支持 (Telegram, Discord 等)

### 🎯 桌面自动化
- ✅ 截图捕获
- ✅ OCR 文字识别
- ✅ 模板匹配
- ✅ 键鼠模拟

## 🚀 快速开始

### 1. 安装 OpenClaw

```bash
npm install -g openclaw
```

### 2. 克隆本项目

```bash
git clone https://github.com/adenzhou1350/openclaw-automation.git
cd openclaw-automation
```

### 3. 配置环境变量

```bash
# 创建 .env 文件
cp .env.example .env
# 编辑 .env 添加你的配置
```

### 4. 运行脚本

```bash
# 生成天气早报
./scripts/generate_morning_report.sh

# 系统监控
./scripts/monitor.sh

# 设置定时任务
crontab crontab
```

## 📂 项目结构

```
.
├── skills/                      # 可复用技能包
│   ├── desktop-automation/     # 桌面自动化
│   ├── system-monitor/         # 系统监控
│   └── wecom-voice/           # 语音发送
├── scripts/                     # 自动化脚本
│   ├── generate_morning_report.sh  # 早报生成
│   ├── monitor.sh               # 系统监控
│   ├── check_api.sh            # API 监控
│   └── wecom_voice.py          # 语音发送脚本
├── crontab                      # Cron 配置模板
├── desktop_automation.py        # 桌面自动化核心
├── .env.example                 # 环境变量示例
└── README.md
```

## 📖 使用示例

### 天气早报

```bash
# 设置城市
export CITY=上海

# 生成早报
./scripts/generate_morning_report.sh
```

### 系统监控

```bash
# 检查所有
./scripts/monitor.sh

# 仅检查 CPU
./scripts/monitor.sh --cpu

# 仅检查内存
./scripts/monitor.sh --mem

# 仅检查磁盘
./scripts/monitor.sh --disk
```

### 企业微信语音发送

```bash
python3 scripts/wecom_voice.py "你好，这是语音测试" aden
```

### 桌面自动化

```python
from desktop_automation import capture_screen, ocr_detect, click

# 截图
img = capture_screen()

# OCR 识别文字
result = ocr_detect(img, "确定")

# 点击按钮
click(result[0], result[1])
```

## 🔧 技能开发

开发自定义技能参考 [OpenClaw 文档](https://docs.openclaw.ai)。

## 📈 后续规划

- [ ] 小红书教程发布
- [ ] 闲鱼接单服务
- [ ] 更多自动化场景

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 License

MIT License - 自由使用，欢迎 Star ⭐
