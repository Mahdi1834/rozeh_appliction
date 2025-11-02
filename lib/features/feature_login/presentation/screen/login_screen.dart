// lib/features/feature_login/presentation/screen/login_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_out_icon.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';

import 'package:rozeh_project/features/feature_otp/presentation/screen/otp_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:rozeh_project/features/feature_home/presentation/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routePath = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'sample_token');
    if (!mounted) return;
    context.go(HomeScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: ConsColors.blueLight,

          child: Column(
            children: [
              CustomAppBarWithOutIcon(
                mainContext: context,
                title: "رزرو روضه و مجالس خانگی",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.2),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        width: width,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TxtTitle(text: "شماره همراه", color: ConsColors.blue),
                            SizedBox(height: 10),
                            CustomTextField(
                              hintText: "9171112233" ,
                              controller: _phoneController,
                              isShowText: true,
                              textInputType: TextInputType.phone,
                            ),
                            SizedBox(height: 20),
                            CustomBtnGradient(onPressed: (){
                              if(_phoneController.text.isNotEmpty) {
                                context.push(OtpScreen.routePath,
                                    extra: _phoneController.text);
                              }else{
                                SnackbarHelper.show(
                                  context: context,
                                  message: "شماره تلفن رو وارد کنید",
                                  status: SnackbarStatus.info,
                                );

                              }
                            }, title: "دریافت کد یکبار مصرف")
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
