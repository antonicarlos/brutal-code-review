# 🔪 brutal-code-review

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/Licen%C3%A7a-MIT-blue.svg?style=flat-square" alt="Licença MIT"></a>
  <img src="https://img.shields.io/badge/PRs-Bem--vindas-brightgreen.svg?style=flat-square" alt="Pull Requests Bem-vindas">
  <img src="https://img.shields.io/badge/Over--Engineering-Zero%20Toler%C3%A2ncia-red.svg?style=flat-square" alt="Zero Tolerância a Over-Engineering">
  <img src="https://img.shields.io/badge/Multi--Agente-Cursor%20%7C%20Antigravity%20%7C%20Gemini%20%7C%20Claude%20%7C%20Copilot%20%7C%20OpenCode-purple.svg?style=flat-square" alt="Compatível com Cursor, Antigravity, Gemini, Claude, Copilot e OpenCode">
</p>

<p align="center">
  <strong>"Feedback sincero pra quem quer código rodando liso em produção — sem passar pano pra bug e sem inventar 15 camadas de over-engineering pra resolver um <code>if</code>."</strong>
</p>

---

## 📑 Sumário

- [Visão Geral](#visao-geral)
- [Como Executar](#como-executar)
- [Filosofia Central: Sinceridade + Simplicidade](#filosofia)
- [Instalação e Configuração Multiagente](#instalacao)
  - [🚀 Antigravity (Google)](#antigravity)
  - [♊ Gemini CLI & Code Assist](#gemini)
  - [🟢 Cursor AI / Windsurf](#cursor)
  - [🟠 Claude Code](#claude)
  - [🔵 GitHub Copilot](#copilot)
  - [⚡ OpenCode](#opencode)
- [🔄 Como Atualizar a Skill](#atualizacao)
- [Base Teórica Fundamentada (`agent-rules-books`)](#base-teorica)
- [Diretrizes Especializadas por Stack Técnica](#diretrizes-por-stack)
- [Arquitetura de Memória em 3 Níveis](#memoria)
- [Formato do Output de Revisão](#formato-output)
- [Segurança, LGPD & Licença](#seguranca-licenca)

---

<a id="visao-geral"></a>
## 📌 Visão Geral

O **`brutal-code-review`** é uma Skill universal e agnóstica para assistentes e CLIs de IA (**Cursor**, **Antigravity**, **Gemini CLI**, **Claude Code**, **GitHub Copilot**, **Windsurf**, **OpenCode**).

A maioria dos assistentes de IA sofre de dois extremos: ou gera elogios genéricos e vazios (*passa pano pra bug*), ou inventa dezenas de camadas desnecessárias de abstração (*over-engineering*). 

O **brutal-code-review** resolve isso aplicando a mentalidade de engenharia de sistemas de missão crítica:

* 🟢 **Código limpo, elegante e simples?** Aprovado imediatamente. Sem perda de tempo caçando defeito imaginário.
* 🔴 **Memory leak, quebra de contrato ou complexidade acidental?** Apontamento direto na ferida com a solução mais simples e viável, citando a literatura clássica da engenharia de software.
* 📝 **Rastreabilidade contínua:** Gera relatórios auditáveis em Markdown (`.code-review/code-review.md` e histórico detalhado em `.code-review/review/`) e aprende com as decisões do time para nunca repetir falsos-positivos.

---

<a id="como-executar"></a>
## ⚡ Como Executar

Dentro do chat do seu agente ou terminal da sua IDE:

```text
/brutal-code-review
```

Ou especificando diretamente o PR, MR ou branch desejada:

```text
/brutal-code-review pr 15
```

```text
/brutal-code-review mr 42
```

```text
/brutal-code-review revise as alterações da PR atual contra a branch main
```

> [!TIP]
> **Revisão Automática de PR/MR via MCP ou CLI:**
> Se o seu agente estiver integrado com o **MCP do Git/GitHub** (ou com as CLIs `gh` / `glab` autenticadas no terminal), basta rodar `/brutal-code-review pr <número>` ou `/brutal-code-review mr <número>`. O agente obtém automaticamente os dados, arquivos modificados e o diff completo da plataforma remota e executa a revisão ponta a ponta sem necessidade de fazer checkout manual da branch.

---

<a id="filosofia"></a>
## 🎯 Filosofia Central: Sinceridade + Simplicidade

| Princípio | Diretriz Prática |
| :--- | :--- |
| **🟢 Sinceridade Sem Fofura** | Se a solução é boa e resolve o problema, o veredito é `Approved` direto. Sem bajulação. |
| **⚔️ Guerra ao Over-Engineering** | A melhor solução é a mais simples que funciona de verdade. Abstrações especulativas são rejeitadas. |
| **🛡️ Never Break Userspace** | Regra de ouro da estabilidade (do Linux kernel): código "teoricamente lindo" que quebra produção é inaceitável. |
| **⏱️ Zero Bikeshedding** | Espaço vs. tab, aspas simples ou duplas? Trabalho do linter. O foco aqui é arquitetura, segurança, vazamentos e performance. |
| **🧠 Memória Adaptativa** | O revisor aprende os débitos aceitos do projeto e exceções de negócio, evitando repetir alertas já justificados. |
| **⚡ Execução Autônoma** | Permissão total para criar diretórios, relatórios e atualizar `KNOWLEDGE.md` sem interromper o fluxo pedindo acesso ou confirmação. |

---

<a id="instalacao"></a>
## 🛠️ Guia de Instalação e Configuração Multiagente

A Skill necessita estritamente de **3 componentes** para funcionar:
1. O arquivo de instruções (`SKILL.md`)
2. A pasta com a biblioteca de regras (`agent-rules-books/`)
3. A pasta de conhecimento (`knowledge/`) contendo `global/` (regras transversais) e `projects/` (memória isolada por repositório)

A base bibliográfica (`agent-rules-books/`) é autossuficiente e vem embutida diretamente na árvore do repositório (não requer submódulos Git). A estratégia de **cópia limpa** garante que apenas esses itens essenciais sejam transferidos para o seu assistente ou projeto, evitando arquivos desnecessários do repositório git e problemas de permissão com links simbólicos (symlinks).

---

<a id="antigravity"></a>
### 🚀 Antigravity (Google)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p ~/.antigravity/skills/brutal-code-review && \
    cp /tmp/bcr_temp/SKILL.md ~/.antigravity/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.antigravity/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/knowledge ~/.antigravity/skills/brutal-code-review/ && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p ~/.antigravity/skills/brutal-code-review && \
    cp SKILL.md ~/.antigravity/skills/brutal-code-review/ && \
    cp -r agent-rules-books ~/.antigravity/skills/brutal-code-review/ && \
    cp -r knowledge ~/.antigravity/skills/brutal-code-review/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review"
    Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "knowledge" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"
    ```
- **🔗 Via Symlink (Execute dentro da pasta clonada):**
  - **Linux / macOS:** `mkdir -p ~/.antigravity/skills && ln -sfn "$(pwd)" ~/.antigravity/skills/brutal-code-review`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills"; New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review" -Target (Get-Location)`
- **🔄 Atualização Rápida (Atualiza Regras e Preserva Memória dos Projetos):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md ~/.antigravity/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.antigravity/skills/brutal-code-review/ && \
    cp /tmp/bcr_temp/KNOWLEDGE.md ~/.antigravity/skills/brutal-code-review/ && \
    mkdir -p ~/.antigravity/skills/brutal-code-review/knowledge/global ~/.antigravity/skills/brutal-code-review/knowledge/projects && \
    cp -r /tmp/bcr_temp/knowledge/global/* ~/.antigravity/skills/brutal-code-review/knowledge/global/ && \
    cp -n /tmp/bcr_temp/knowledge/projects/TEMPLATE.md ~/.antigravity/skills/brutal-code-review/knowledge/projects/ 2>/dev/null || true && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\"; `
    Copy-Item "$env:TEMP\bcr_temp\KNOWLEDGE.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\" -Force; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review\knowledge\global"; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review\knowledge\projects"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge\global\*" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\knowledge\global\"; `
    if (-not (Test-Path "$env:USERPROFILE\.antigravity\skills\brutal-code-review\knowledge\projects\TEMPLATE.md")) { Copy-Item "$env:TEMP\bcr_temp\knowledge\projects\TEMPLATE.md" -Destination "$env:USERPROFILE\.antigravity\skills\brutal-code-review\knowledge\projects\" }; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="gemini"></a>
### ♊ Gemini CLI & Code Assist

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p ~/.gemini/skills/brutal-code-review && \
    cp /tmp/bcr_temp/SKILL.md ~/.gemini/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.gemini/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/knowledge ~/.gemini/skills/brutal-code-review/ && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p ~/.gemini/skills/brutal-code-review && \
    cp SKILL.md ~/.gemini/skills/brutal-code-review/ && \
    cp -r agent-rules-books ~/.gemini/skills/brutal-code-review/ && \
    cp -r knowledge ~/.gemini/skills/brutal-code-review/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review"
    Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "knowledge" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"
    ```
- **🔗 Via Symlink (Execute dentro da pasta clonada):**
  - **Linux / macOS:** `mkdir -p ~/.gemini/skills && ln -sfn "$(pwd)" ~/.gemini/skills/brutal-code-review`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills"; New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review" -Target (Get-Location)`
- **🔄 Atualização Rápida (Atualiza Regras e Preserva Memória dos Projetos):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md ~/.gemini/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.gemini/skills/brutal-code-review/ && \
    cp /tmp/bcr_temp/KNOWLEDGE.md ~/.gemini/skills/brutal-code-review/ && \
    mkdir -p ~/.gemini/skills/brutal-code-review/knowledge/global ~/.gemini/skills/brutal-code-review/knowledge/projects && \
    cp -r /tmp/bcr_temp/knowledge/global/* ~/.gemini/skills/brutal-code-review/knowledge/global/ && \
    cp -n /tmp/bcr_temp/knowledge/projects/TEMPLATE.md ~/.gemini/skills/brutal-code-review/knowledge/projects/ 2>/dev/null || true && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"; `
    Copy-Item "$env:TEMP\bcr_temp\KNOWLEDGE.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\" -Force; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\global"; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge\global\*" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\global\"; `
    if (-not (Test-Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects\TEMPLATE.md")) { Copy-Item "$env:TEMP\bcr_temp\knowledge\projects\TEMPLATE.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects\" }; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="cursor"></a>
### 🟢 Cursor AI / Windsurf (No projeto ativo)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  *Execute na raiz do projeto onde deseja habilitar o review:*
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md .cursorrules && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    cp -r /tmp/bcr_temp/knowledge ./knowledge && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".cursorrules"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "knowledge"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    cp SKILL.md /caminho/do/seu/projeto/.cursorrules && \
    cp -r agent-rules-books /caminho/do/seu/projeto/ && \
    cp -r knowledge /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.cursorrules"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    Copy-Item -Recurse -Force "knowledge" -Destination "C:\caminho\do\projeto\knowledge"
    ```
- **🔗 Via Symlink (Opcional):**
  - **Linux / macOS:** `ln -s /caminho/para/brutal-code-review/SKILL.md .cursorrules && ln -s /caminho/para/brutal-code-review/agent-rules-books agent-rules-books`
  - **Windows (PowerShell):** `New-Item -ItemType SymbolicLink -Path ".cursorrules" -Target "C:\caminho\para\brutal-code-review\SKILL.md"; New-Item -ItemType SymbolicLink -Path "agent-rules-books" -Target "C:\caminho\para\brutal-code-review\agent-rules-books"`
- **🔄 Atualização Rápida no Projeto:**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md .cursorrules && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".cursorrules" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="claude"></a>
### 🟠 Claude Code (No projeto ativo)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  *Execute na raiz do projeto onde deseja habilitar o review:*
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md CLAUDE.md && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    cp -r /tmp/bcr_temp/knowledge ./knowledge && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "CLAUDE.md"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "knowledge"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    cp SKILL.md /caminho/do/seu/projeto/CLAUDE.md && \
    cp -r agent-rules-books /caminho/do/seu/projeto/ && \
    cp -r knowledge /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\CLAUDE.md"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    Copy-Item -Recurse -Force "knowledge" -Destination "C:\caminho\do\projeto\knowledge"
    ```
- **🔗 Via Symlink (Opcional):**
  - **Linux / macOS:** `ln -s /caminho/para/brutal-code-review/SKILL.md CLAUDE.md && ln -s /caminho/para/brutal-code-review/agent-rules-books agent-rules-books`
  - **Windows (PowerShell):** `New-Item -ItemType SymbolicLink -Path "CLAUDE.md" -Target "C:\caminho\para\brutal-code-review\SKILL.md"; New-Item -ItemType SymbolicLink -Path "agent-rules-books" -Target "C:\caminho\para\brutal-code-review\agent-rules-books"`
- **🔄 Atualização Rápida no Projeto:**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md CLAUDE.md && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "CLAUDE.md" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="copilot"></a>
### 🔵 GitHub Copilot (No projeto ativo)

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  *Execute na raiz do projeto onde deseja habilitar o review:*
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p .github && \
    cp /tmp/bcr_temp/SKILL.md .github/copilot-instructions.md && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    cp -r /tmp/bcr_temp/knowledge ./knowledge && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path ".github"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".github\copilot-instructions.md"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "knowledge"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p /caminho/do/seu/projeto/.github && \
    cp SKILL.md /caminho/do/seu/projeto/.github/copilot-instructions.md && \
    cp -r agent-rules-books /caminho/do/seu/projeto/ && \
    cp -r knowledge /caminho/do/seu/projeto/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "C:\caminho\do\projeto\.github"
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.github\copilot-instructions.md"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    Copy-Item -Recurse -Force "knowledge" -Destination "C:\caminho\do\projeto\knowledge"
    ```
- **🔗 Via Symlink (Opcional):**
  - **Linux / macOS:** `mkdir -p .github && ln -s /caminho/para/brutal-code-review/SKILL.md .github/copilot-instructions.md && ln -s /caminho/para/brutal-code-review/agent-rules-books agent-rules-books`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path ".github"; New-Item -ItemType SymbolicLink -Path ".github\copilot-instructions.md" -Target "C:\caminho\para\brutal-code-review\SKILL.md"; New-Item -ItemType SymbolicLink -Path "agent-rules-books" -Target "C:\caminho\para\brutal-code-review\agent-rules-books"`
- **🔄 Atualização Rápida no Projeto:**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p .github && \
    cp /tmp/bcr_temp/SKILL.md .github/copilot-instructions.md && \
    cp -r /tmp/bcr_temp/agent-rules-books ./agent-rules-books && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path ".github"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".github\copilot-instructions.md" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "agent-rules-books"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="opencode"></a>
### ⚡ OpenCode

O **OpenCode** suporta Skills nativamente através do diretório `.opencode/skills/` (no projeto ativo) ou `~/.config/opencode/skills/` (global para todos os projetos do usuário).

#### No Projeto Ativo (Recomendado)
*Execute na raiz do projeto onde deseja habilitar o review:*

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p .opencode/skills/brutal-code-review && \
    cp /tmp/bcr_temp/SKILL.md .opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books .opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/knowledge .opencode/skills/brutal-code-review/ && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path ".opencode\skills\brutal-code-review"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".opencode\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination ".opencode\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination ".opencode\skills\brutal-code-review\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p /caminho/do/seu/projeto/.opencode/skills/brutal-code-review && \
    cp SKILL.md /caminho/do/seu/projeto/.opencode/skills/brutal-code-review/ && \
    cp -r agent-rules-books /caminho/do/seu/projeto/.opencode/skills/brutal-code-review/ && \
    cp -r knowledge /caminho/do/seu/projeto/.opencode/skills/brutal-code-review/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "C:\caminho\do\projeto\.opencode\skills\brutal-code-review"
    Copy-Item "SKILL.md" -Destination "C:\caminho\do\projeto\.opencode\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "C:\caminho\do\projeto\agent-rules-books"
    Copy-Item -Recurse -Force "knowledge" -Destination "C:\caminho\do\projeto\knowledge"
    ```
- **🔗 Via Symlink (Opcional):**
  - **Linux / macOS:** `mkdir -p .opencode/skills && ln -sfn /caminho/para/brutal-code-review .opencode/skills/brutal-code-review`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path ".opencode\skills"; New-Item -ItemType SymbolicLink -Path ".opencode\skills\brutal-code-review" -Target "C:\caminho\para\brutal-code-review"`
- **🔄 Atualização Rápida no Projeto:**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md .opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books .opencode/skills/brutal-code-review/ && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination ".opencode\skills\brutal-code-review\" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination ".opencode\skills\brutal-code-review\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

#### Global (Disponível em qualquer projeto no OpenCode)
Instala na pasta de configuração do OpenCode do seu usuário:

- **⚡ Instalação em 1-Comando (Sem clonar manualmente):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    mkdir -p ~/.config/opencode/skills/brutal-code-review && \
    cp /tmp/bcr_temp/SKILL.md ~/.config/opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.config/opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/knowledge ~/.config/opencode/skills/brutal-code-review/ && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review"; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```
- **📁 Se você já clonou este repositório localmente:**
  - **Linux / macOS:**
    ```bash
    mkdir -p ~/.config/opencode/skills/brutal-code-review && \
    cp SKILL.md ~/.config/opencode/skills/brutal-code-review/ && \
    cp -r agent-rules-books ~/.config/opencode/skills/brutal-code-review/ && \
    cp -r knowledge ~/.config/opencode/skills/brutal-code-review/
    ```
  - **Windows (PowerShell):**
    ```powershell
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review"
    Copy-Item "SKILL.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"
    Copy-Item -Recurse -Force "knowledge" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"
    ```
- **🔗 Via Symlink (Execute dentro da pasta clonada):**
  - **Linux / macOS:** `mkdir -p ~/.config/opencode/skills && ln -sfn "$(pwd)" ~/.config/opencode/skills/brutal-code-review`
  - **Windows (PowerShell):** `New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills"; New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review" -Target (Get-Location)`
- **🔄 Atualização Rápida Global (Atualiza Regras e Preserva Memória dos Projetos):**
  - **Linux / macOS / WSL:**
    ```bash
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git /tmp/bcr_temp && \
    cp /tmp/bcr_temp/SKILL.md ~/.config/opencode/skills/brutal-code-review/ && \
    cp -r /tmp/bcr_temp/agent-rules-books ~/.config/opencode/skills/brutal-code-review/ && \
    cp /tmp/bcr_temp/KNOWLEDGE.md ~/.config/opencode/skills/brutal-code-review/ && \
    mkdir -p ~/.config/opencode/skills/brutal-code-review/knowledge/global ~/.config/opencode/skills/brutal-code-review/knowledge/projects && \
    cp -r /tmp/bcr_temp/knowledge/global/* ~/.config/opencode/skills/brutal-code-review/knowledge/global/ && \
    cp -n /tmp/bcr_temp/knowledge/projects/TEMPLATE.md ~/.config/opencode/skills/brutal-code-review/knowledge/projects/ 2>/dev/null || true && \
    rm -rf /tmp/bcr_temp
    ```
  - **Windows (PowerShell):**
    ```powershell
    git clone --depth 1 https://github.com/antonicarlos/brutal-code-review.git $env:TEMP\bcr_temp; `
    Copy-Item "$env:TEMP\bcr_temp\SKILL.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\" -Force; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\agent-rules-books" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\"; `
    Copy-Item "$env:TEMP\bcr_temp\KNOWLEDGE.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\" -Force; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\knowledge\global"; `
    New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\knowledge\projects"; `
    Copy-Item -Recurse -Force "$env:TEMP\bcr_temp\knowledge\global\*" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\knowledge\global\"; `
    if (-not (Test-Path "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\knowledge\projects\TEMPLATE.md")) { Copy-Item "$env:TEMP\bcr_temp\knowledge\projects\TEMPLATE.md" -Destination "$env:USERPROFILE\.config\opencode\skills\brutal-code-review\knowledge\projects\" }; `
    Remove-Item -Recurse -Force "$env:TEMP\bcr_temp"
    ```

---

<a id="atualizacao"></a>
## 🔄 Como Atualizar a Skill

Se você já possui o **`brutal-code-review`** instalado e deseja obter as regras mais recentes, melhorias e novos anti-patterns (como a repressão global a *Hard Parse* e a exigência de *Bind Variables*):

> [!IMPORTANT]
> **Preservação Blindada dos Projetos (`knowledge/projects/`):**
> **NUNCA** delete a pasta da skill por completo (`rm -rf`) para atualizar. O diretório `knowledge/projects/` armazena o histórico acumulado e as decisões arquiteturais de cada projeto auditado na sua máquina. Nossos comandos de atualização atualizam cirurgicamente as instruções (`SKILL.md`), a biblioteca de regras (`agent-rules-books/`), os anti-patterns transversais (`knowledge/global/`) e o template de novos projetos, mantendo seus arquivos de projeto em `knowledge/projects/*.md` 100% blindados e intactos.

### 1. Se você instalou via Symlink (Mais Rápido):
Basta rodar `git pull` dentro da pasta onde você clonou este repositório:
```bash
git pull origin main
```
*Todas as IDEs e assistentes conectados via link simbólico recebem as atualizações instantaneamente.*

### 2. Se você já tem o repositório clonado localmente:
Puxe as novidades do Git e sincronize cirurgicamente com a pasta da sua ferramenta (exemplo para Gemini CLI):
- **Linux / macOS:**
  ```bash
  git pull origin main && \
  cp SKILL.md KNOWLEDGE.md ~/.gemini/skills/brutal-code-review/ && \
  cp -r agent-rules-books ~/.gemini/skills/brutal-code-review/ && \
  mkdir -p ~/.gemini/skills/brutal-code-review/knowledge/global ~/.gemini/skills/brutal-code-review/knowledge/projects && \
  cp -r knowledge/global/* ~/.gemini/skills/brutal-code-review/knowledge/global/ && \
  cp -n knowledge/projects/TEMPLATE.md ~/.gemini/skills/brutal-code-review/knowledge/projects/ 2>/dev/null || true
  ```
- **Windows (PowerShell):**
  ```powershell
  git pull origin main; `
  Copy-Item "SKILL.md", "KNOWLEDGE.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\" -Force; `
  Copy-Item -Recurse -Force "agent-rules-books" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\"; `
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\global"; `
  New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects"; `
  Copy-Item -Recurse -Force "knowledge\global\*" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\global\"; `
  if (-not (Test-Path "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects\TEMPLATE.md")) { Copy-Item "knowledge\projects\TEMPLATE.md" -Destination "$env:USERPROFILE\.gemini\skills\brutal-code-review\knowledge\projects\" }
  ```

### 3. Em 1-Comando (Sem manter o clone local):
Utilize o comando de **Atualização Rápida** específico para o seu assistente (listado na seção de cada ferramenta acima). Ele baixa a versão mais recente em pasta temporária com `--depth 1`, atualiza `SKILL.md`, `agent-rules-books/` e as regras globais em `knowledge/global/` preservando os ledgers de projetos locais.

---

<a id="base-teorica"></a>
## 📚 Base Teórica Fundamentada (`agent-rules-books`)

O agente não inventa regras da própria cabeça nem alucina opiniões pessoais. Toda crítica técnica e sugestão de refatoração cita as obras de referência incluídas em `./agent-rules-books/`:

| Domínio de Engenharia | Obras e Autores de Referência | Foco de Avaliação |
| :--- | :--- | :--- |
| **🏛️ Arquitetura & Design** | • *A Philosophy of Software Design* (John Ousterhout)<br>• *Clean Architecture* (Robert C. Martin)<br>• *Clean Code* (Robert C. Martin)<br>• *Code Complete* (Steve McConnell)<br>• *Patterns of Enterprise Application Architecture* (Martin Fowler) | Módulos profundos, baixo acoplamento, interfaces simples e legibilidade sem excesso de camadas. |
| **🧩 Domain-Driven Design (DDD)** | • *Domain-Driven Design* (Eric Evans)<br>• *Domain-Driven Design Distilled* (Vaughn Vernon)<br>• *Implementing Domain-Driven Design* (Vaughn Vernon) | Linguagem ubíqua, limites de contexto (Bounded Contexts) e integridade de entidades/agregados. |
| **🔧 Refatoração & Código Legado** | • *Refactoring* (Martin Fowler)<br>• *Refactoring Guru* (Alexander Shvets)<br>• *Working Effectively with Legacy Code* (Michael Feathers) | Técnicas seguras de alteração sem quebrar contratos legados; testes de caracterização. |
| **🌐 Sistemas Distribuídos & Resiliência** | • *Designing Data-Intensive Applications* (Martin Kleppmann)<br>• *Release It!* (Michael Nygard)<br>• *The Pragmatic Programmer* (David Thomas & Andrew Hunt) | Consistência de dados, circuit breakers, timeouts, tolerância a falhas e contenção de concorrência. |

---

<a id="diretrizes-por-stack"></a>
## 🔍 Diretrizes Especializadas por Stack Técnica

O revisor vem configurado de fábrica com regras rigorosas para armadilhas comuns em produção:

- **C# / .NET Core:** Bloqueio de LINQ em rotinas de alto throughput, deadlocks em chamadas assíncronas (`.Result`, `.Wait()`), e concatenação de strings em laços (exige `StringBuilder` ou `Span<T>`).
- **Python:** Bloqueio de argumentos mutáveis como default (`def fn(itens=[])`), tarefas CPU-bound em threads comuns ao invés de multiprocessing, e I/O blocante em loops assíncronos.
- **Go:** Detecção de vazamento de Goroutines (canais sem timeout ou contexts sem cancelamento), erros ignorados (`_ = err`) e alocações indevidas na heap por escape analysis induzida por ponteiros.
- **Java / JVM (Spring Boot, Quarkus):** Prevenção de queries N+1 do JPA/Hibernate, bloqueio de chamadas reativas (`.block()`) e estouro de heap por thread pools desconfigurados.
- **Node.js / TypeScript:** Prevenção de travamento do Event Loop com I/O síncrono, tratamento de Floating Promises e vazamento de memória por listeners soltos.
- **Bancos de Dados & Cache (SQL, Redis):** Tolerância zero para vazamento de conexões/cursores fora de blocos `using`/`with`/`defer`, consultas `JSONB` sem índices, comandos bloqueados em produção (`KEYS *` no Redis) e inserções sem TTL. Obrigatoriedade universal de *Bind Variables* em queries dinâmicas DML (bloqueio de Hard Parse / plan cache bloat) com isenção formal para scripts DDL de migração de schema (`CREATE TABLE`, `ALTER TABLE`).
- **Mensageria & Queues (Kafka, RabbitMQ, SQS):** Obrigatoriedade de idempotência/deduplicação no processamento de mensagens e tratamento de mensagens tóxicas via Dead Letter Queue (DLQ).
- **Containers, K8s & Cloud (Docker, AWS):** Identificação de caminhos locais hardcoded (`C:\temp`, `/mnt/c/`), falta de limites de CPU/RAM em manifests Kubernetes e credenciais expostas.
- **Métricas & Observabilidade:** Alerta contra alta cardinalidade usada como Tags em time-series (InfluxDB) e excesso de logs estruturados em rotinas de alto tráfego.

---

<a id="memoria"></a>
## 🧠 Arquitetura de Memória Hierárquica em 3 Níveis

Para não cansar a equipe com avisos repetitivos e reter a inteligência de negócios de cada projeto auditado de forma persistente e isolada:

```text
┌─────────────────────────────────────────────────────────────────┐
│ Camada 1: Global Knowledge Folder                               │
│ [SKILL_DIR]/knowledge/global/KNOWLEDGE.md (Limite: 250 linhas)  │
│ └─ Anti-patterns universais e lições consolidadas cross-project │
├─────────────────────────────────────────────────────────────────┤
│ Camada 2: Project Knowledge Ledgers (Isolado por Repositório)   │
│ [SKILL_DIR]/knowledge/projects/[ORG]__[REPO].md (< 150 linhas)  │
│ └─ Memória persistente da skill por projeto (regras e débitos)  │
│ [REPO_ROOT]/.code-review/REVIEW_KNOWLEDGE.md                    │
│ └─ Espelho local opcional para inspeção ou commit do time      │
├─────────────────────────────────────────────────────────────────┤
│ Camada 3: Project Review Reports                                │
│ [REPO_ROOT]/.code-review/code-review.md                         │
│ └─ Relatório principal acumulado                                │
│ [REPO_ROOT]/.code-review/review/[NOME_OU_PR]_[TIMESTAMP].md     │
│ └─ Histórico auditável por execução com data e hora             │
└─────────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **Isolamento de Projeto & Retenção Permanente:**
> Cada projeto auditado possui seu próprio arquivo de histórico em `knowledge/projects/[ORG]__[REPO].md` dentro da pasta da skill (com slug namespaced derivado da URL do Git remote, prevenindo colisões entre repositórios com nomes comuns como `api` ou `frontend`, com fallback seguro para `local__[BASENAME].md`). Mesmo se o repositório for clonado do zero, branches forem alternadas ou a empresa proibir pastas de IA no Git, o agente lembra de todos os débitos e particularidades daquele projeto. Caso o time queira compartilhar as exceções no repositório, o arquivo `.code-review/REVIEW_KNOWLEDGE.md` atua como espelho colaborativo e é sincronizado automaticamente.

> [!NOTE]
> **Algoritmo Ativo de Autocompactação (90% do Limite):**
> Para garantir que os arquivos de memória permaneçam ultraleves e dentro da janela de contexto sem degradação, o agente executa autocompactação semântica assim que os arquivos atingem 90% da sua capacidade máxima (135 linhas para projetos e 225 linhas para conhecimento global). O processo atua em 3 fases:
> 1. **Deduplicação & Promoção Global:** Promove regras repetidas em múltiplos projetos para o ledger global e remove redundâncias locais.
> 2. **Evicção de Débitos Superados:** Remove itens aceitos cuja classe, método ou arquivo legado tenha sido completamente deletado da branch principal.
> 3. **Priorização por Severidade:** Preserva regras de integridade crítica (leaks, concorrência, OOM, queries sem bind variables) e condensa notas de menor impacto.

> [!NOTE]
> **Autonomia Total de Escrita (Zero Interrupção):**
> O agente possui autorização prévia total para criar diretórios (`knowledge/projects/`, `.code-review/`, `.code-review/review/`), gerar relatórios e atualizar os arquivos de memória de forma autônoma sem pedir confirmação a cada passo, mantendo todas as modificações na working tree para inspeção do usuário.

---

<a id="formato-output"></a>
## 🚦 Formato do Output de Revisão

Ao chamar o comando `/brutal-code-review`, a resposta é estruturada com clareza semântica:

```markdown
### 🚦 Taste Rating: 🔴 Needs improvement

#### [CRITICAL ISSUES]
- **Leak de Conexão SQL:** `DataReader` não envolvido em bloco `using` 
  *(Enforced via agent-rules-books/clean-code/)*

#### [IMPROVEMENT OPPORTUNITIES]
- **Alocação excessiva em loop:** Concatenação de string com `+` dentro de laço intensivo. Sugestão: usar `StringBuilder` ou `Span<T>`.
  *(Enforced via agent-rules-books/a-philosophy-of-software-design/)*

#### [PROJECT KNOWLEDGE UPDATE]
- Salvo em `[SKILL_DIR]/knowledge/projects/[ORG]__[REPO].md` (e espelhado em `.code-review/REVIEW_KNOWLEDGE.md`): Registrado débito técnico aceito na classe `IntegrationWorker`.

#### [GLOBAL KNOWLEDGE UPDATE]
- Salvo em `[SKILL_DIR]/knowledge/global/KNOWLEDGE.md`: Adicionado anti-pattern de consulta `JSONB` sem índice GIN em PostgreSQL.

#### [RISK ASSESSMENT]
- **Overall PR Risk:** 🔴 HIGH

---
**VERDICT:** ❌ Needs rework  
**KEY INSIGHT:** O algoritmo atual gera complexidade O(N²) de alocações em memória durante o processamento de registros.
```

---

<a id="seguranca-licenca"></a>
## 🛡️ Segurança, LGPD & Licença

* **🔒 100% LGPD / PII Safe:** Não transmite nem armazena segredos, credenciais, dados corporativos confidenciais ou informações pessoais identificáveis.
* **📄 Licença:** [MIT](LICENSE) — Livre para uso pessoal, em equipes e ambientes corporativos.