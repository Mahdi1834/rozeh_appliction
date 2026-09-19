
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/bloc/niyabat_bloc.dart';

class NiyabatItem extends StatelessWidget {
  final CalendarItem calendar;
  final VoidCallback onEdit;

  final NiyabatBloc niyabatBloc;

  const NiyabatItem({
    required this.niyabatBloc,
    required this.calendar,
    required this.onEdit,
  });

  Future<void> _confirmDelete(BuildContext context) async {
    final theme = context.appColors;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: theme.navigationBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: theme.warning,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'حذف روضه نیابتی',
                style: TextStyle(
                  color: theme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Text(
            'آیا مطمئن هستید که می‌خواهید این روضه نیابتی را حذف کنید؟\nاین عملیات قابل بازگشت نیست.',
            style: TextStyle(
              color: theme.textSecondary,
              fontSize: 13,
              height: 1.7,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(
                'انصراف',
                style: TextStyle(color: theme.textSecondary, fontSize: 13),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.warning,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'حذف',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );

    if (result != true) return;

    if (calendar.id != null) {
      niyabatBloc.add(DeleteNiyabatEvent(niyabatId: calendar.id!.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    return InkWell(
      onTap: onEdit,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.navigationBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.border),
          boxShadow: [
            BoxShadow(
              color: context.appColors.warning.withValues(alpha: 0.8),
              blurRadius: 5.3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  : "روضه نیابتی",
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
                              calendar.intention?.title ?? "بدون نیت",
                              style: TextStyle(
                                color: theme.textSecondary,
                                fontSize: 12,
                              ),
                            ),

                            Text(
                              calendar.tavaslat?.title ?? "بدون توسل",
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

                // وضعیت
                _buildStatus(context),
              ],
            ),

            const SizedBox(height: 14),
            Row(
              children: [
                // ============================================================
                // مشاهده و ویرایش
                // ============================================================
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: theme.warning.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.warning.withValues(alpha: 0.10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_location_alt_outlined,
                          size: 17,
                          color: theme.warning,
                        ),

                        const SizedBox(width: 7),

                        Expanded(
                          child: Text(
                            'مشاهده و ویرایش ',
                            style: TextStyle(
                              color: theme.textPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 13,
                          color: theme.warning,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ============================================================
                // حذف
                // ============================================================
                BlocConsumer<NiyabatBloc, NiyabatState>(
                  buildWhen:
                      (previous, current) =>
                  previous.deleteNiyabatStatus !=
                      current.deleteNiyabatStatus,
                  listenWhen:
                      (previous, current) =>
                  previous.deleteNiyabatStatus !=
                      current.deleteNiyabatStatus,
                  listener: (context, state) {
                    if (state.deleteNiyabatStatus
                    is DeleteNiyabatStatusCompleted) {
                      niyabatBloc.add(ListNiyabatEvent());
                    }
                    if (state.deleteNiyabatStatus is DeleteNiyabatStatusError) {
                      DeleteNiyabatStatusError deleteNiyabatStatusError =
                      state.deleteNiyabatStatus as DeleteNiyabatStatusError;

                      SnackbarHelper.show(
                        context: context,
                        message: deleteNiyabatStatusError.message!,
                        status: SnackbarStatus.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state.deleteNiyabatStatus
                    is DeleteNiyabatStatusLoading) {
                      return DotLoadingWidget(size: 20);
                    }
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _confirmDelete(context),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 44,
                          height: 42,
                          decoration: BoxDecoration(
                            color: theme.warning.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: theme.warning.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                            color: theme.warning,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  _StatusInfo _getStatus(int? status) {
    switch (status) {
      case 1:
        return _StatusInfo(
          title: 'در انتظار تأیید',
          icon: Icons.hourglass_empty,
          color: Colors.orange,
        );

      case 2:
        return _StatusInfo(
          title: 'تأیید شده',
          icon: Icons.check_circle_outline,
          color: Colors.green,
        );

      case 3:
        return _StatusInfo(
          title: 'برگزار شده',
          icon: Icons.event_available_outlined,
          color: Colors.blue,
        );

      default:
        return _StatusInfo(
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