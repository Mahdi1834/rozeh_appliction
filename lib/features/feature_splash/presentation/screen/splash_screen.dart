import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_login/presentation/screen/login_screen.dart';
import 'package:rozeh_project/locator.dart';

class SplashScreen extends StatefulWidget {
  static const routePath = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🎞️ انیمیشن Fade-in
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // تا انیمیشن تموم شه یه تاخیر کوچیک بده
    await Future.delayed(const Duration(seconds: 2));

    final userSession = locator<UserSession>();
    final isLoggedIn = userSession.isLoggedIn();

    await Future.delayed(const Duration(milliseconds: 800)); // جلوه طبیعی‌تر

    if (mounted) {
      if (isLoggedIn) {
        context.go(HomeScreen.routePath);
      } else {
        context.go(LoginScreen.routePath);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // 🔹 لوگوی اپ (می‌تونی آیکن برندت رو بذاری)
              // Image.asset(
              //   'assets/images/logo.png',
              //   width: 110,
              //   height: 110,
              // ),

              const SizedBox(height: 16),

          // 🔹 نام اپلیکیشن
          // Text(
          //   "Rozeh App",
          //   style: theme.textTheme.titleLarge?.copyWith(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 22,
          //     color: Colors.blue.shade800,
          //     letterSpacing: 1.2,
          //   ),
          // ),


          // 🔹 نوشته زیر لوگو
          Text(
            "رزرو روضه و مجالس خانگی",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: ConsColors.blue,
            ),
          ),
          const SizedBox(height: 8),
          DotLoadingWidget(size: 50),
          ],
        ),
      ),
    ),);
  }
}
