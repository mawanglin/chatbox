# Chatbox (mawanglin.chatbox)

## Project Overview
- Fork of https://github.com/chatboxai/chatbox.git ，合并了 https://github.com/highkay/chatbox.git 的修改
- 技术栈: TypeScript, React, Electron, Next.js
- 包管理: pnpm（有 pnpm-lock.yaml，`.npmrc` 配置了 `node-linker=hoisted`）
- 构建: `pnpm run build:web` (使用 electron-vite)

## Fork Sync Patches
官方开源仓库缺少部分闭源文件，同步后需确认以下补丁存在：

1. **`src/shared/providers/index.ts`** — 注释掉 `import './definitions/github-copilot'`
2. **`src/shared/oauth/index.ts`** — 添加 `OAuthResult`, `OAuthStartResult`, `DeviceFlowStartResult`, `OAuthIpcChannels` 存根
3. **`src/renderer/packages/translation.ts`** — 翻译模块占位实现（返回原文）
4. **`.erb/scripts/delete-source-maps-runner.js`** — 构建脚本入口文件

详见 `docs/fork-patches.md`

## Docker Support
- Dockerfile 关键: 必须 COPY `.npmrc`、`patches/`、`.erb/scripts/`
- GitHub Actions: `.github/workflows/docker-publish.yml`
- Docker Hub: `virson/chatbox-web:latest`
- Secrets: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`

详见 `docs/docker-support.md`
