import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/app_navigation.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/curved_navigation_bar.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_item.dart';
import 'package:rozeh_project/features/feature_help/presentation/screen/help_screen.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_list_profile/presentation/screen/profile_menu_screen.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/widgets/drawer.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/screen/list_reservation_screen.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/screen/niyabat_list_screen.dart';

class MainWrapper extends StatefulWidget {
  static const routeName = "/main_wrapper";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final StatefulNavigationShell navigationShell;

  MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  DateTime? _lastBackPressed;

  // ============================================================
  // آیا BottomNavigation نمایش داده شود؟
  // ============================================================

  bool _shouldShowBottomNavBar(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (kDebugMode) {
      debugPrint('BottomNav location: $location');
    }

    const allowedRoutes = {
      HomeScreen.routePath,
      ListReservationScreen.routePath,
      NiyabatListScreen.routePath,
      ProfileMenuScreen.routePath,
      HelpScreen.routePath,
    };

    return allowedRoutes.contains(location);
  }

  // ============================================================
  // تغییر Branch
  // ============================================================

  void _goBranch(int index) {
    if (kDebugMode) {
      print("Navigating to branch $index");
      print("Current route: ${widget.navigationShell.route}");
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  // ============================================================
  // مدیریت کامل Back
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // ============================================================
        // 1. اگر Drawer باز است، فقط Drawer بسته شود
        // ============================================================
        final scaffoldState = widget._key.currentState;

        if (scaffoldState != null && scaffoldState.isDrawerOpen) {
          scaffoldState.closeDrawer();
          return;
        }

        // ============================================================
        // 2. Branch فعلی
        // ============================================================
        final currentIndex = widget.navigationShell.currentIndex;

        if (kDebugMode) {
          debugPrint(
            'BACK → Current branch: $currentIndex',
          );
        }

        // ============================================================
        // 3. اگر داخل صفحه داخلی Branch هستیم
        // ============================================================
        final currentNavigator =
            AppNavigation.t[currentIndex].currentState;

        if (currentNavigator != null && currentNavigator.canPop()) {
          if (kDebugMode) {
            debugPrint(
              'BACK → Pop current branch: $currentIndex',
            );
          }

          currentNavigator.pop();
          return;
        }

        // ============================================================
        // 4. اگر Branch فعلی Home نیست → برو Home
        // ============================================================
        if (currentIndex != 0) {
          if (kDebugMode) {
            debugPrint(
              'BACK → Going to Home from branch: $currentIndex',
            );
          }

          widget.navigationShell.goBranch(
            0,
            initialLocation: false,
          );

          return;
        }

        // ============================================================
        // 5. اگر Home هستیم → Back اول
        // ============================================================
        final now = DateTime.now();

        if (_lastBackPressed == null ||
            now.difference(_lastBackPressed!) >
                const Duration(seconds: 2)) {
          _lastBackPressed = now;
          print("main");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'برای خروج دوباره دکمه بازگشت را بزنید',
              ),
              duration: Duration(seconds: 2),
            ),
          );

          return;
        }

        // ============================================================
        // 6. Back دوم → خروج
        // ============================================================
        SystemNavigator.pop();
      },

      child: Scaffold(
        key: widget._key,

        resizeToAvoidBottomInset: true,

        extendBody: true,

        bottomNavigationBar:
        _shouldShowBottomNavBar(context)
            ? CurvedNavigationBar(
          key: _bottomNavigationKey,

          index: widget.navigationShell.currentIndex,

          items: [
            NavItem(
              svgPath: 'assets/images/Home.svg',
              title: 'خانه',
            ),
            NavItem(
              svgPath: 'assets/images/Add.svg',
              title: 'رزرو روضه',
            ),
            NavItem(
              svgPath: 'assets/images/Calendar.svg',
              title: 'روضه نیابتی',
            ),
            NavItem(
              svgPath: 'assets/images/Profile 1.svg',
              title: 'پروفایل',
            ),
            NavItem(
              svgPath: 'assets/images/Info square.svg',
              title: 'راهنما',
            ),
          ],

          color: context.appColors.navigationBackground,

          buttonBackgroundColor:
          context.appColors.navigationBackground,

          backgroundColor: Colors.transparent,

          animationCurve: Curves.easeInOut,

          animationDuration:
          const Duration(milliseconds: 600),

          onTap: _goBranch,

          letIndexChange: (index) => true,
        )
            : null,

        drawerEnableOpenDragGesture: false,

        drawer: SafeArea(
          child: buildDrawer(width, context),
        ),

        body: Container(
          color: Colors.transparent,
          child: widget.navigationShell,
        ),
      ),
    );
  }
}
