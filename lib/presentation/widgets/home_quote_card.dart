import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/quote.dart';

/// The large quote card shown on the Home screen, matching the mockup:
/// a quote mark icon, bold centered quote text, a short divider, and the
/// author name underneath. Adapts colors for light/dark mode.
class HomeQuoteCard extends StatelessWidget {
  final Quote quote;
  const HomeQuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.format_quote,
            color: AppColors.primary.withOpacity(0.7),
            size: 36,
          ),
          const SizedBox(height: 20),
          Text(
            quote.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.35,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 24),
          Container(width: 40, height: 3, color: AppColors.primary),
          const SizedBox(height: 14),
          Text(
            quote.author,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
