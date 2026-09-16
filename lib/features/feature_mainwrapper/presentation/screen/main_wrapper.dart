import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/curved_navigation_bar.dart';
import 'package:rozeh_project/core/custom_curved_navigation_bar/src/nav_item.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/widgets/drawer.dart';

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

  /// چک می‌کنه آیا مسیر فعلی جزو مسیرهایی هست که باید bottom nav داشته باشه
  // bool _shouldShowBottomNavBar(BuildContext context) {
  //   final location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
  //
  //   final lastSegment = location.split('/').last;
  //
  //   // قسمت آخر مسیر به همراه اسلش اولش
  //   final lastSegmentWithSlash = '/$lastSegment';
  //
  //   print(location);
  //   print(lastSegmentWithSlash);
  //
  //   const allowedRouteNames = {
  //     HomeScreen.routePath,
  //     ReservationScreen.routePath,
  //     ShrineScreen.routePath,
  //     ProfileMenuScreen.routePath,
  //     HelpScreen.routePath,
  //     // "/${StartDeterminationScreen.routePath}",
  //     // هر routeName دیگری که میخوای BottomNav داشته باشه اینجا اضافه کن
  //   };
  //
  //   return allowedRouteNames.contains(lastSegmentWithSlash);
  // }



  bool _shouldShowBottomNavBar(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    debugPrint('BottomNav location: $location');

    const allowedRoutes = {
      '/Home_screen',
      '/list_reservation_screen',
      '/shrine_screen',
      '/profile_menu_screen',
      '/help_screen',
    };

    return allowedRoutes.contains(location);
  }

  void _goBranch(int index) {
    // if (index == widget.navigationShell.currentIndex) {
    //   // همان شاخه، کاری نکن
    //   return;
    // }

    if (kDebugMode) {
      print("Navigating to branch $index");
      print("Current route: ${widget.navigationShell.route}");
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: false, // فقط وقتی شاخه تغییر کرد استفاده می‌کنیم
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        if (widget._key.currentState!.isDrawerOpen) {
          Navigator.of(context).pop();
          return false;
        } else {
          return true;
        }
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
                    NavItem(svgPath: 'assets/images/Home.svg', title: 'خانه'),
                    NavItem(
                      svgPath: 'assets/images/Add.svg',
                      title: 'رزرو روضه',
                    ),

                    NavItem(
                      svgPath: 'assets/images/Add.svg',
                      title: ' روضه نیابتی',
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
                  buttonBackgroundColor: context.appColors.navigationBackground,
                  backgroundColor: Colors.transparent,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(milliseconds: 600),
                  onTap: (index) => _goBranch(index),
                  letIndexChange: (index) => true,
                )
                : null,
        drawerEnableOpenDragGesture: false,
        drawer: SafeArea(child: buildDrawer(width, context)),
        body: Container(
          color: Colors.transparent,
          child: widget.navigationShell,
        ),
      ),
    );
  }
}
