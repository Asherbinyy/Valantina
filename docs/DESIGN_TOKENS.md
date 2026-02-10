
---

```md
# docs/DESIGN_TOKENS.md
# DESIGN TOKENS — Colors, Fonts, Sizes, UI

## Style lane
Pixel-cute, warm romantic. Consistent tile scale. No mixed art styles.

## Fonts (two max)
- Headings: Press Start 2P (Google Fonts) :contentReference[oaicite:0]{index=0}
- Body/dialogue: VT323 (Google Fonts) :contentReference[oaicite:1]{index=1}

Fallbacks:
- monospace (for body), sans-serif (for headings) if fonts fail.

## Color palette (fixed)
Background gradient:
- BG_TOP:  #FFD1DC  (soft pink)
- BG_MID:  #FFB3C7  (rose)
- BG_BOT:  #FFE7B3  (warm peach)

UI / text:
- INK:     #2B2233  (dark plum)
- CARD:    #FFF6FB  (near-white pink)
- OUTLINE: #2B2233  (same as INK, pixel outline)
- YES:     #FF4D8D  (hot pink)
- YES_HI:  #FF7FB0  (hover/shine)
- RESTART: #6B5B7A  (muted purple)
- HEART:   #FF2D6F  (pickup)

Hazards:
- HAZARD:  #2B2233  (keep readable)

## UI layout rules (mobile first)
- Safe padding: 16px edges (min)
- Buttons: 48px minimum height
- Hit targets: min 44x44

## Text sizing (recommended)
- Title (Press Start 2P): 22–26sp
- Prompt heading: 18–22sp
- Body (VT323): 22–26sp (VT323 looks best larger)
- Micro-notes: 22–24sp

## UI animation “juice” checklist
(Use subtle durations, avoid flashy chaos)
- Button bounce on press
- Heart pickup pop (scale→fade)
- Landing squash (tiny scaleY)
- Bonk: brief shake + blink
- Cutscene: fade in + typewriter text
- Confetti burst on YES

Recommended libs:
- flutter_animate for widget/UI effects :contentReference[oaicite:2]{index=2}
- confetti for celebration overlay :contentReference[oaicite:3]{index=3}
