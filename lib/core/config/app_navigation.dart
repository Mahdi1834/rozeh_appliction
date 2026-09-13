import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/features/feature_help/presentation/screen/help_screen.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/screen/address_screen.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/screen/list_address_screen.dart';
import 'package:rozeh_project/features/feature_list_profile/presentation/screen/profile_menu_screen.dart';
import 'package:rozeh_project/features/feature_mainwrapper/presentation/screen/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/otp_screen.dart';
import 'package:rozeh_project/features/feature_profile/presentation/screen/profile_screen.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/screen/reservation_screen.dart';
import 'package:rozeh_project/features/feature_shrine/presentation/screen/shrine_screen.dart';

import 'package:rozeh_project/features/feature_splash/presentation/screen/splash_screen.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';

class AppNavigation {
  AppNavigation._();

  // static String initial = HomeScreen.routePath;
  static String initial = SplashScreen.routePath;

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'shellHome',
  );

  static final _shellNavigatorReservation = GlobalKey<NavigatorState>(
    debugLabel: 'shellReservation',
  );

  static final _shellNavigatorShrine = GlobalKey<NavigatorState>(
    debugLabel: 'shellShrine',
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
      GoRoute(
        path: SplashScreen.routePath,
        builder: (context, state) => const SplashScreen(),
      ),

      /// صفحه Login
      GoRoute(
        path: LoginScreen.routePath,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: OtpScreen.routePath,
        builder: (context, state) {
          final phone = state.extra as String;
          return OtpScreen(phone: phone);
        },
      ),

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
                routes: [],
              ),
            ],
          ),

          /// Brach reservation
          StatefulShellBranch(
            navigatorKey: _shellNavigatorReservation,
            routes: <RouteBase>[
              GoRoute(
                path: ReservationScreen.routePath,
                name: "Reservation",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        const ReservationScreen(),
                routes: [],
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _shellNavigatorShrine,
            routes: <RouteBase>[
              GoRoute(
                path: ShrineScreen.routePath,
                name: "Shrine",
                builder:
                    (BuildContext context, GoRouterState state) =>
                        const ShrineScreen(),
                routes: [],
              ),
            ],
          ),

          /// Brach profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: <RouteBase>[
              GoRoute(
                path: ProfileMenuScreen.routePath,
                name: ProfileMenuScreen.routeName,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        ProfileMenuScreen(),
                routes: [
                  GoRoute(
                    path: ProfileScreen.routePath,
                    name: ProfileScreen.routeName,
                    pageBuilder:
                        (context, state) => CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const ProfileScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                        ),
                  ),

                  GoRoute(
                    path: ListAddressScreen.routePath,
                    name: ListAddressScreen.routeName,
                    pageBuilder:
                        (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const ListAddressScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                            opacity: animation,
                            child: child,
                          ),

                    ),
                    routes: [
                      GoRoute(
                        path: AddressScreen.routePath,
                        name: AddressScreen.routeName,
                        pageBuilder:
                            (context, state) => CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: const AddressScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                        ),
                      ),

                    ]
                  ),
                ],
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
    ],
  );
}
