# Docker Support

## Dockerfile 关键要点

1. **必须复制 `.npmrc`** — 项目配置了 `node-linker=hoisted`，不复制会导致 pnpm 使用严格模式，间接依赖（如 source-map-support）无法被解析
2. **必须复制 `patches/`** — pnpm-lock.yaml 引用了 patch 文件
3. **必须复制 `.erb/scripts/`** — postinstall 脚本需要
4. **使用 pnpm** — 项目用 pnpm 管理依赖（有 pnpm-lock.yaml），npm install 会因 peer dependency 冲突失败
5. **不要用国内镜像源** — GitHub Actions 环境访问 npm 官方源更快更稳定，镜像源注释保留供本地构建使用

## GitHub Actions

- Workflow: `.github/workflows/docker-publish.yml`
- 触发分支: `feature/docker-support`（如需改为 main，修改 workflow 中的 branches）
- Docker Hub: `virson/chatbox-web:latest`
- Secrets 需要: `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`（Docker Hub Personal Access Token，需 Read/Write/Delete 权限）
- Actions 版本: checkout@v5, login-action@v4, build-push-action@v6（Node.js 24 兼容）

## 构建失败排查经验

| 错误 | 原因 | 解决 |
|------|------|------|
| `source-map-support` 无法解析 | .npmrc 未复制，pnpm 未 hoist 间接依赖 | COPY .npmrc |
| `ENOENT patches/xxx.patch` | patches 目录未复制 | COPY patches |
| `Cannot find postinstall.cjs` | .erb/scripts 未复制 | COPY .erb/scripts |
| npm peer dependency 冲突 | react 版本不匹配 | 使用 pnpm |
| `Username and password required` | Docker Hub secrets 未配置 | 在 GitHub repo settings 添加 secrets |
