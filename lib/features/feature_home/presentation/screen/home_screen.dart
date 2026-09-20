import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/config/theme/presentation/theme_cubit.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_home/data/model/banners_model.dart';
import 'package:rozeh_project/features/feature_home/data/model/latest_requests_customer_model.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/home_niyabat_item.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/image_slider.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_model.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/widgets/expandable_reservation_card.dart';

class HomeScreen extends StatefulWidget {
  static const routePath = "/Home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(GetBannersEvent());
    context.read<HomeBloc>().add(GetLatestRequestCustomerEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final isDark =
        context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.background,
          child: Column(
            children: [
              // ============================================================
              // Header + Banner
              // ============================================================
              Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      context.appColors.appBarBackground,
                      context.appColors.appBarSecondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        height: height * 0.15,
                        "assets/images/logo_top_left.svg",
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        height: height * 0.15,
                        "assets/images/logo_top_right.svg",
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.02),

                          Row(
                            children: [
                              CustomBtnIconMenu(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                imageUrl: "assets/images/menu.svg",
                              ),

                              Expanded(
                                child: Center(
                                  child: TxtHeader(text: Constants.nameApp),
                                ),
                              ),

                              CustomBtnIconMenu(
                                onTap: () {
                                  // TODO: جستجو
                                },
                                imageUrl: "assets/images/Search.svg",
                              ),

                              IconButton(
                                onPressed: () {
                                  context.read<ThemeCubit>().toggleTheme();
                                },
                                tooltip:
                                    isDark
                                        ? 'تغییر به حالت روشن'
                                        : 'تغییر به حالت تاریک',
                                icon: Icon(
                                  isDark
                                      ? Icons.light_mode_rounded
                                      : Icons.dark_mode_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: height * 0.02),

                          // ==================================================
                          // Banner
                          // ==================================================
                          Container(
                            height: height * 0.25,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: BlocConsumer<HomeBloc, HomeState>(
                              listenWhen:
                                  (previous, current) =>
                                      previous.bannersStatus !=
                                      current.bannersStatus,
                              buildWhen:
                                  (previous, current) =>
                                      previous.bannersStatus !=
                                      current.bannersStatus,
                              listener: (context, state) {
                                if (state.bannersStatus is BannersStatusError) {
                                  final error =
                                      state.bannersStatus as BannersStatusError;

                                  SnackbarHelper.show(
                                    context: context,
                                    message:
                                        error.message ?? 'خطا در دریافت بنرها',
                                    status: SnackbarStatus.error,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state.bannersStatus
                                    is BannersStatusLoading) {
                                  return const Center(
                                    child: DotLoadingWidget(size: 50),
                                  );
                                }

                                if (state.bannersStatus
                                    is BannersStatusCompleted) {
                                  final completed =
                                      state.bannersStatus
                                          as BannersStatusCompleted;

                                  final BannersModel model =
                                      completed.bannersModel;

                                  final List<Banners> banners =
                                      model.data?.banners
                                          ?.where(
                                            (banner) =>
                                                banner.isActive == true &&
                                                banner.imageUrl != null &&
                                                banner.imageUrl!.isNotEmpty,
                                          )
                                          .toList() ??
                                      [];

                                  if (banners.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'بنری برای نمایش وجود ندارد.',
                                        style: TextStyle(
                                          color:
                                              context.appColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }

                                  return BannerSlider(banners: banners);
                                }

                                if (state.bannersStatus is BannersStatusError) {
                                  return Center(
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<HomeBloc>().add(
                                          GetBannersEvent(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        color: context.appColors.error,
                                      ),
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ============================================================
              // Latest Requests
              // ============================================================
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  listenWhen:
                      (previous, current) =>
                          previous.latestRequestCustomerStatus !=
                          current.latestRequestCustomerStatus,

                  buildWhen:
                      (previous, current) =>
                          previous.latestRequestCustomerStatus !=
                          current.latestRequestCustomerStatus,

                  listener: (context, state) {
                    if (state.latestRequestCustomerStatus
                        is LatestRequestCustomerStatusError) {
                      final error =
                          state.latestRequestCustomerStatus
                              as LatestRequestCustomerStatusError;

                      SnackbarHelper.show(
                        context: context,
                        message: error.message ?? 'خطا در دریافت اطلاعات',
                        status: SnackbarStatus.error,
                      );
                    }
                  },

                  builder: (context, state) {
                    // ======================================================
                    // Loading
                    // ======================================================
                    if (state.latestRequestCustomerStatus
                        is LatestRequestCustomerStatusLoading) {
                      return const Center(child: DotLoadingWidget(size: 50));
                    }

                    // ======================================================
                    // Error
                    // ======================================================
                    if (state.latestRequestCustomerStatus
                        is LatestRequestCustomerStatusError) {
                      final error =
                          state.latestRequestCustomerStatus
                              as LatestRequestCustomerStatusError;

                      return _buildErrorState(
                        context,
                        message: error.message ?? 'خطا در دریافت اطلاعات',
                        onRetry: () {
                          context.read<HomeBloc>().add(
                            GetLatestRequestCustomerEvent(),
                          );
                        },
                      );
                    }

                    // ======================================================
                    // Completed
                    // ======================================================
                    if (state.latestRequestCustomerStatus
                        is LatestRequestCustomerStatusCompleted) {
                      final completed =
                          state.latestRequestCustomerStatus
                              as LatestRequestCustomerStatusCompleted;

                      final LatestRequestsCustomerModel model =
                          completed.latestRequestsCustomerModel;

                      final List<RozehRequest> rozehRequests =
                          model.data?.rozehRequests ?? [];

                      final List<CalendarItem> niyabatCalendars =
                          model.data?.niyabatCalendars ?? [];

                      final bool hasReservations = rozehRequests.isNotEmpty;

                      final bool hasNiyabat = niyabatCalendars.isNotEmpty;

                      // ====================================================
                      // هیچ داده‌ای وجود ندارد
                      // ====================================================
                      if (!hasReservations && !hasNiyabat) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: _buildEmptyAllState(context),
                          ),
                        );
                      }

                      // ====================================================
                      // نمایش داده‌ها
                      // ====================================================
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ==================================================
                            // رزروها
                            // ==================================================
                            if (hasReservations) ...[
                              _buildSectionTitle(
                                context,
                                title: 'آخرین رزروهای شما',
                                icon: Icons.event_available_outlined,
                                count: rozehRequests.length,
                              ),

                              const SizedBox(height: 4),

                              ...rozehRequests.map((request) {
                                return ExpandableReservationCard(
                                  request: request,
                                );
                              }),
                            ] else ...[
                              _buildEmptySection(
                                context,
                                icon: Icons.event_busy_outlined,
                                title: 'رزروی ثبت نشده است',
                                message:
                                    'هنوز هیچ رزروی برای مراسم ثبت نکرده‌اید.',
                              ),
                            ],

                            const SizedBox(height: 22),

                            // ==================================================
                            // نیابت‌ها
                            // ==================================================
                            if (hasNiyabat) ...[
                              _buildSectionTitle(
                                context,
                                title: 'آخرین روضه‌های نیابتی',
                                icon: Icons.volunteer_activism_outlined,
                                count: niyabatCalendars.length,
                              ),

                              const SizedBox(height: 4),

                              ...niyabatCalendars.map(
                                    (calendar) {
                                  return HomeNiyabatItem(
                                    calendar: calendar,
                                  );
                                },
                              ),
                            ] else ...[
                              _buildEmptySection(
                                context,
                                icon: Icons.volunteer_activism_outlined,
                                title: 'روضه نیابتی ثبت نشده است',
                                message:
                                    'هنوز هیچ روضه نیابتی برای شما ثبت نشده است.',
                              ),
                            ],
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Section Title
  // ============================================================

  Widget _buildSectionTitle(
    BuildContext context, {
    required String title,
    required IconData icon,
    required int count,
  }) {
    final theme = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: theme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: theme.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.warning.withValues(alpha: 0.15)),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: theme.warning,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Empty Section
  // ============================================================

  Widget _buildEmptySection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
  }) {
    final theme = context.appColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.border),
        boxShadow: [
          BoxShadow(
            color: theme.warning.withValues(alpha: 0.25),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.warning.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.warning, size: 23),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: theme.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  message,
                  style: TextStyle(
                    color: theme.textSecondary,
                    fontSize: 11,
                    height: 1.5,
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
  // Empty All
  // ============================================================

  Widget _buildEmptyAllState(BuildContext context) {
    final theme = context.appColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.border),
        boxShadow: [
          BoxShadow(
            color: theme.warning.withValues(alpha: 0.20),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [theme.warning, theme.warning2]),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.event_note_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'هنوز فعالیتی ثبت نشده است',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'هنوز هیچ رزرو مراسم یا روضه نیابتی برای شما ثبت نشده است.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.textSecondary,
              fontSize: 12,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // Error
  // ============================================================

  Widget _buildErrorState(
    BuildContext context, {
    required String message,
    required VoidCallback onRetry,
  }) {
    final theme = context.appColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.error.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: theme.error,
                size: 32,
              ),
            ),

            const SizedBox(height: 14),

            TxtTitle(size: 14, text: message, color: theme.textPrimary),

            const SizedBox(height: 14),

            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
