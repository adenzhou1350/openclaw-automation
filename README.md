# OpenClaw Automation 🦞

把早报、资源检查、喝水提醒这些重复小事写成脚本，按需接到 OpenClaw 或系统 cron 中。

多数脚本可以直接运行。先在终端看输出，再配置消息渠道和定时执行。

## 从一个本地检查开始

Shell 脚本面向 Linux / WSL，需要 Bash 和常见系统工具（`top`、`free`、`df`）。

```bash
git clone https://github.com/adenzhou1350/openclaw-automation.git
cd openclaw-automation
bash scripts/monitor.sh --mem
bash scripts/health_reminder.sh water
```

前一条打印当前内存占用；后一条未配置 Webhook 时只打印提醒，不发消息。

## 可以尝试的脚本

| 场景 | 入口 | 运行条件 |
| --- | --- | --- |
| CPU / 内存 / 磁盘检查 | [monitor.sh](scripts/monitor.sh) | Linux 系统工具；支持 `--cpu`、`--mem`、`--disk` |
| 天气早报 | [generate_morning_report.sh](scripts/generate_morning_report.sh) | `curl` 和网络，天气来自 wttr.in |
| 喝水 / 活动 / 护眼 / 睡眠提醒 | [health_reminder.sh](scripts/health_reminder.sh) | 可选企业微信 Webhook |
| 工作区复盘 | [hourly_review.sh](scripts/hourly_review.sh) | 已有 OpenClaw 工作区、GNU `date` |
| 截图 / OCR / 模板匹配 | [desktop_automation.py](desktop_automation.py) | 图形桌面与对应 Python 依赖 |

## 配置和早报

```bash
cp .env.example .env
# 编辑 .env，按需填写城市和自己的 Webhook
set -a
. ./.env
set +a
bash scripts/generate_morning_report.sh
```

`.env` 已被 Git 忽略。设置 `WECOM_WEBHOOK` 后，早报和健康提醒脚本会向该地址发送消息；保持为空即可只查看终端输出。CPU、内存、磁盘阈值可通过同名环境变量调整。

## 桌面操作

需要有图形界面的 Python 环境。按实际使用的功能安装依赖：截图和键鼠使用 `pyautogui`，模板匹配使用 `opencv-python` / `numpy`，OCR 使用 PaddleOCR 或 `pytesseract`（后者还需系统 Tesseract）。

```bash
python desktop_automation.py --help
```

```python
from desktop_automation import capture_screen, ocr_detect, click_at

image_path = capture_screen()
position = ocr_detect(image_path, "确定")
if position is not None:
    print("识别到的位置：", position)
    # 确认目标窗口后再执行：click_at(*position)
```

这部分需要在自己的桌面环境试用；Linux 服务器上的资源检查与图形桌面操作有不同的运行条件。

## 定时执行

[crontab](crontab) 提供已存在脚本的示例。先把路径换成你的实际目录，再用 `crontab -e` 加入需要的任务。

工作区复盘使用 `OPENCLAW_WORKSPACE`，默认 `~/.openclaw/workspace`；会在 `memory/checkpoints` 中写报告。仓库还保留一些 [技能说明](skills)，以实际脚本为准。

欢迎提交可复现的问题或小改进，见 [贡献说明](CONTRIBUTING.md)。

[MIT License](LICENSE)
