import 'package:flutter/material.dart';

class AppColors {

  static const Color primary = Color(0xFF001BB7); 
  // Main brand color → Use for AppBar, splash screen, main buttons.

  static const Color secondary = Color(0xFF0046FF); 
  // Secondary brand color → Use for outline buttons, links, highlights.

  static const Color accent = Color(0xFFFF8040); 
  // Accent / CTA color → Use for "Buy Now", "Add to Cart", floating action button, icons that need attention.

  // ---------------- Backgrounds ----------------
  static const Color background = Color(0xFFE9E9E9); 
  // Default page background → Use as Scaffold background, card background, or section divider.

  static const Color white = Colors.white;
  // Neutral background → Use for cards, dialogs, modals, product tiles.

  static const Color black = Colors.black;
  // Strong text or contrast → Use for titles, icons, or places needing high readability.

  // ---------------- Text Colors ----------------
  static const Color textPrimary = Colors.black87;
  // Main text color → Use for body text, product details.

  static const Color textSecondary = Colors.black54;
  // Secondary text → Use for subtitles, descriptions, less important info.

  static const Color textLight = Colors.white;
  // Light text → Use on dark backgrounds like primary/secondary buttons.

  // ---------------- Status Colors ----------------
  static const Color success = Colors.green;
  // Success state → Use for success messages, completed orders, confirmed actions.

  static const Color error = Colors.red;
  // Error state → Use for errors, form validation, delete actions.

  static const Color warning = Colors.orange;
  // Warning state → Use for alerts, low stock notifications.

  static const Color info = Colors.blue;
  // Info state → Use for tooltips, informational banners.

  // ---------------- Greys ----------------
  static const Color grey = Colors.grey;
  // General neutral → Use for disabled buttons, placeholders, borders.

  static const Color lightGrey = Color(0xFFE0E0E0);
  // Light neutral → Use for dividers, light backgrounds, card shadows.

  static const Color darkGrey = Color(0xFF616161);
  // Dark neutral → Use for secondary text, icons, footer background.

  // ---------------- Transparent ----------------
  static const Color transparent = Colors.transparent;
  // Use when you need no background (e.g., InkWell splash, overlays).
}
