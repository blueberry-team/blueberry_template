# Claude Code MCP 설정 가이드

이 프로젝트는 Claude Code에서 MCP (Model Context Protocol) 서버를 사용하여 Figma 디자인과 연동할 수 있습니다.

## 🚀 빠른 시작

### 1단계: Figma API 키 발급

1. [Figma 계정 설정](https://www.figma.com/settings) 접속
2. **Personal access tokens** 섹션으로 이동
3. **Generate new token** 클릭
4. 토큰 이름 입력 (예: "Claude Code MCP")
5. 생성된 API 키 복사 (한 번만 표시되므로 안전한 곳에 보관)

### 2단계: API 키 설정

`.mcp.json` 파일을 열고 `YOUR_FIGMA_API_KEY`를 실제 API 키로 교체:

```json
{
  "mcpServers": {
    "Framelink Figma MCP": {
      "command": "cmd",
      "args": [
        "/c",
        "npx",
        "-y",
        "figma-developer-mcp",
        "--figma-api-key=figd_YOUR_ACTUAL_KEY",
        "--stdio"
      ]
    }
  }
}
```

### 3단계: VS Code 재시작

1. VS Code를 완전히 종료
2. 다시 열기

또는 빠른 재시작:

- `Ctrl + Shift + P` (Mac: `Cmd + Shift + P`)
- "Developer: Reload Window" 입력 후 Enter

### 4단계: 동작 확인

Claude Code에서 Figma URL을 공유하면 자동으로 디자인 정보를 조회할 수 있습니다.

예시:

```
https://www.figma.com/design/FILE_KEY/...?node-id=XXX-XXX
```

---

## 📋 MCP 서버란?

**MCP (Model Context Protocol)**는 Claude Code가 외부 도구 및 데이터와 연동할 수 있게 해주는 프로토콜입니다.

**Framelink Figma MCP**를 사용하면:

- Figma 디자인 정보 조회
- 컴포넌트 구조 분석
- 디자인 시스템 색상/폰트 확인
- UI 구현 시 정확한 스펙 참고

---

## 🔧 macOS/Linux 사용자

`.mcp.json` 파일의 `command`를 수정:

```json
{
  "mcpServers": {
    "Framelink Figma MCP": {
      "command": "npx",
      "args": [
        "-y",
        "figma-developer-mcp",
        "--figma-api-key=YOUR_FIGMA_API_KEY",
        "--stdio"
      ]
    }
  }
}
```

---

## ⚠️ 보안 주의사항

### API 키 보안

- `.mcp.json` 파일에는 실제 API 키가 포함되므로 **절대 Git에 커밋하지 마세요**
- `.gitignore`에 추가 권장:
  ```
  # MCP configuration with API keys
  .mcp.json
  ```

---

## 🆘 트러블슈팅

### MCP 서버가 연결되지 않음

→ VS Code를 완전히 재시작했는지 확인
→ `.claude/settings.json`에 서버 이름이 정확히 등록되었는지 확인

### Figma API 호출 실패

→ API 키가 올바른지 확인
→ Figma 파일에 접근 권한이 있는지 확인
→ API 키 형식: `figd_XXXXX...` 형태

### Windows에서 npx 명령어 오류

→ Node.js가 설치되어 있는지 확인
→ 명령 프롬프트에서 `npx --version` 실행하여 확인

---

## 📚 참고 문서

- [Claude Code MCP 공식 문서](https://docs.claude.com/claude-code)
- [Figma Developer API](https://www.figma.com/developers/api)
- [Framelink Figma MCP GitHub](https://github.com/Framelink/figma-developer-mcp)
