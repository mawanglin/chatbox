// 官方仓库未公开此模块，提供占位实现以保证构建通过
export async function translateTexts(
    texts: string[],
    targetLang: string,
    options?: { sourceLang?: string }
): Promise<(string | undefined)[]> {
    return texts
}
