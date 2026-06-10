# Git Push 与 SSH Key 跨 Profile 复用笔记

> 来源：2026-06-10 会话——尝试将 check-then-go skill 推送到 GitHub 时发现的服务器环境特性。

---

## 问题场景

1. 当前工作目录（`~/.hermes/skills/workflow/check-then-go`）刚刚初始化 git，`~/.ssh/` 下没有 SSH 私钥。
2. 服务器上另一个归档目录（`~/.hermes/skills/.archive/.../check-then-go`）却是从 GitHub SSH clone 下来的。
3. 排查后发现：Hermes 的 **researcher profile** 在其独立 home 目录下（`~/.hermes/profiles/researcher/home/.ssh/`）拥有 `id_ed25519` 密钥对，
   而默认用户环境的 `~/.ssh/` 下没有。

## 根因

Hermes 采用 **profile 隔离设计**：每个 profile 有独立的 `$HOME`，包含自己的 `.ssh/` 配置。
当用户切换 profile 时，SSH key 也随之切换，不在默认环境中共享。

## 解决方案

### 方案 A：一次性环境变量注入（推荐）

无需修改 `~/.ssh/config`，无需复制私钥，用 `GIT_SSH_COMMAND` 指定使用其他 profile 的 key：

```bash
cd /path/to/your/repo
GIT_SSH_COMMAND='ssh -i /home/ubuntu/.hermes/profiles/researcher/home/.ssh/id_ed25519' \
  git push -u origin main
```

**优点**：零配置、不污染默认环境、push 完成后不留痕迹。

### 方案 B：配置 SSH Config

在 `~/.ssh/config` 中指定 GitHub 使用特定 key：

```
Host github.com
    IdentityFile /home/ubuntu/.hermes/profiles/researcher/home/.ssh/id_ed25519
    User git
    IdentitiesOnly yes
```

**注意**：这会影响该服务器上所有使用 GitHub 的 git 操作。

### 方案 C：复制 key 到默认环境

```bash
cp /home/ubuntu/.hermes/profiles/researcher/home/.ssh/id_ed25519* ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
```

**风险**：破坏 profile 隔离设计，key 分布在多个位置，后续维护困难。

## 快速检查命令

```bash
# 查找服务器上所有 SSH 私钥
find /home -name "id_*" -path "*/.ssh/*" 2>/dev/null

# 测试特定 key 是否能连通 GitHub
ssh -i /path/to/key -o BatchMode=yes -o ConnectTimeout=5 git@github.com
```

---

## 附录：本地新仓库推送到已有远程仓库

**场景**：当前目录用 `git init` 初始化了新仓库，但远程 GitHub 仓库已经有历史提交。此时直接 `git push` 会报错：
```
! [rejected] main -> main (fetch first)
```

**根因**：本地与远程没有共同祖先，Git 拒绝非快进式推送。

**解决方案**（保留本地工作，重置到远程历史）：

```bash
# 1. 备份当前工作
cp README.md /tmp/README_new.md

# 2. 重置本地分支到远程历史
git fetch origin main
git reset --hard origin/main

# 3. 覆盖文件并重新提交
cp /tmp/README_new.md README.md
git add README.md
git commit -m "docs: 修改说明"

# 4. 推送
git push -u origin main
```

**适用场景**：
- 本地新初始化的 skill 目录需要推送到已有的 GitHub 远程仓库
- 任何"本地新仓库 vs 远程旧仓库"的历史冲突场景
