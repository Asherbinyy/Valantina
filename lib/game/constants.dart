/// Centralized tuning values — single source of truth.
/// All numbers sourced from docs/LEVEL_DATA.md.
library;

/// Immutable note definition (tile-X + text from docs/COPY.md).
class NoteData {
  final int tileX;
  final String text;
  const NoteData(this.tileX, this.text);
}

// ── Tile ──────────────────────────────────────────────
const double kTileSize = 32.0;

// ── World ─────────────────────────────────────────────
const int kTotalTilesX = 220;
const int kGroundYTile = 10;
const double kWorldWidth = kTotalTilesX * kTileSize;
const double kGroundY = kGroundYTile * kTileSize;

// ── Player ────────────────────────────────────────────
const int kStartXTile = 3;
const double kPlayerWidth = 28.0;
const double kPlayerHeight = 36.0;
const double kPlayerStartX = kStartXTile * kTileSize;
const double kPlayerStartY = kGroundY - kPlayerHeight;

// ── Auto-run (tune these) ─────────────────────────────
const double kRunSpeed = 130.0; // was 150; slower = more reaction time
const double kJumpVelocity = -420.0; // was -380; higher jump
const double kBoostJumpMultiplier = 1.4; // was 1.35; bigger boost
const int kDoubleTapWindowMs = 300; // was 250; slightly wider window
const double kGravity = 820.0; // was 980; floatier jumps
const double kMaxFallSpeed = 600.0;

// ── Debug ─────────────────────────────────────────────
const bool kDebugInput = false; // set true to log tap/jump deltas

// ── Checkpoints (tile-X) ──────────────────────────────
const List<int> kCheckpointXTiles = [60, 120, 175];

// ── Hazards ───────────────────────────────────────────
const List<int> kSpikeTiles = [35, 48, 92, 108, 142, 160];
const List<List<int>> kGapRanges = [
  [70, 73],
  [130, 134],
];
const double kGapFallThreshold = 80.0;

// ── Obstacle size ─────────────────────────────────────
const double kSpikeWidth = 26.0;
const double kSpikeHeight = 26.0;

// ── Ground segments (derived from gap ranges) ─────────
const List<List<int>> kGroundSegments = [
  [0, 69],
  [74, 129],
  [135, 219],
];
const double kGroundThickness = 96.0;

// ── Hearts ────────────────────────────────────────────
const List<int> kHeartXTiles = [
  10, 14, 18, 42, 55, 66, 78, 96, 110, 125, 146, 158, 170, 182,
];
const double kHeartSize = 22.0;
const double kHeartFloatAboveGround = 52.0;
const double kHeartPopDuration = 0.4; // scale-up + fade-out total

// ── Micro-notes (text from docs/COPY.md) ──────────────
const int kNote1XTile = 25;
const int kNote2XTile = 105;
const int kNote3XTile = 165;
const List<NoteData> kNotes = [
  NoteData(kNote1XTile, 'You make ordinary days feel special.'),
  NoteData(kNote2XTile, "I'd jump any obstacle for you."),
  NoteData(kNote3XTile, 'Almost there…'),
];
const double kNoteDuration = 2.5; // seconds visible
const double kNoteTypewriterCps = 30; // characters per second

// ── Finish / Cutscene ─────────────────────────────────
const int kFinishXTile = 205;
const int kQueenXTile = 212;
// Queen uses same visual scale as player (28×36)
const double kQueenWidth = kPlayerWidth;
const double kQueenHeight = kPlayerHeight;
const double kPlayerQueenGap = 6.0; // px gap between player and queen
// Player snap position: just left of queen, both grounded
const double kQueenWorldX = kQueenXTile * kTileSize;
const double kPlayerFinishX = kQueenWorldX - kPlayerWidth - kPlayerQueenGap;
const double kPlayerFinishY = kGroundY - kPlayerHeight;
// Cutscene timing
const double kCutsceneTextDuration = 2.5; // "I found you 💖" display time
const double kCutscenePauseDuration = 0.8; // pause before valentine prompt
const double kHeartParticleDuration = 2.5; // heart particle burst

// ── Hit Recovery ──────────────────────────────────────
const double kHitRecoveryDuration = 0.8;
const double kCameraShakeIntensity = 4.0;
const double kCameraShakeDuration = 0.3;
