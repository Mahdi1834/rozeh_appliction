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
import 'package:rozeh_project/features/feature_home/data/model/banners_model.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_home/presentation/widgets/image_slider.dart';

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

    BlocProvider.of<HomeBloc>(context).add(GetBannersEvent());
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
              // ================= Header + FancyCard (Hadith) =================
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

                          Container(
                            height: height * 0.25,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),

                            child: BlocConsumer<HomeBloc, HomeState>(
                              listenWhen:
                                  (p, c) => p.bannersStatus != c.bannersStatus,
                              buildWhen:
                                  (p, c) => p.bannersStatus != c.bannersStatus,
                              listener: (context, state) {
                                if (state.bannersStatus is BannersStatusError) {
                                  final err =
                                      state.bannersStatus as BannersStatusError;
                                  SnackbarHelper.show(
                                    context: context,
                                    message: err.message ?? 'خطا',
                                    status: SnackbarStatus.error,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state.bannersStatus
                                    is BannersStatusLoading) {
                                  return const DotLoadingWidget(size: 50);
                                }
                                if (state.bannersStatus
                                    is BannersStatusCompleted) {
                                  final comp =
                                      state.bannersStatus
                                          as BannersStatusCompleted;

                                  final BannersModel model = comp.bannersModel;
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
                                  print(banners.first.imageUrl);
                                  return BannerSlider(banners: banners);
                                }
                                if (state.bannersStatus is BannersStatusError) {
                                  return IconButton(
                                    onPressed: () {
                                      BlocProvider.of<HomeBloc>(
                                        context,
                                      ).add(GetBannersEvent());
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      color: context.appColors.error,
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
            ],
          ),
        ),
      ),
    );
  }
}
