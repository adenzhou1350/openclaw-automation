# 🤝 贡献指南

感谢你对 OpenClaw Automation Suite 项目的兴趣！我们欢迎任何形式的贡献。

## 如何贡献

### 报告 Bug

1. 检查是否已存在相关 Issue
2. 如果没有，创建新 Issue 并包含：
   - 清晰的标题和描述
   - 复现步骤
   - 预期 vs 实际行为
   - 环境信息

### 提出新功能

1. 创建 Feature Request Issue
2. 说明用例和预期效果
3. 讨论可行性后再开发

### 提交代码

1. Fork 本仓库
2. 创建功能分支：`git checkout -b feature/your-feature`
3. 编写代码并添加测试
4. 提交更改：`git commit -m 'Add some feature'`
5. 推送分支：`git push origin feature/your-feature`
6. 创建 Pull Request

## 开发规范

### 代码风格

- 使用清晰的变量命名
- 添加必要的注释
- 保持代码简洁

### 提交信息格式

```
<type>(<scope>): <description>

[optional body]
```

类型 (type)：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式
- `refactor`: 重构
- `test`: 测试
- `chore`: 维护

### 示例

```
feat(scripts): 添加 API 监控脚本

- 新增 check_api.sh 用于监控外部 API 状态
- 支持自定义检查间隔
- 添加企业微信通知集成
```

## 项目结构说明

```
openclaw-automation/
├── skills/          # 技能包（可复用）
├── scripts/         # 自动化脚本
├── .env.example     # 环境变量模板
└── crontab         # 定时任务配置
```

## 问题解答

Q: 如何添加新的自动化脚本？
A: 在 `scripts/` 目录下创建 `.sh` 文件，参考现有脚本的格式。

Q: 如何开发自定义 Skill？
A: 参考 OpenClaw 官方文档，创建对应的 skill 目录和配置文件。

## 联系方式

- GitHub Issues: https://github.com/openclaw/openclaw-automation/issues
- 欢迎提交 PR 和 Star ⭐

---

一起让 OpenClaw 变得更强大！ 🚀
