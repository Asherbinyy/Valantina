# docs/PROJECT_RULES.md
# PROJECT RULES — Prevent Scope Creep (AI must obey)

## 1) Scope guardrails
- One level only.
- One mechanic: tap to jump.
- Any proposed feature must improve:
  (a) clarity, (b) cuteness, (c) polish, or (d) stability.
- If not, reject it.

## 2) Architecture guardrails
- Game logic must be isolated from Flutter UI overlays.
- State machine must match docs/FLOWCHART.md.
- All tuning values centralized (speed, jump force, gravity, checkpoint positions).

## 3) Art & UX guardrails
- Do not mix art packs with different pixel scales.
- Text must be readable on phones.
- Hitboxes slightly smaller than sprites (for fairness).

## 4) Restart behavior (must be correct)
Restart resets:
- state → START_MENU
- hearts/score → 0
- checkpoint index → 0
- player position/velocity → initial
- camera → initial
- particles/overlays → cleared
- audio continues unless muted

## 5) Documentation discipline
If you change behavior:
- Update docs/GAME_SPEC.md and docs/FLOWCHART.md.
  If you add dependencies:
- Update docs/TECH_STACK.md.
  If you add assets:
- Update docs/ASSETS.md and docs/CREDITS.md.
