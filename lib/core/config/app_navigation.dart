import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/features/feature_academy/presentation/screen/health_screen.dart';
import 'package:rozeh_project/features/feature_calender/presentation/screen/calender_screen.dart';
import 'package:rozeh_project/features/feature_help/presentation/screen/help_screen.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/screen/main_wrapper.dart';
import 'package:flutter/material.dart';


class AppNavigation {
  AppNavigation._();

  static String initial = HomeScreen.routePath;

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();


  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );

  static final _shellNavigatorCalender = GlobalKey<NavigatorState>(
    debugLabel: 'shellCalender',
  );

  static final _shellNavigatorAcademy = GlobalKey<NavigatorState>(
    debugLabel: 'shellAcademy',
  );
  static final _shellNavigatorHelp = GlobalKey<NavigatorState>(
    debugLabel: 'shellHelp',
  );


  static List<GlobalKey<NavigatorState>>? t;

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: HomeScreen.routePath,
                name: "Home",
                builder:
                    (BuildContext context, GoRouterState state) => HomeScreen(),
                routes: [

                ],
              ),
            ],
          ),

          /// Brach Calender
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCalender,
            routes: <RouteBase>[
              GoRoute(
                path: CalenderScreen.routePath,
                name: "Calender",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        const CalenderScreen(),
                routes: [




                ],
              ),
            ],
          ),


          /// Brach Academy
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAcademy,
            routes: <RouteBase>[
              GoRoute(
                path: AcademyScreen.routePath,
                name: "Academy",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        AcademyScreen(),
                routes: [],
              ),
            ],
          ),

          /// Brach Help
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHelp,
            routes: <RouteBase>[
              GoRoute(
                path: HelpScreen.routePath,
                name: "Help",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        const HelpScreen(),
                routes: [],
              ),
            ],
          ),
        ],
      ),

      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: EditProfileScreen.routePath,
      //   name: EditProfileScreen.routeName,
      //   pageBuilder:
      //       (context, state) => CustomTransitionPage<void>(
      //         key: state.pageKey,
      //         child: const EditProfileScreen(),
      //         transitionsBuilder:
      //             (context, animation, secondaryAnimation, child) =>
      //                 FadeTransition(opacity: animation, child: child),
      //       ),
      // ),
    ],
  );
}
