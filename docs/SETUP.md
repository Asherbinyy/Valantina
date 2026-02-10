# docs/SETUP.md
# SETUP — Flutter 3.38.9 (FVM), Project Bootstrap, Pre-Prompt Checklist

## Prereqs
- FVM installed and working
- Flutter version pinned to 3.38.9 (do not deviate)

## Pin Flutter version
1) In repo root, ensure .fvmrc exists with:
   { "flutter": "3.38.9" }

2) Run:
   fvm use 3.38.9

3) Always run Flutter via:
   fvm flutter <command>

## Create project (if new)
- fvm flutter create run_to_love
- cd run_to_love

## Add assets before prompting AI
Create folders (exact names):
- assets/sprites/
- assets/tiles/
- assets/ui/
- assets/audio/
- assets/fonts/
- docs/

Add placeholder files so AI doesn’t invent paths:
- assets/sprites/_PLACEHOLDER.txt
- assets/audio/_PLACEHOLDER.txt
- etc.

## Add docs
Copy all files in /docs from this chat into your repo.

## Add fonts approach (choose one, be consistent)
Option A (simplest): google_fonts package (no font files)
Option B (offline guarantee): download font files and add to assets/fonts + pubspec

Press Start 2P + VT323 are on Google Fonts. :contentReference[oaicite:10]{index=10}

## Pre-prompt checklist (before asking AI to implement)
- [ ] docs/AI_CONTEXT.md present
- [ ] docs/GAME_SPEC.md present
- [ ] docs/DESIGN_TOKENS.md present
- [ ] Assets chosen and placed (at least placeholders)
- [ ] You have decided tile size: 16px OR 32px (write it into docs/LEVEL_DATA.md)
- [ ] You have written your final “Coupon unlocked” plan (docs/COPY.md)

## Post-prompt checklist (after AI proposes changes)
- [ ] Any new dependency is documented in docs/TECH_STACK.md
- [ ] Any new state is added to docs/FLOWCHART.md
- [ ] Any new asset path is added to docs/ASSETS.md
- [ ] No out-of-scope features slipped in
