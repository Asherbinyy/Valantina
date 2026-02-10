# docs/AI_CONTEXT.md
# Run to Love 💗 — Single Source of Truth (AI Context)

You are helping implement a tiny pixel platformer Valentine game in Flutter using Flame.

## Non-negotiables (read carefully)
- One level only. 30–60 seconds.
- One input only: tap/click = jump.
- No feature creep. Add “polish/juice” over new systems.
- Must be mobile-friendly (touch) and work on Flutter Web.
- Failure is forgiving: no “death screen”; on hit -> bonk -> reset to last checkpoint.
- Provide a Restart button (always available in pause overlay + end screen).

## Flutter / tooling
- Use FVM, Flutter version: 3.38.9 (do not assume any other version).
- Do NOT change architecture without updating docs.

## What you must produce when you propose changes
- Explain which doc section it touches (by filename + heading).
- Keep implementation aligned with docs/GAME_SPEC.md and docs/PROJECT_RULES.md.
- If you’re unsure, ask for clarification OR propose the smallest safe default.

## Hard constraints
- Two fonts max (see docs/DESIGN_TOKENS.md).
- Color palette fixed (see docs/DESIGN_TOKENS.md).
- Asset style must be consistent (pixel; consistent tile size).
- Credits & licenses must be recorded (docs/CREDITS_TEMPLATE.md).

## Deliverables checklist (definition of done)
See docs/ACCEPTANCE_CRITERIA.md.
