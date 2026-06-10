# Skill README 美化与重写参考指南

> 来源：2026-06-10 会话——使用 check-then-go skill 本身推进 check-then-go 的 README.md 美化与重写项目。

---

## 一、README 信息架构推荐顺序

优先让新读者 **30 秒内看懂"是什么、为什么需要、怎么用"**：

1. **Hero 区**：居中标题 + shields.io badges + 一句话定义 + 锚点导航
2. **适用场景**：列出适用/不适用场景，配 `<blockquote>` 提示框
3. **"为什么需要"痛点表**：Markdown 表格，3 行以内，快速建立价值感
4. **核心流程全景图**：ASCII 艺术图或 Mermaid 流程图，一眼看懂
5. **执行铁律/规范**：紧跟流程图，配 ❌/✅ 对比
6. **速查/反模式**：常见错误及对策
7. **Checklist**：可复用的自检清单
8. **快速开始**：安装 + 触发方式 + 指向完整规范的链接
9. **详细示例**：折叠在 `<details>` 中，需要时展开
10. **许可/作者**：元信息

---

## 二、Shields.io Badges

### 原理

shields.io 通过 URL 参数生成 SVG 图片，Markdown 用 `![文字](URL)` 嵌入，
GitHub 渲染时排成一排小标签。

### 常用 URL 模板

```markdown
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)
![Skill](https://img.shields.io/badge/skill-workflow-blue?style=flat-square)
![Status](https://img.shields.io/badge/status-stable-orange?style=flat-square)
```

**参数说明**：
- `?style=flat-square` → 扁平方块风格（最现代）
- `?style=for-the-badge` → 粗体大标签风格
- `?logo=github` → 带 GitHub 图标
- `?color=ff69b4` → 自定义颜色

**居中放置**：
```markdown
<div align="center">

# ⚡ check-then-go

[![License](...)]() [![Skill](...)]() [![Status](...)]()

AI Agent 通用交互与版本控制规范

[适用场景](#...) • [五阶段状态机](#...) • [执行铁律](#...)

</div>
```

---

## 三、GitHub 安全 HTML 标签速查

GitHub Flavored Markdown 完全支持且不会破坏渲染的标签：

| 标签 | 用途 | 示例 |
|-------|------|-------|
| `<div align="center">` | 居中对齐 | Hero 区、徽章区 |
| `<details>` / `<summary>` | 折叠内容 | 长示例、详细规范 |
| `<blockquote>` | 提示框 | 信息/警告/成功提示 |
| `<kbd>` | 键盘按键高亮 | `git commit`、`Ctrl+C` |
| `<a name="...">` | 锚点 | 顶部导航跳转 |
| `<br>` | 行间距控制 | Hero 区呼吸感 |
| `<hr>` / `---` | 视觉分隔 | 章节分区 |
| `<sub>` / `<sup>` | 上下标 | 注释、版本号 |

**禁用**（会被 GitHub 过滤或导致渲染异常）：
- `<style>` ❌
- `<script>` ❌
- 自定义 CSS ❌

---

## 四、嵌套代码块约定

当需要在 Markdown 代码块内展示另一个代码块时（如示例中的对话内容包含代码），
**必须使用两种不同的代码块标识符**：

