# docs/GAME_SPEC.md
# GAME SPEC — Run to Love 💗 (Pixel Cat Auto-Runner)

## 1) Pitch
A 30–60 second pixel platformer where a tiny cat auto-runs, you tap to jump, collect hearts and micro-notes, and reach Queen Cat at the end. The finish triggers a short cutscene and the question: “Will you be my Valentine?” → Yes triggers confetti + final message + date coupon.

## 2) Target platform
- Flutter Web first (touch + mouse).
- Portrait preferred; must not break in landscape.
- Offline after first load (assets bundled).

## 3) Core loop
Start Screen → Gameplay → Finish Trigger → End Cutscene → Valentine Prompt → Celebration Screen

## 4) Controls
- Tap/click/spacebar: Jump (single tap = normal jump)
- Double tap within 300ms: Boost jump (higher; works retroactively in early ascent)
- No other controls in v1.

## 5) Game states
- BOOT (preload assets)
- START_MENU
- PLAYING
- PAUSED (overlay)
- HIT_RECOVERY (brief bonk + camera shake)
- FINISH_CUTSCENE
- VALENTINE_PROMPT
- CELEBRATION
- RESTARTING (reset world)

## 6) Level: single timeline (distance-based or time-based)
Total: 30–60 seconds.

### Beat plan (recommended)
- Beat 0 (0–5s): Safe runway + 2 hearts (teach collect)
- Beat 1 (5–15s): 1 small obstacle + Note #1
- Beat 2 (15–30s): 2 obstacles, spaced fairly + 5 hearts
- Beat 3 (30–45s): slightly tighter rhythm + Note #2
- Beat 4 (finish): calm runway, sparkle trail → Queen Cat

### Obstacles (max 3 types)
- Low spike (jump once)
- Small gap (jump once)
- Moving “bad vibe” puff (slow, avoidable) OR replace with static hazard for simplicity

## 7) Failure handling (forgiving)
On collision:
- Enter HIT_RECOVERY for 0.6–1.0s
- Play bonk animation + subtle camera shake + short SFX
- Reset player to last checkpoint (or small distance behind checkpoint)
- Do NOT show a “Game Over” screen

## 8) Checkpoints
- CP1 at ~15s
- CP2 at ~30s
- CP3 at ~45s (optional if level is long)

## 9) Collectibles
- Hearts: 10–20 total
- Each heart triggers:
    - pop animation (scale up then fade)
    - “ting” SFX
- Optional: heart counter displayed top-left (small)

## 10) Micro-notes (text moments)
Triggered at checkpoints or fixed positions.
- Note #1: “You make ordinary days feel special.”
- Note #2: “I’d jump any obstacle for you.”
- Note #3 (near finish): “Almost there…”

Rules:
- One line only.
- Typewriter reveal (fast, subtle).
- Auto-hide after 2–3s.

## 11) Finish sequence
Finish trigger:
- Disable hazards/collisions
- Slow down run speed slightly
- Camera pans to Queen Cat
- Heart particles rise for 2–3s
- Show: “I found you 💖”
- Transition to Valentine prompt

## 12) Valentine prompt
Overlay panel centered:
- Text: “Will you be my Valentine? 💖”
- Buttons:
    - YES (primary)
    - Restart (secondary)
    - Optional: Sound toggle icon

YES → celebration state.

## 13) Celebration screen
- Confetti burst
- Message:
    - “YAY!! 🎉”
    - “Happy Valentine’s Day, my love.”
    - “Coupon unlocked: <YOUR PLAN>”
- Buttons:
    - Restart
    - (Optional) “Take a screenshot 📸” (no platform API; just text suggestion)

## 14) Pause overlay (must have Restart)
Pause overlay shows during PLAYING:
- Resume
- Restart
- Sound on/off

## 15) Out of scope (v1)
- Multiple levels
- Enemies with AI
- Physics engine complexity
- Saves / accounts / leaderboards
