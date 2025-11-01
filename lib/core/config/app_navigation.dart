import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/features/feature_help/presentation/screen/help_screen.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/screen/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/screen/reservation_screen.dart';
import 'package:rozeh_project/features/profile_academy/presentation/screen/profile_screen.dart';


class AppNavigation {
  AppNavigation._();

  static String initial = HomeScreen.routePath;

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();


  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );

  static final _shellNavigatorReservation = GlobalKey<NavigatorState>(
    debugLabel: 'shellReservation',
  );

  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(
    debugLabel: 'shellProfile',
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
            navigatorKey: _shellNavigatorReservation,
            routes: <RouteBase>[
              GoRoute(
                path: ReservationScreen.routePath,
                name: "Reservation",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        const ReservationScreen(),
                routes: [




                ],
              ),
            ],
          ),


          /// Brach Academy
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: ProfileScreen.routePath,
                name: "profile",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        ProfileScreen(),
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
