#!/bin/bash
# 项目快照备份脚本
# 用法：bash backup_project.sh <项目目录> <备份目录>
#
# 创建带时间戳的项目完整副本，用于重大修改前的兜底保护。
# 命名格式：{项目名}_{YYYYMMDD_HHMMSS}/

set -e

PROJECT_DIR=$1
BACKUP_DIR=$2

if [ -z "$PROJECT_DIR" ] || [ -z "$BACKUP_DIR" ]; then
    echo "用法：bash backup_project.sh <项目目录> <备份目录>"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ 项目目录不存在：$PROJECT_DIR"
    exit 1
fi

mkdir -p "$BACKUP_DIR"

PROJECT_NAME=$(basename "$PROJECT_DIR")
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_PATH="$BACKUP_DIR/${PROJECT_NAME}_${TIMESTAMP}"

cp -r "$PROJECT_DIR" "$BACKUP_PATH"

# 排除备份目录中的 .git 和 backups 以节省空间（可选）
# 如需保留完整副本，注释掉以下行
# rm -rf "$BACKUP_PATH/.git"
# rm -rf "$BACKUP_PATH/backups"

echo "✅ 快照已创建：$BACKUP_PATH"
