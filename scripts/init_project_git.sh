#!/bin/bash
# 项目 Git 初始化脚本
# 用法：bash init_project_git.sh [项目目录]
#
# 环境变量（可选）：
#   GIT_USER_NAME  — Git 用户名（默认：agent）
#   GIT_USER_EMAIL — Git 邮箱（默认：agent@local）

PROJECT_DIR=${1:-.}

cd "$PROJECT_DIR" || { echo "❌ 无法进入目录：$PROJECT_DIR"; exit 1; }

if [ -d ".git" ]; then
    echo "⚠️  当前目录已是 git 仓库，跳过初始化"
    exit 0
fi

git init || { echo "❌ git init 失败"; exit 1; }

git config user.name "${GIT_USER_NAME:-agent}"
git config user.email "${GIT_USER_EMAIL:-agent@local}"

# 通用 .gitignore 模板
cat > .gitignore << 'EOF'
# 备份文件
backups/
*.bak_*
*.bak

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
*.egg-info/
dist/
build/

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# 系统文件
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
EOF

git add .
git commit -m "初始化：项目版本控制配置"

echo "✅ Git 仓库初始化完成：$(pwd)"