```markdown
外层用 ~~~：
~~~
Agent：
```
内层用 ```：
用户：请使用 check-then-go skill
```
~~~
```

**必须区分场景：**

| 场景 | 外层标记 | 内层标记 | 理由 |
|------|----------|----------|------|
| 普通单层代码块（无嵌套） | ``` | 无 | 标准做法 |
| 代码块内包含另一个代码块 | ~~~ | ``` | 避免标识符冲突 |

**本会话实际违规记录**：
- 一键安装提示词是单层文本，无嵌套代码块，却误用了 `~~~`。用户纠正："这句话它不是双层嵌套呀，为什么外层用了波浪线？"

---

## 五、行内代码尖括号陷阱 ⚠️

行内代码（反引号）中使用尖括号会被 Markdown 解析为 HTML 标签，导致内容消失：

❌ **错误**
```markdown
各平台的 `<TARGET>` 路径：
```
在 Markdown 渲染时，`<TARGET>` 会被当作无效 HTML 标签过滤掉，用户看到的是**空白内容**。

✅ **正确**
```markdown
各平台的 `TARGET` 路径：
```

**对策**：
- 行内代码中避免使用尖括号 `<...>` 包裹内容
- 如需表示占位符，用纯文本 `TARGET` 或 `&lt;TARGET&gt;`
- 如需表示关键词，直接用粗体或 `**TARGET**`

### 5. 文本质量检查清单（必做）

在把文案交给用户之前，自检以下项目：

- [ ] 是否照搬了别人的句式结构？（如果能想到"这是从 XX 找的模板"，那就是抄袭）
- [ ] 是否有奇怪的口语化表达？（如"哥哥一顿改"、"哧哧一顿改"等无意义拟声词）
- [ ] 是否有内容为空的行内代码块？（检查 `<...>` 尖括号）
- [ ] 非嵌套场景是否误用了 `~~~`？
- [ ] 是否有自己的风格特征？（至少3处与示例不同的表达）

**本会话实际违规记录**：
- "哥哥一顿改"被用户纠正为奇怪表达
- `尖括号 <TARGET>` 导致行内代码块内容为空
- 非嵌套场景误用 `~~~` 被纠正

使用简单的框线字符（┌─┬─┐│└┘├┤─→▼）构建分阶段流程图，
每个阶段配一个 emoji 作为视觉锚点：

```
┌──────────────────────────┐
│  🎯 阶段一：需求确认    │
│  复述需求 → 用户确认      │
└───────────────────┬────┘
                     ▼
```

元素：
- 方框界定流程边界
- 箭头指示方向
- 回滚路径用分支线表示

---

## 六、本会话实际用法回顾

**HTML 元素使用清单**（check-then-go README 最终版）：
- `<div align="center">` × 2（Hero 区 + 导航链接）
- `<blockquote>` × 3（提示框、三大陷阱各 1 个）
- `<kbd>` × 多处（git 命令高亮）
- `<details>` / `<summary>` × 1（完整示例折叠）
- `<a name="...">` × 3（章节锚点）
- `---` 分隔线 × 多处

**Badge 选择**：
- License: MIT（静态，绿色）
- Skill: workflow（静态，蓝色）
- Status: stable v1.0（静态，橙色）

---

## 七、用户 README 风格偏好（本次会话确定）

用户对 skill 的 README 文案有以下明确偏好，未来为该用户编写 README 时应尽量遵循：

### 1. 去平台化安装说明

**不要**写平台特定的安装步骤列表（如 Claude Code 放哪、Cursor 放哪）。
**要**写：

```markdown
2026 年了，你有 Agent，让它自己装。

打开你用的 Claude Code / Hermes / OpenClaw / Codex，把下面这句丢给它：

```
帮我安装 check-then-go 这个 skill：https://github.com/NiannianSoHungry/check-then-go-skill
```

Agent 会自动识别当前宿主的 skills 目录、完成 clone、注册入口。
```

理念：相信 Agent 的能力，让它自己处理平台差异，而不是给用户一个平台适配表。

### 2. 口语化、轻松语气

- 使用"丢给它"、"让它自己装"等口语化表达
- 避免文档式的"安装指南"、"配置说明"
- 用 emoji 增加轻松感（🛠️ 想自己手动装？）

### 3. 手动安装作为备选（折叠）

手动路径表可以放，但要放在 `<details>` 折叠区里，不要一上来就给大段平台列表。

### 4. 不要单独的 PROMPT.md

用户不希望为了支持多平台而单独维护一个 `PROMPT.md`文件。
所有内容放在 README 里即可，让 Agent 自己抽取。
