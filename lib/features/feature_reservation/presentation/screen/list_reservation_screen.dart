import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/custom_icon_svg_btn.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_model.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/bloc/reservation_bloc.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/screen/reservation_screen.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/widgets/expandable_reservation_card.dart';

class ListReservationScreen extends StatefulWidget {
  static const routePath = "/list_reservation_screen";
  static const routeName = "/list_reservation_screen";

  const ListReservationScreen({super.key});

  @override
  State<ListReservationScreen> createState() => _ListReservationScreenState();
}

class _ListReservationScreenState extends State<ListReservationScreen> {
  late ScrollController _listController;
  int _currentPage = 1;
  int _lastPage = 1;

  bool _isLoadingMore = false;

  final List<RozehRequest> _requests = [];

  @override
  void initState() {
    super.initState();

    _listController = ScrollController()..addListener(_onListScroll);

    // صفحه اول رزروها
    _fetchPage(1);
  }

  void _fetchPage(int pageNumber) {
    _currentPage = pageNumber;
    BlocProvider.of<ReservationBloc>(
      context,
    ).add(GetRozehRequestEvent(page: pageNumber.toString()));
  }

  void _onListScroll() {
    if (_listController.position.pixels >=
            _listController.position.maxScrollExtent - 120 &&
        !_isLoadingMore &&
        _currentPage < _lastPage) {
      setState(() => _isLoadingMore = true);
      _fetchPage(_currentPage + 1);
    }
  }

  void callGetRozehRequest(int pageNumber) {
    BlocProvider.of<ReservationBloc>(
      context,
    ).add(GetRozehRequestEvent(page: pageNumber.toString()));
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.background,
          child: Column(
            children: [
              CustomAppBarWithSearch(
                mainContext: context,
                title: "لیست مراسم ها",
                onTapSearch: () {},
              ),
              SizedBox(height: 10),
              // ================= Content (Rezervations) =================
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: height * 0.2,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala.svg",
                          color: context.appColors.appBarSecondary,
                        ),
                      ),
                      Positioned(
                        top: height * 0.2,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                          color: context.appColors.appBarSecondary,
                        ),
                      ),

                      BlocConsumer<ReservationBloc, ReservationState>(
                        listenWhen:
                            (p, c) =>
                                p.rozehRequestStatus != c.rozehRequestStatus,
                        buildWhen:
                            (p, c) =>
                                p.rozehRequestStatus != c.rozehRequestStatus,

                        listener: (context, state) {
                          if (state.rozehRequestStatus
                              is RozehRequestStatusError) {
                            final err =
                                state.rozehRequestStatus
                                    as RozehRequestStatusError;

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

                            setState(() => _isLoadingMore = false);
                          }

                          if (state.rozehRequestStatus
                              is RozehRequestStatusCompleted) {
                            final comp =
                                state.rozehRequestStatus
                                    as RozehRequestStatusCompleted;
                            final RozehRequestModel model =
                                comp.rozehRequestModel;

                            final pageData = model.data?.rozehRequests;
                            final items = pageData?.data ?? [];

                            // به‌روزسازی صفحات
                            _lastPage = pageData?.lastPage?.toInt() ?? 1;
                            final current =
                                pageData?.currentPage?.toInt() ?? _currentPage;

                            setState(() {
                              if (current <= 1) {
                                _requests
                                  ..clear()
                                  ..addAll(items);
                              } else {
                                final existingIds =
                                    _requests.map((e) => e.id).toSet();
                                for (final it in items) {
                                  if (!existingIds.contains(it.id)) {
                                    _requests.add(it);
                                  }
                                }
                              }
                              _currentPage = current;
                              _isLoadingMore = false;
                            });
                          }
                        },

                        builder: (context, state) {
                          // لودینگ اولیه فقط وقتی لیست فعلاً خالیه
                          if (state.rozehRequestStatus
                                  is RozehRequestStatusLoading &&
                              _requests.isEmpty) {
                            return const Center(
                              child: DotLoadingWidget(size: 50),
                            );
                          }

                          if (state.rozehRequestStatus
                              is RozehRequestStatusError) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _currentPage = 1;
                                    _lastPage = 1;
                                    setState(() {});
                                    _fetchPage(_currentPage);
                                  },
                                  icon: Icon(
                                    size: 40,
                                    Icons.refresh,
                                    color: context.appColors.textPrimary,
                                  ),
                                ),
                              ),
                            );
                          }

                          // Empty state → CTA رزرو
                          if (_requests.isEmpty) {
                            return Container(
                              width: width,
                              padding: const EdgeInsets.all(10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: height * 0.09),
                                    TxtTitle(
                                      isAlignCenter: true,
                                      size: 18,
                                      text:
                                          "کاربر عزیز   \n برای رزرو مجالس و روضه های خانگی خود فرم ثبت درخواست را تکمیل نمایید",
                                      color: context.appColors.textPrimary,
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: width * 0.8,
                                      child: CustomSvgIconBtn(
                                        title: "رزرو",
                                        onPressed: () {
                                          // TODO: رفتن به صفحه رزرو
                                          context.pushNamed(
                                            ReservationScreen.routeName,
                                          );
                                        },
                                        svgPicture: "assets/images/Add.svg",
                                        useGradient: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // لیست واقعی با لود تنبل
                          return Container(
                            width: width,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                TxtTitle(
                                  size: 18,
                                  text: " مراسم رزرو شده برای شما",
                                  color: context.appColors.textPrimary,
                                ),
                                const SizedBox(height: 10),

                                Expanded(
                                  child: ListView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.fromLTRB(
                                      10,
                                      8,
                                      10,
                                      100,
                                    ),
                                    controller: _listController,
                                    itemCount: _requests.length + 1,
                                    itemBuilder: (context, index) {
                                      // لودر صفحه بعد
                                      if (index == _requests.length) {
                                        if (_isLoadingMore &&
                                            _currentPage < _lastPage) {
                                          return const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Center(
                                              child: DotLoadingWidget(size: 30),
                                            ),
                                          );
                                        }

                                        return const SizedBox.shrink();
                                      }

                                      final req = _requests[index];

                                      return ExpandableReservationCard(
                                        request: req,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 15,
                        child: SizedBox(
                          height: 50,
                          child: CustomBtnGradient(
                            title: " رزرو جدید",
                            onPressed: ()  {
                              context.pushNamed(ReservationScreen.routeName);

                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }

  // ===== Helpers =====
  String _joinNames(List<RozehUser>? users) {
    if (users == null || users.isEmpty) return "-";
    return users
        .map((e) => e.fullName ?? "")
        .where((s) => s.trim().isNotEmpty)
        .join("، ");
  }

  String _mapGender(String? g) {
    switch (g) {
      case 'man':
        return 'آقایان';
      case 'woman':
        return 'بانوان';
      case 'family':
        return 'خانوادگی';
      default:
        return g ?? '-';
    }
  }
}
