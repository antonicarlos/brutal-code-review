---
name: ponytail-review
description: >
  Optional second review pass (strict opt-in): logic correctness, safety,
  real-load behavior, missing tests for risky code, big slowdowns and lines
  that should not exist. Runs over the same scope already reviewed by the
  main brutal-code-review flow and appends its findings as a separate
  "Ponytail Pass" section of the main report.
---

<!--
  Vendored from the ponytail plugin (https://github.com/DietrichGebert/ponytail),
  skills/ponytail-review/SKILL.md, MIT License — Copyright (c) 2026 DietrichGebert.
  See ./LICENSE in this folder. Adapted for the brutal-code-review flow: same
  scope as the main review, output merged into the main report instead of
  standalone.
-->

Review the change like the senior developer who will be paged when it breaks.
Order of importance: correct, safe, holds under load, tested, fast, lean.
Lean still matters: every extra line must be read, tested and fixed later.
This is a report the user asked for, so give it in full.

## 0. Scope (adapted for brutal-code-review)

- Review the SAME scope the main review already covered: the diff, PR, branch
  or files resolved by the main flow. Do not re-discover scope and do not
  re-report findings the main review already made.
- Read the diff, then the code it touches: callers of every changed function,
  the functions it calls, the tests, the README.
- Trace the real flow: where data comes in, what is stored, what goes out.
- A change can break code it does not touch. When a signature, return value
  or behavior changes, grep every caller.
- Find the expected load in the repo (README, deploy config): one person
  running a script, or many users and processes at once. Judge scale against
  that, and say which load you assumed.
- Respect the project memory suppression ledger (Section 2 "Accepted
  Exceptions & Known Debts" of the project knowledge file): accepted debts are
  decisions, not findings.

## 1. Look for

1. **Bug:** wrong result, crash, missed edge case (empty, zero, last item,
   rounding, time zones), a caller broken by the change, a fix applied in one
   caller while the shared function stays broken.
2. **Risk:** security holes (injection, weak randomness, secrets, missing
   checks on input from users), data loss (errors swallowed, writes in the
   wrong order, no transaction).
3. **Scale:** fine for one user, wrong for many: check-then-write races, the
   same work done by every process, memory or lists that only grow, a query
   per item, O(n^2) on big input, per-process state that must be shared.
4. **Missing test:** risky new logic (a branch, a parser, money, security,
   data writes, a bug fix) with no test that fails when it breaks. One good
   test, not coverage.
5. **Speed:** big slowdowns are problems. Small wins (work repeated in a hot
   loop) are suggestions; some software counts every millisecond.
6. **Lean:** code that should not exist or should be smaller.
   - delete: dead code, unused options, speculative features
   - reuse: the repo already has this helper (name the path)
   - stdlib / native: the standard library or platform already does it; a
     new dependency for a few lines
   - yagni: abstraction with one implementation, config nobody sets
   - merge: near-copies that must change together
   - split: one function doing several unrelated jobs, so it is hard to read
     or test. Split by job, never by line count, and never into helpers that
     exist only to make a function shorter.

## 2. Check before you report

- Every finding needs a concrete case: "this input or situation leads to this
  wrong result". No case, no finding.
- Re-read the lines and confirm: the caller exists, the value can really be
  empty, the code really is unused.
- A shortcut marked with a `shortcut:` (or older `ponytail:`) comment that
  names its limit is a decision, not a finding, unless the expected load
  already crosses it.
- Propose the smallest fix that works. Prefer fixes that delete code. Never
  add layers, frameworks or config the problem does not need.
- No style taste, no "consider", no vague worries.

## 3. Output (merged into the main report)

Do NOT write a standalone report. Append the section below at the END of the
main report files (`[REPO_ROOT]/.code-review/code-review.md` and the
timestamped history file created by the POST-REVIEW PROTOCOL):

```markdown
## Ponytail Pass
<output below, verbatim>
```

LANGUAGE: the `## Ponytail Pass` section MUST be written in the same language
as the rest of the main report. This skill ships inside brutal-code-review,
whose reports are in Portuguese (pt-BR) — write in pt-BR unless the report
clearly says otherwise. All fixed labels below are already in pt-BR: use them
as-is.

Simple language: short sentences, everyday words. Explain a technical term
the first time you use it. The reader may never have seen this code.

Start with `O que esta mudança faz:` in two or three sentences.

Then the findings in three groups, skip empty groups:
- **Correção obrigatória:** bug, segurança, perda de dados, quebra na carga esperada.
- **Deveria corrigir:** código arriscado sem teste, lentidão real, duplicação,
  função que mistura responsabilidades, código que não deveria existir.
- **Opcional:** pequenas otimizações, formas mais curtas.

Number findings across all groups, so the user can say "corrige 2 e 5".
Every finding has all four parts, each one or two short sentences:

2. **Pedidos caem no dia errado** (`billing/close_day.py:L40-52`)
   - **O que é:** À meia-noite este job fecha o dia e cobra todos os pedidos daquele dia.
   - **Problema:** Ele pega "hoje" do relógio do servidor, que roda em UTC. Um pedido feito
     às 00:30 em Berlim é cobrado no dia anterior.
   - **Correção:** Calcular o dia uma vez, no fuso da loja:
     `datetime.now(ZoneInfo("Europe/Berlin")).date()`. Uma linha, nada mais muda.
   - **Se ignorarmos:** Pedidos tardes mostram a data errada, e o financeiro corrige na mão.

End with:
- `Veredito: pode subir.` or `Veredito: corrija 1 e 3 antes.`
- `Enxugamento: é possível remover <N> linhas.` when lean findings exist.
- `Não verificado:` one line, if something mattered and you could not check it.

Nothing found: `O que esta mudança faz:`, then `Sem problemas. Pode subir.` and
one line on what you checked.

The pass is read-only: it changes no code and writes no knowledge files.
Its findings are report-only.
