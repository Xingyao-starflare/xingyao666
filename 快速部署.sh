#!/bin/bash

echo "========================================="
echo "   星耀云网站 - GitHub快速部署脚本"
echo "========================================="
echo ""

# 检查是否在正确的目录
if [ ! -f "index.html" ]; then
    echo "❌ 错误：请在xingyao666-deploy目录中运行此脚本"
    exit 1
fi

echo "📋 步骤1: 检查GitHub CLI登录状态..."
if ! gh auth status > /dev/null 2>&1; then
    echo "⚠️  未登录GitHub，开始登录流程..."
    gh auth login
else
    echo "✓ 已登录GitHub"
fi

echo ""
echo "📋 步骤2: 创建GitHub仓库并推送代码..."
read -p "请输入你的GitHub用户名: " username

if gh repo create xingyao666 --public --source=. --remote=origin --push; then
    echo "✓ 仓库创建成功并推送完成"
else
    echo "⚠️  仓库可能已存在，尝试推送到现有仓库..."
    git remote add origin https://github.com/$username/xingyao666.git 2>/dev/null
    git branch -M main
    git push -u origin main
fi

echo ""
echo "📋 步骤3: 启用GitHub Pages..."
if gh repo edit --enable-pages --pages-branch main; then
    echo "✓ GitHub Pages已启用"
else
    echo "⚠️  请手动在GitHub网站上启用Pages"
    echo "   访问: https://github.com/$username/xingyao666/settings/pages"
fi

echo ""
echo "========================================="
echo "✨ 部署完成！"
echo "========================================="
echo ""
echo "📍 你的网站地址："
echo "   GitHub Pages: https://$username.github.io/xingyao666/"
echo ""
echo "📝 接下来的步骤："
echo "   1. 访问上面的GitHub Pages地址，确认网站正常"
echo "   2. 在GitHub Settings → Pages 中设置自定义域名: xingyao666.top"
echo "   3. 在域名服务商配置DNS A记录（详见部署教程）"
echo "   4. 等待DNS生效（10-30分钟）"
echo "   5. 访问 https://xingyao666.top"
echo ""
echo "📖 详细教程请查看: 部署教程-小白版.md"
echo ""
