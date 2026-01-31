import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;

  const AppLogo({super.key, this.size = 60, this.showText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: BorderRadius.circular(size / 2),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryGreen.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(Icons.pets, size: size * 0.6, color: Colors.white),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 8),
          Text(
            'Catfish Farm',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Management System',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.textMedium),
          ),
        ],
      ],
    );
  }
}
