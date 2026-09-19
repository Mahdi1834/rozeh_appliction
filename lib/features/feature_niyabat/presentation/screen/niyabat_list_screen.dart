import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/bloc/niyabat_bloc.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/screen/niyabat_screen.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/widgets/niyabat_item.dart';

import 'package:rozeh_project/locator.dart';

class NiyabatListScreen extends StatefulWidget {
  static const routePath = "/niyabat_list_screen";

  const NiyabatListScreen({super.key});

  @override
  State<NiyabatListScreen> createState() => _NiyabatListScreenState();
}

class _NiyabatListScreenState extends State<NiyabatListScreen> {
  late final NiyabatBloc niyabatBloc;

  final ScrollController _scrollController = ScrollController();

  final List<CalendarItem> _calendars = [];

  int _currentPage = 1;
  int _lastPage = 1;

  bool _isLoadingMore = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    niyabatBloc = locator<NiyabatBloc>();

    _scrollController.addListener(_onScroll);

    _loadFirstPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  // ============================================================
  // Load First Page
  // ============================================================

  void _loadFirstPage() {
    _currentPage = 1;
    _lastPage = 1;

    _calendars.clear();

    niyabatBloc.add(ListNiyabatEvent(page: 1));
  }

  // ============================================================
  // Load More
  // ============================================================

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 250) {
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    if (_isLoadingMore) {
      return;
    }

    if (_currentPage >= _lastPage) {
      return;
    }

    _isLoadingMore = true;

    final nextPage = _currentPage + 1;

    niyabatBloc.add(ListNiyabatEvent(page: nextPage));
  }

  // ============================================================
  // Refresh
  // ============================================================

  Future<void> _refresh() async {
    _isRefreshing = true;

    _currentPage = 1;
    _lastPage = 1;

    _calendars.clear();

    niyabatBloc.add(ListNiyabatEvent(page: 1));

    await Future.delayed(const Duration(milliseconds: 500));

    _isRefreshing = false;
  }



  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: theme.background,
          child: Column(
            children: [
              CustomAppBarWithSearch(
                mainContext: context,
                title: "روضه نیابتی",
                onTapSearch: () {},
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ==================================================
                    // Background Mandala Left
                    // ==================================================
                    Positioned(
                      top: height * 0.2,
                      left: 0,
                      child: SvgPicture.asset(
                        "assets/images/mandala.svg",
                        height: height * 0.35,
                        color: theme.appBarSecondary,
                      ),
                    ),

                    // ==================================================
                    // Background Mandala Right
                    // ==================================================
                    Positioned(
                      top: height * 0.2,
                      right: 0,
                      child: SvgPicture.asset(
                        "assets/images/mandala (1).svg",
                        height: height * 0.35,
                        color: theme.appBarSecondary,
                      ),
                    ),

                    // ==================================================
                    // Bloc
                    // ==================================================
                    BlocConsumer<NiyabatBloc, NiyabatState>(
                      bloc: niyabatBloc,

                      listenWhen:
                          (previous, current) =>
                              previous.listNiyabatStatus !=
                              current.listNiyabatStatus,
                      buildWhen:
                          (previous, current) =>
                              previous.listNiyabatStatus !=
                              current.listNiyabatStatus,

                      listener: (context, state) {
                        // ==================================================
                        // List Completed
                        // ==================================================

                        final listStatus = state.listNiyabatStatus;

                        if (listStatus is ListNiyabatStatusCompleted) {
                          final paginator =
                              listStatus.listNiyabatModel.data?.calendars;

                          if (paginator != null) {
                            final newItems = paginator.data ?? [];

                            // ------------------------------------------
                            // اگر صفحه اول است
                            // ------------------------------------------

                            if (paginator.currentPage == 1) {
                              _calendars
                                ..clear()
                                ..addAll(newItems);
                            }
                            // ------------------------------------------
                            // اگر صفحه بعدی است
                            // ------------------------------------------
                            else {
                              _calendars.addAll(newItems);
                            }

                            _currentPage =
                                paginator.currentPage?.toInt() ?? _currentPage;

                            _lastPage =
                                paginator.lastPage?.toInt() ?? _lastPage;
                          }

                          _isLoadingMore = false;

                          if (mounted) {
                            setState(() {});
                          }
                        }

                        // ==================================================
                        // List Error
                        // ==================================================

                        if (listStatus is ListNiyabatStatusError) {
                          final err = listStatus;

                          if (err.message == "401") {
                            SnackbarHelper.show(
                              context: context,
                              message:
                                  "توکن شما منقضی شده است. دوباره لاگین کنید.",
                              status: SnackbarStatus.error,
                            );
                            context.go(LoginScreen.routePath);
                          } else {
                            SnackbarHelper.show(
                              context: context,
                              message: err.message ?? 'خطا',
                              status: SnackbarStatus.error,
                            );
                          }

                          _isLoadingMore = false;

                          if (mounted) {
                            setState(() {});
                          }
                        }


                      },

                      builder: (context, state) {
                        final listStatus = state.listNiyabatStatus;

                        // ==================================================
                        // Initial Loading
                        // ==================================================

                        if (listStatus is ListNiyabatStatusLoading &&
                            _calendars.isEmpty) {
                          return const Center(
                            child: DotLoadingWidget(size: 50),
                          );
                        }

                        // ==================================================
                        // Error
                        // ==================================================

                        if (listStatus is ListNiyabatStatusError &&
                            _calendars.isEmpty) {
                          return _buildError(context, listStatus.message!);
                        }

                        // ==================================================
                        // Empty
                        // ==================================================

                        if (_calendars.isEmpty &&
                            listStatus is ListNiyabatStatusCompleted) {
                          return _buildEmpty(context);
                        }

                        // ==================================================
                        // List
                        // ==================================================

                        if (_calendars.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: _refresh,
                            child: ListView.builder(
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                10,
                                8,
                                10,
                                100,
                              ),
                              itemCount:
                                  _calendars.length + (_isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                // ----------------------------------------
                                // Loading More
                                // ----------------------------------------

                                if (index == _calendars.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: DotLoadingWidget(size: 50),
                                    ),
                                  );
                                }

                                final calendar = _calendars[index];

                                return NiyabatItem(
                                  niyabatBloc: niyabatBloc,
                                  calendar: calendar,
                                  onEdit: () async {
                                    await context.pushNamed(
                                      NiyabatScreen.routeName,
                                      extra: calendar,
                                    );

                                    if (mounted) {
                                      _loadFirstPage();
                                    }
                                  },
                                );
                              },
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),

                    // ==================================================
                    // Add Button
                    // ==================================================
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 15,
                      child: SizedBox(
                        height: 50,
                        child: CustomBtnGradient(
                          title: "ثبت روضه نیابتی جدید",
                          onPressed: () async {
                            await context.pushNamed(NiyabatScreen.routeName);

                            if (mounted) {
                              _loadFirstPage();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Error
  // ============================================================

  Widget _buildError(BuildContext context, String error) {
    final theme = context.appColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 50, color: theme.warning),
            const SizedBox(height: 15),
            TxtTitleNotBold(
              text: error,
              textAlign: TextAlign.center,
              color: theme.textPrimary,
              size: 14,
            ),
            const SizedBox(height: 15),
            CustomBtnGradient(onPressed: _loadFirstPage, title: "تلاش مجدد"),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Empty
  // ============================================================

  Widget _buildEmpty(BuildContext context) {
    final theme = context.appColors;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Center(
              child: TxtTitle(
                text: "هنوز روضه نیابتی ثبت نکرده‌اید",
                color: theme.textPrimary,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

