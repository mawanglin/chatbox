# Fork Patches - 从官方仓库同步后必须的补丁

官方开源仓库缺少部分文件（可能是闭源组件），同步代码后需要确认以下补丁仍然存在。

## 1. `src/shared/providers/index.ts`
注释掉官方未公开的 github-copilot provider 导入：
```ts
// 官方仓库未公开此文件，暂时注释
// import './definitions/github-copilot'
```

## 2. `src/shared/oauth/index.ts`
添加官方未导出的 OAuth 类型和常量（被 `src/renderer/hooks/useOAuth.ts` 引用）：
- `OAuthResult` interface
- `OAuthStartResult` interface
- `DeviceFlowStartResult` interface
- `OAuthIpcChannels` const

## 3. `src/renderer/packages/translation.ts` (新文件)
官方未公开的翻译模块占位实现（被 `MessageErrTips.tsx` 引用）：
```ts
export async function translateTexts(texts, targetLang, options?) {
  return texts // 直接返回原文
}
```

## 4. `.erb/scripts/delete-source-maps-runner.js` (新文件)
构建脚本 `package.json` 中 `delete-sourcemaps` 命令引用此文件，但官方仓库未提供：
```js
import deleteSourceMaps from './delete-source-maps'
deleteSourceMaps()
```

## 同步后验证
每次从官方仓库同步代码后：
1. 检查上述文件是否被覆盖或冲突
2. 运行 `pnpm run build:web` 验证构建是否通过
3. 如果官方新增了更多未公开的导入，按相同模式添加占位实现
