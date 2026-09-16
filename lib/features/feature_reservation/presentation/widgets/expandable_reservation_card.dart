import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_model.dart';

class ExpandableReservationCard extends StatefulWidget {
  final RozehRequest request;

  const ExpandableReservationCard({super.key, required this.request});

  @override
  State<ExpandableReservationCard> createState() =>
      _ExpandableReservationCardState();
}

class _ExpandableReservationCardState extends State<ExpandableReservationCard> {
  bool isExpanded = false;

  RozehRequest get request => widget.request;

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    final rozehTitle = request.rozeh?.title ?? 'مراسم';
    final date = _formatDate(request.date);

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 4),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: context.appColors.border),
        boxShadow: [
          BoxShadow(
            color: context.appColors.warning.withValues(alpha: 0.8),
            blurRadius: 5.3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                child: Column(
                  children: [
                    // -------------------------
                    // عنوان + تاریخ
                    // -------------------------
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
                                    colors: [
                                      theme.warning,
                                      theme.warning2,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.mosque_outlined,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TxtTitle(
                                      text: 'مراسم ${request.rozeh?.title ?? 'مراسم'}',
                                      color: theme.textPrimary,
                                    ),
                                    const SizedBox(height: 4),

                                    Text(
                                      _formatDate(request.date),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: theme.textPrimary.withValues(
                                          alpha: 0.55,
                                        ),
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

                        const SizedBox(width: 8),

                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  theme.warning,
                                  theme.warning2,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 12),

                    // -------------------------
                    // کاربران
                    // -------------------------
                    // _buildUsersPreview(context),

                    const SizedBox(height: 8),

                    // -------------------------
                    // وضعیت
                    // -------------------------
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: _buildStatus(context),
                    // ),
                  ],
                ),
              ),
            ),

            // -------------------------
            // جزئیات بازشونده
            // -------------------------
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child:
                  isExpanded
                      ? _buildExpandedContent(context)
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Users Preview
  // ============================================================

  Widget _buildUsersPreview(BuildContext context) {
    final theme = context.appColors;
    final users = request.users ?? [];

    if (users.isEmpty) {
      return _buildInfoRow(
        context,
        icon: Icons.person_outline,
        title: 'مجریان مراسم',
        value: 'تعیین نشده',
      );
    }

    return Row(
      children: [
        Icon(Icons.people_outline, size: 20, color: theme.warning),

        const SizedBox(width: 8),

        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                users.map((user) {
                  return _buildUserChip(context, user);
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildUserChip(BuildContext context, RozehUser user) {
    final theme = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: theme.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.warning.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            user.isMaddah == true && user.isSpeaker == true
                ? Icons.record_voice_over_outlined
                : user.isMaddah == true
                ? Icons.music_note_outlined
                : Icons.mic_none_outlined,
            size: 15,
            color: theme.warning,
          ),

          const SizedBox(width: 5),

          Text(
            user.fullName ?? 'بدون نام',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.textPrimary,
            ),
          ),

          if (user.assignmentLabel != null) ...[
            const SizedBox(width: 4),
            Text(
              '(${user.assignmentLabel})',
              style: TextStyle(
                fontSize: 10,
                color: theme.textPrimary.withValues(alpha: 0.55),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // Expanded Content
  // ============================================================

  Widget _buildExpandedContent(BuildContext context) {
    final theme = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      child: Column(
        children: [
          Divider(color: theme.warning.withValues(alpha: 0.25), height: 20),

          // کاربران
          _buildUsersSection(context),

          const SizedBox(height: 14),

          // اطلاعات مراسم
          _buildInfoRow(
            context,
            icon: Icons.event_outlined,
            title: 'نوع مراسم',
            value: request.rozeh?.title ?? '---',
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            context,
            icon: Icons.groups_outlined,
            title: 'مخاطبین',
            value: _mapGender(request.gender),
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            context,
            icon: Icons.access_time_outlined,
            title: 'ساعت مراسم',
            value: _formatTimeRange(request.startTime, request.endTime),
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            context,
            icon: Icons.location_on_outlined,
            title: 'آدرس',
            value:
                request.customerAddress?.address ??
                request.address ??
                'آدرس ثبت نشده',
          ),

          const SizedBox(height: 10),

          _buildInfoRow(
            context,
            icon: Icons.people_alt_outlined,
            title: 'گروه سنی',
            value: request.ageGroup?.title ?? '---',
          ),

          const SizedBox(height: 14),

          // وضعیت
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.warning.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.warning.withValues(alpha: 0.12)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 19, color: theme.warning),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    'وضعیت درخواست',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.textPrimary,
                    ),
                  ),
                ),

                _buildStatus(context),
              ],
            ),
          ),

          // توضیحات
          if (request.description != null &&
              request.description!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),

            _buildInfoRow(
              context,
              icon: Icons.notes_outlined,
              title: 'توضیحات',
              value: request.description!,
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // Users Section
  // ============================================================

  Widget _buildUsersSection(BuildContext context) {
    final theme = context.appColors;
    final users = request.users ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.people_outline, size: 20, color: theme.warning),
            const SizedBox(width: 7),
            Text(
              'مجریان مراسم',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: theme.textPrimary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        if (users.isEmpty)
          Text(
            'هنوز مداح یا سخنرانی برای این مراسم تعیین نشده است.',
            style: TextStyle(
              fontSize: 12,
              color: theme.textPrimary.withValues(alpha: 0.55),
            ),
          )
        else
          Column(
            children:
                users.map((user) {
                  return _buildUserItem(context, user);
                }).toList(),
          ),
      ],
    );
  }

  Widget _buildUserItem(BuildContext context, RozehUser user) {
    final theme = context.appColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: theme.textPrimary.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.warning.withValues(alpha: 0.10),
            child: Icon(Icons.person_outline, color: theme.warning, size: 20),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName ?? 'بدون نام',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: theme.textPrimary,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  user.assignmentDisplay ??
                      user.assignmentLabel ??
                      'مجری مراسم',
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.textPrimary.withValues(alpha: 0.55),
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
  // Info Row
  // ============================================================

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final theme = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: theme.warning.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, size: 18, color: theme.warning),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.textPrimary.withValues(alpha: 0.50),
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Status
  // ============================================================

  Widget _buildStatus(BuildContext context) {
    final theme = context.appColors;

    final status = _getStatus(request.assignmentStatus);

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
  // Helpers
  // ============================================================

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return '---';
    }

    return toJalaliDate(date);
  }


  String toJalaliDate(String? gregorianDate) {
    if (gregorianDate == null || gregorianDate.isEmpty) return "";

    try {
      // تبدیل رشته به DateTime
      final date = DateTime.parse(gregorianDate);

      // تبدیل به شمسی
      final jalali = Jalali.fromDateTime(date);

      // برگردوندن به فرمت خوش‌خوان
      return "${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "";
    }
  }

  String _formatTimeRange(String? startTime, String? endTime) {
    if (startTime == null && endTime == null) {
      return '---';
    }

    final start = _shortTime(startTime);
    final end = _shortTime(endTime);

    if (start == '---') {
      return end;
    }

    if (end == '---') {
      return start;
    }

    return '$start تا $end';
  }

  String _shortTime(String? time) {
    if (time == null || time.isEmpty) {
      return '---';
    }

    final parts = time.split(':');

    if (parts.length < 2) {
      return time;
    }

    return '${parts[0]}:${parts[1]}';
  }

  String _mapGender(String? gender) {
    switch (gender) {
      case 'man':
        return 'آقایان';

      case 'woman':
        return 'بانوان';

      case 'family':
        return 'خانوادگی';

      default:
        return gender ?? '---';
    }
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
