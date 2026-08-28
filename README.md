# Run to Love 💗

A cute Valentine's Day platformer game built with **Flutter** & **Flame Engine**. Run, jump, collect hearts, and find your love! 🐰💝


## ✨ Features

- 🐰 **Adorable bunny characters** — sprite-based player & queen with walk/jump/hurt animations
- 💖 **Collect hearts** — 14 hearts at varied heights (ground, low, high, boost jumps)
- 🦇 **Dodge obstacles** — spikes on the ground & flying bats
- 🕳️ **Gap jumping** — leap over gaps with precise timing
- 🎵 **Full audio** — background music, jump SFX, collect sounds, hit feedback, and a celebration jingle
- 🎉 **Confetti celebration** — colorful particle burst when you win
- 💌 **Valentine's message** — cutscene dialog, a Valentine's prompt, and a surprise coupon
- 📱 **Responsive** — works on mobile browsers, desktop, and Chrome

## 🛠️ Tech Stack

| Layer | Tech |
|---|---|
| Framework | Flutter 3.x |
| Game Engine | Flame |
| Audio | flame_audio (audioplayers) |
| Fonts | Press Start 2P, VT323 (Google Fonts) |
| Assets | Kenney.nl (CC0) |
| Hosting | GitHub Pages |

## 🚀 Run Locally

```bash
# Clone
git clone https://github.com/Asherbinyy/Valantina.git
cd Valantina

# Install dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Or build for web
flutter build web --release --base-href "/Valantina/"
```

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── game/
│   ├── run_to_love_game.dart  # Main Flame game class
│   ├── constants.dart         # All tunable game constants
│   └── components/            # Game components
│       ├── player.dart        # Bunny player (4 sprites)
│       ├── queen.dart         # Queen bunny at finish
│       ├── obstacle.dart      # Spikes & bats
│       ├── heart.dart         # Collectible hearts
│       ├── ground.dart        # Tiled ground segments
│       ├── scenery.dart       # Background decorations
│       └── finish_flag.dart   # Door at the end
└── ui/
    ├── theme.dart             # Colors, fonts, gradients
    ├── start_screen.dart      # Title screen
    ├── hud.dart               # Hearts counter & notes
    ├── pause_overlay.dart     # Pause menu
    ├── valentine_prompt.dart  # "Will you be my Valentine?"
    └── celebration_screen.dart # Win screen with confetti

assets/
├── audio/     # 8 sound effects + background music
├── sprites/   # Character & object sprites
├── tiles/     # Ground tile textures
└── fonts/     # Pixel fonts
```

## 🎨 Assets Credits

All game assets from [Kenney.nl](https://kenney.nl/) — **CC0 (public domain)**:
- 🐰 Sprites: [Animal Pack Redux](https://kenney.nl/assets/animal-pack-redux)
- 🎵 Audio: [Music Jingles](https://kenney.nl/assets/music-jingles), [Interface Sounds](https://kenney.nl/assets/interface-sounds), [RPG Audio](https://kenney.nl/assets/rpg-audio)
- 🌿 Tiles: [Platformer Pack](https://kenney.nl/assets/simplified-platformer-pack)

## 👨‍💻 Author

**Sherbini** — [@Asherbinyy](https://github.com/Asherbinyy)

## 📄 License

MIT License — feel free to fork and make your own Valentine's game!
