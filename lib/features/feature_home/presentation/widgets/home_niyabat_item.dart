import 'package:flutter/material.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';

class HomeNiyabatItem extends StatelessWidget {
  final CalendarItem calendar;

  const HomeNiyabatItem({super.key, required this.calendar});

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.border),
        boxShadow: [
          BoxShadow(
            color: theme.warning.withValues(alpha: 0.8),
            blurRadius: 5.3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // Header
          // ============================================================
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [theme.warning, theme.warning2],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.volunteer_activism_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            calendar.title?.trim().isNotEmpty == true
                                ? calendar.title!
                                : 'روضه نیابتی',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            calendar.intention?.title ?? 'بدون نیت',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.textSecondary,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            calendar.tavaslat?.title ?? 'بدون توسل',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: theme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              _buildStatus(context),
            ],
          ),

          const SizedBox(height: 8),

        ],
      ),
    );
  }

  // ============================================================
  // Status
  // ============================================================

  Widget _buildStatus(BuildContext context) {
    final theme = context.appColors;

    final status = _getStatus(calendar.status as int?);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: status.color.withValues(alpha: 0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 14, color: status.color),

          const SizedBox(width: 5),

          Text(
            status.title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Info Row
  // ============================================================

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: theme.warning.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.warning.withValues(alpha: 0.10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: theme.warning),

          const SizedBox(width: 7),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 10, color: theme.textSecondary),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Status Mapping
  // ============================================================

  _StatusInfo _getStatus(int? status) {
    switch (status) {
      case 1:
        return const _StatusInfo(
          title: 'در انتظار تأیید',
          icon: Icons.hourglass_empty,
          color: Colors.orange,
        );

      case 2:
        return const _StatusInfo(
          title: 'تأیید شده',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );

      case 3:
        return const _StatusInfo(
          title: 'برگزار شده',
          icon: Icons.event_available_outlined,
          color: Colors.blue,
        );

      default:
        return const _StatusInfo(
          title: 'نامشخص',
          icon: Icons.help_outline,
          color: Colors.grey,
        );
    }
  }
}

class _StatusInfo {
  final String title;
  final IconData icon;
  final Color color;

  const _StatusInfo({
    required this.title,
    required this.icon,
    required this.color,
  });
}
