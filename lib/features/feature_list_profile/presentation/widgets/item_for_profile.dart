import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';

class ItemForProfile extends StatelessWidget {
  const ItemForProfile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPress,
  });

  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 4),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(16),

        // مثل کارت ExpandableReservationCard
        border: Border.all(
          color: theme.border,
        ),

        boxShadow: [
          BoxShadow(
            color: theme.warning.withValues(alpha: 0.15),
            blurRadius: 5.3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPress,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              child: Row(
                children: [
                  // ============================================================
                  // Icon
                  // ============================================================
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
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      imageUrl,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // ============================================================
                  // Title + Description
                  // ============================================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TxtTitle(
                          text: title,
                          color: theme.textPrimary,
                        ),

                        const SizedBox(height: 4),

                        TxtTitleNotBold(
                          text: description,
                          color: theme.textPrimary.withValues(
                            alpha: 0.55,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // ============================================================
                  // Arrow
                  // ============================================================
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: theme.warning.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: theme.warning,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}