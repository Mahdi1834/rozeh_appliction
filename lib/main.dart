import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:rozeh_project/locator.dart';
import 'package:rozeh_project/core/config/app_navigation.dart';
import 'package:rozeh_project/core/config/theme_provider.dart';
import 'package:rozeh_project/core/config/string.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';



Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ConsColors.blueBg2,
    statusBarIconBrightness:Brightness.dark,

  ));
  await initLocator();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<LoginBloc>()),
      ],
      child: const MyApp()),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: ConsString.appName,
      theme: MyThemes.lightTheme,
      themeMode: ThemeMode.light,
      darkTheme: MyThemes.darkTheme,
      routerConfig: AppNavigation.router,

      locale: const Locale("fa", "IR"), // زبان پیش‌فرض (فارسی)
      supportedLocales: const [
        Locale("fa", "IR"),
        Locale("en", "US"), // انگلیسی (در صورت نیاز)
      ],
      localizationsDelegates: const [
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

    );
  }
}
