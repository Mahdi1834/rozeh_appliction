import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/widgets/custom_btn_icon_menu.dart';
import 'package:rozeh_project/core/widgets/custom_icon_svg_btn.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/txt_for_quran.dart';
import 'package:rozeh_project/core/widgets/txt_header.dart';
import 'package:rozeh_project/core/widgets/txt_medium.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';

import 'package:rozeh_project/features/feature_home/data/info_reservation_model.dart';
import 'package:rozeh_project/features/feature_home/data/model/current_hadith_model.dart';
import 'package:rozeh_project/features/feature_home/data/model/rozeh_request_model.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/expandable_reservation_card.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/fancy_card.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routePath = "/Home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // برای انیمیشن کارت بالا
  late ScrollController _scrollController;

  // برای لیست رزروها (lazy load)
  late ScrollController _listController;

  bool isFancyCardExpanded = true;

  // صفحه فعلی و آخرین صفحه
  int _currentPage = 1;
  int _lastPage = 1;

  // وضعیت لود صفحه بعد
  bool _isLoadingMore = false;

  // لیست تجمیعی آیتم‌ها (از تمام صفحات)
  final List<RozehRequest> _requests = [];

  @override
  void initState() {
    super.initState();

    // حدیث
    BlocProvider.of<HomeBloc>(context).add(GetCurrentHadithEvent());

    _scrollController = ScrollController();

    _listController = ScrollController()..addListener(_onListScroll);

    // صفحه اول رزروها
    _fetchPage(1);
  }

  // درخواست صفحه nام
  void _fetchPage(int pageNumber) {
    _currentPage = pageNumber;
    BlocProvider.of<HomeBloc>(
      context,
    ).add(GetRozehRequestEvent(page: pageNumber.toString()));
  }

  // لود تنبل: رسیدن به انتهای لیست
  void _onListScroll() {
    if (_listController.position.pixels >=
            _listController.position.maxScrollExtent - 120 &&
        !_isLoadingMore &&
        _currentPage < _lastPage) {
      setState(() => _isLoadingMore = true);
      _fetchPage(_currentPage + 1);
    }
  }

  // فراخوانی دستی رویداد رزرو
  void callGetRozehRequest(int pageNumber) {
    BlocProvider.of<HomeBloc>(
      context,
    ).add(GetRozehRequestEvent(page: pageNumber.toString()));
  }

  @override
  void dispose() {
    // اگر لازم شد آزاد کن
    // _scrollController.dispose();
    // _listController.dispose();
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
          color: ConsColors.blueLight,
          child: Column(
            children: [
              // ================= Header + FancyCard (Hadith) =================
              Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [ConsColors.blueBg2, ConsColors.blueBg1],
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
                    Positioned(
                      top: height * 0.071,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                            color: ConsColors.yellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: TxtTitle(
                              color: ConsColors.orange,
                              text: "سرچشمه شوق",
                            ),
                          ),
                        ),
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
                                  child: TxtHeader(
                                    text: Constants.nameApp,
                                  ),
                                ),
                              ),
                              CustomBtnIconMenu(
                                onTap: () {
                                  // TODO: جستجو
                                },
                                imageUrl: "assets/images/Search.svg",
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),

                          // کارت حدیث
                          AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 40,
                                maxHeight:
                                    isFancyCardExpanded ? height * 0.25 : 40,
                                minWidth: width,
                                maxWidth: width,
                              ),
                              child: FancyCard(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: BlocConsumer<HomeBloc, HomeState>(
                                        listenWhen:
                                            (p, c) =>
                                                p.currentHadithStatus !=
                                                c.currentHadithStatus,
                                        buildWhen:
                                            (p, c) =>
                                                p.currentHadithStatus !=
                                                c.currentHadithStatus,
                                        listener: (context, state) {
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusError) {
                                            final err =
                                                state.currentHadithStatus
                                                    as CurrentHadithStatusError;
                                            SnackbarHelper.show(
                                              context: context,
                                              message: err.message ?? 'خطا',
                                              status: SnackbarStatus.error,
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusLoading) {
                                            return const DotLoadingWidget(
                                              size: 50,
                                            );
                                          }
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusCompleted) {
                                            final comp =
                                                state.currentHadithStatus
                                                    as CurrentHadithStatusCompleted;
                                            final CurrentHadithModel m =
                                                comp.currentHadithModel;

                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width,
                                                      child: TxtMedium(
                                                        text:
                                                            m
                                                                .data
                                                                ?.currentHadith
                                                                ?.author ??
                                                            "",
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    TxtForQuran(
                                                      text:
                                                          m
                                                              .data
                                                              ?.currentHadith
                                                              ?.contentAr ??
                                                          "",
                                                    ),
                                                    const SizedBox(height: 5),
                                                    TxtMedium(
                                                      isAlignCenter: true,
                                                      text:
                                                          m
                                                              .data
                                                              ?.currentHadith
                                                              ?.contentFa ??
                                                          "",
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: width,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: TxtTitleNotBold(
                                                          size: 12,
                                                          text:
                                                              m
                                                                  .data
                                                                  ?.currentHadith
                                                                  ?.source ??
                                                              "",
                                                          color:
                                                              ConsColors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          if (state.currentHadithStatus
                                              is CurrentHadithStatusError) {
                                            return IconButton(
                                              onPressed: () {
                                                BlocProvider.of<HomeBloc>(
                                                  context,
                                                ).add(GetCurrentHadithEvent());
                                              },
                                              icon: Icon(
                                                Icons.refresh,
                                                color: ConsColors.green,
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
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ================= Content (Rezervations) =================
              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 20,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala.svg",
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                        ),
                      ),

                      BlocConsumer<HomeBloc, HomeState>(
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

                            if(err.message == "401"){

                              SnackbarHelper.show(
                                context: context,
                                message: "توکن شما منقضی شده است. دوباره لاگین کنید.",
                                status: SnackbarStatus.error,
                              );
                              context.go(LoginScreen.routePath);

                            }else {
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
                                    color: ConsColors.blue,
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
                                      color: ConsColors.blue,
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: width * 0.8,
                                      child: CustomSvgIconBtn(
                                        title: "رزرو",
                                        onPressed: () {
                                          // TODO: رفتن به صفحه رزرو
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
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                TxtTitle(
                                  size: 18,
                                  text: "برنامه مراسم رزرو شده برای شما",
                                  color: ConsColors.blue,
                                ),
                                const SizedBox(height: 10),

                                Expanded(
                                  child: NotificationListener<
                                    ScrollNotification
                                  >(
                                    onNotification: (scrollInfo) {
                                      if (scrollInfo
                                          is ScrollUpdateNotification) {
                                        final offset =
                                            scrollInfo.metrics.pixels;
                                        if (offset > 120 &&
                                            isFancyCardExpanded) {
                                          setState(
                                            () => isFancyCardExpanded = false,
                                          );
                                        } else if (offset < 10 &&
                                            !isFancyCardExpanded) {
                                          setState(
                                            () => isFancyCardExpanded = true,
                                          );
                                        }
                                      }
                                      return false;
                                    },
                                    child: ListView.builder(
                                      controller: _listController,
                                      itemCount: _requests.length + 1,
                                      // +1 برای لودر انتهایی
                                      itemBuilder: (context, index) {
                                        if (index == _requests.length) {
                                          // سطر آخر: لودر انتهایی زمانی که صفحه بعدی هست
                                          if (_isLoadingMore &&
                                              _currentPage < _lastPage) {
                                            return const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                              ),
                                              child: Center(
                                                child: DotLoadingWidget(
                                                  size: 30,
                                                ),
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        }

                                        final req = _requests[index];

                                        // ساخت مدل کارت از داده واقعی
                                        final info = InfoReservationModel(
                                          title: "مراسم رزرو شده",
                                          date: toJalaliDate(req.date),
                                          maddah: _joinNames(req.maddahs),
                                          speaker: _joinNames(req.speakers),
                                          type: req.rozeh?.title ?? "",
                                          gender: _mapGender(req.gender),
                                          address: req.address ?? ""
                                        );

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: ExpandableReservationCard(
                                            infoReservationModel: info,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
