import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/utils/device_info_helper.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';
import 'package:rozeh_project/features/feature_login/data/model/verify_code_model.dart';
import 'package:rozeh_project/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:rozeh_project/locator.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_out_icon.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class OtpScreen extends StatefulWidget {
  static const routePath = '/otp_screen';
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final SmartAuth _smartAuth = SmartAuth.instance;

  int _secondsRemaining = 300;
  Timer? _timer;

  late String deviceName = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
    _listenForSmsCode(); // 👂 شروع شنود برای OTP
  }

  /// 📩 وقتی پیام OTP برسه، اندروید پنجره Allow / Deny رو نمایش میده
  Future<void> _listenForSmsCode() async {
    try {
      final res = await _smartAuth.getSmsWithUserConsentApi();

      if (res.hasData) {
        final code = res.requireData.code;

        if (code == null) {
          if (kDebugMode) {
            print("⚠️ پیام دریافت شد ولی کد OTP استخراج نشد.");
          }
          return;
        }

        if (kDebugMode) {
          print("📩 OTP code received: $code");
        }
        setState(() {
          _pinController.text = code;
        });

        _verifyCode(code); // تایید خودکار
      } else if (res.isCanceled) {
        if (kDebugMode) {
          print("🚫 کاربر اجازه‌ی خواندن پیام را نداد (Denied).");
        }
      } else {
        if (kDebugMode) {
          print("❌ خطا در User Consent API: ${res.error}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Exception در getSmsWithUserConsentApi: $e");
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  _resendCode() {
    BlocProvider.of<LoginBloc>(
      context,
    ).add(SendVerificationCodeEvent(mobile: widget.phone));
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  Future<void> _verifyCode(String code) async {
    if (kDebugMode) {
      print('🔒 Verifying code: $code');
    }
    deviceName = await DeviceInfoHelper.getDeviceName();
    BlocProvider.of<LoginBloc>(context).add(
      VerifyCodeEvent(mobile: widget.phone, code: code, deviceName: deviceName),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
        color: context.appColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontFamily: 'IRANSansX',
        fontSize: 18,
      ),
      decoration: BoxDecoration(
        color: context.appColors.textSecondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.inputBackground,
          child: Column(
            children: [
              CustomAppBarWithOutIcon(
                mainContext: context,
                title: "رزرو روضه و مجالس خانگی",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.2),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TxtTitle(text: "کد تایید", color: context.appColors.textPrimary),
                            const SizedBox(height: 18),

                            /// 🔹 فیلد کد تایید با Pinput و AutoFill داخلی
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Pinput(
                                length: 6,
                                controller: _pinController,
                                focusNode: _pinFocusNode,
                                keyboardType: TextInputType.number,
                                autofillHints: const [
                                  AutofillHints.oneTimeCode,
                                ],
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: context.appColors.textPrimary.withValues(
                                      alpha: 0.25,
                                    ),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                submittedPinTheme: defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: context.appColors.inputBackground,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                errorPinTheme: defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                showCursor: true,
                                onCompleted: (value) => _verifyCode(value),
                              ),
                            ),

                            const SizedBox(height: 24),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state.loginVerificationStatusStatus
                                    is LoginVerificationStatusCompleted) {
                                  LoginVerificationStatusCompleted
                                  loginVerificationStatusCompleted =
                                      state.loginVerificationStatusStatus
                                          as LoginVerificationStatusCompleted;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TxtTitle(
                                        text: "کد ورود شما : ",
                                        color: context.appColors.textPrimary,
                                      ),
                                      TxtTitle(
                                        text:
                                            loginVerificationStatusCompleted
                                                .loginModel
                                                .data
                                                ?.code ??
                                            "",
                                        color: context.appColors.warning,
                                      ),
                                    ],
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),

                            Center(
                              child: GestureDetector(
                                onTap:
                                    _secondsRemaining == 0
                                        ? () {
                                          /// 👇 وقتی تایمر تموم شد، کاربر می‌تونه دوباره درخواست بده
                                          _resendCode();
                                        }
                                        : null, // در حال شمارش، غیرفعاله
                                child: Text(
                                  _secondsRemaining > 0
                                      ? "ارسال مجدد کد تا $_formattedTime"
                                      : "ارسال مجدد کد",
                                  style: TextStyle(
                                    color:
                                        _secondsRemaining > 0
                                            ? context.appColors.textSecondary
                                            : context.appColors.textPrimary,
                                    fontFamily: 'IRANSansX',
                                    fontSize: 13,
                                    decoration:
                                        _secondsRemaining == 0
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            BlocConsumer<LoginBloc, LoginState>(
                              buildWhen: (previous, current) {
                                return previous.verifyCodeStatus !=
                                    current.verifyCodeStatus;
                              },
                              listenWhen: (previous, current) {
                                return previous.verifyCodeStatus !=
                                    current.verifyCodeStatus;
                              },
                              listener: (context, state) async {
                                if (state.verifyCodeStatus
                                    is VerifyCodeStatusCompleted) {
                                  VerifyCodeStatusCompleted
                                  verifyCodeStatusCompleted =
                                      state.verifyCodeStatus
                                          as VerifyCodeStatusCompleted;

                                  VerifyCodeModel verifyCodeModel =
                                      verifyCodeStatusCompleted.verifyCodeModel;
                                  UserSession userSession = locator();
                                  await Future.wait([
                                    userSession.setMobile(
                                      verifyCodeModel.data!.customer!.mobile!,
                                    ),
                                    userSession.setToken(
                                      verifyCodeModel.data!.token!,
                                    ),
                                  ]);

                                  context.go(HomeScreen.routePath);
                                }

                                if (state.verifyCodeStatus
                                    is VerifyCodeStatusError) {
                                  VerifyCodeStatusError verifyCodeStatusError =
                                      state.verifyCodeStatus
                                          as VerifyCodeStatusError;

                                  SnackbarHelper.show(
                                    context: context,
                                    message: verifyCodeStatusError.message!,
                                    status: SnackbarStatus.error,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state.verifyCodeStatus
                                    is LoginVerificationStatusLoading) {
                                  return DotLoadingWidget(size: 50);
                                }

                                return CustomBtnGradient(
                                  onPressed: () {
                                    final code = _pinController.text;
                                    if (code.length == 6) _verifyCode(code);
                                  },
                                  title: "ورود",
                                );
                              },
                            ),
                            BlocListener<LoginBloc, LoginState>(
                              listenWhen: (previous, current) {
                                return previous.loginVerificationStatusStatus !=
                                    current.loginVerificationStatusStatus;
                              },

                              listener: (context, state) {
                                if (state.loginVerificationStatusStatus
                                    is LoginVerificationStatusCompleted) {
                                  _startTimer();
                                }
                                if (state.loginVerificationStatusStatus
                                    is LoginVerificationStatusError) {
                                  LoginVerificationStatusError
                                  loginVerificationStatusError =
                                      state.loginVerificationStatusStatus
                                          as LoginVerificationStatusError;
                                  SnackbarHelper.show(
                                    context: context,
                                    message:
                                        loginVerificationStatusError.message!,
                                    status: SnackbarStatus.error,
                                  );
                                }
                              },
                              child: SizedBox.shrink(),
                            ),
                          ],
                        ),
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
}
