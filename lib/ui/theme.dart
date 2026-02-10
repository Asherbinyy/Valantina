import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// All design tokens from docs/DESIGN_TOKENS.md — single source of truth.

// ── Colors ────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Background gradient
  static const Color bgTop = Color(0xFFFFD1DC); // soft pink
  static const Color bgMid = Color(0xFFFFB3C7); // rose
  static const Color bgBot = Color(0xFFFFE7B3); // warm peach

  // UI / text
  static const Color ink = Color(0xFF2B2233); // dark plum
  static const Color card = Color(0xFFFFF6FB); // near-white pink
  static const Color outline = Color(0xFF2B2233); // pixel outline
  static const Color yes = Color(0xFFFF4D8D); // hot pink (primary)
  static const Color yesHi = Color(0xFFFF7FB0); // hover/shine
  static const Color restart = Color(0xFF6B5B7A); // muted purple
  static const Color heart = Color(0xFFFF2D6F); // pickup

  // Hazards
  static const Color hazard = Color(0xFF2B2233); // keep readable
}

// ── Gradients ─────────────────────────────────────────
const LinearGradient kBgGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppColors.bgTop, AppColors.bgMid, AppColors.bgBot],
);

// ── Layout constants ──────────────────────────────────
const double kSafePadding = 16.0;
const double kButtonMinHeight = 48.0;
const double kHitTarget = 44.0;

// ── Text styles ───────────────────────────────────────
/// Heading font: Press Start 2P, pixel retro.
TextStyle headingStyle({double fontSize = 24}) {
  return GoogleFonts.pressStart2p(
    fontSize: fontSize,
    color: AppColors.ink,
    height: 1.4,
    decoration: TextDecoration.none,
  );
}

/// Body / dialogue font: VT323, pixel monospace.
TextStyle bodyStyle({double fontSize = 24}) {
  return GoogleFonts.vt323(
    fontSize: fontSize,
    color: AppColors.ink,
    height: 1.3,
    decoration: TextDecoration.none,
  );
}
