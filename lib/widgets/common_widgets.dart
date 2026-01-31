import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final double? fontSize;

  const StatusBadge({Key? key, required this.status, this.fontSize = 12})
    : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'healthy':
      case 'sehat':
      case 'baik':
      case 'normal':
        return AppTheme.statusHealthy;
      case 'moderate':
      case 'moderat':
        return AppTheme.statusModerate;
      case 'unhealthy':
      case 'tidak sehat':
      case 'buruk':
        return AppTheme.statusUnhealthy;
      default:
        return AppTheme.textLight;
    }
  }

  String _getDisplayText() {
    switch (status.toLowerCase()) {
      case 'healthy':
        return 'Sehat';
      case 'moderate':
        return 'Moderat';
      case 'unhealthy':
        return 'Tidak Sehat';
      case 'normal':
        return 'Normal';
      case 'baik':
        return 'Baik';
      case 'buruk':
        return 'Buruk';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getDisplayText(),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? AppTheme.bgWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (iconColor ?? AppTheme.primaryGreen).withOpacity(
                  0.1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppTheme.primaryGreen,
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppTheme.textMedium),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isOutlined;
  final bool isLoading;

  const ActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(label),
      );
    }

    return ElevatedButton.icon(
      onPressed: isLoading ? null : onPressed,
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : (icon != null ? Icon(icon) : const SizedBox.shrink()),
      label: Text(label),
    );
  }
}
