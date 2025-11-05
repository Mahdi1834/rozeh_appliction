import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:rozeh_project/features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/bloc/reservation_bloc.dart';
import 'package:rozeh_project/locator.dart';
import 'package:rozeh_project/core/config/app_navigation.dart';
import 'package:rozeh_project/core/config/theme_provider.dart';
import 'package:rozeh_project/core/config/string.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: ConsColors.blueBg2,
    statusBarIconBrightness: Brightness.dark,
  ));

  await initLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<LoginBloc>()),
        BlocProvider(create: (_) => locator<HomeBloc>()),
        BlocProvider(create: (_) => locator<ProfileBloc>()),
        BlocProvider(create: (_) => locator<ReservationBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( // 🔥 این ویجت جهت متن کل اپ رو کنترل می‌کنه
      textDirection: TextDirection.rtl, // به‌صورت پیش‌فرض راست‌چین
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: ConsString.appName,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppNavigation.router,

        locale: const Locale("fa", "IR"),
        supportedLocales: const [
          Locale("fa", "IR"),
          Locale("en", "US"),
        ],
        localizationsDelegates: const [
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
