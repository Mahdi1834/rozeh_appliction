import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/locator.dart';

class ProfileScreen extends StatefulWidget {
  static const routePath = "/profile_screen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? selectedProvince;
  String? selectedCity;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMobile();
  }

  Future<void> setMobile() async {
    UserSession session = locator();

    String? mobile = await session.getMobile();

    if (mobile != null && mobile.startsWith('0')) {
      mobile = mobile.substring(1); // 👈 حذف صفر اول
    }

    mobileController.text = mobile ?? "";
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
              CustomAppBarWithSearch(
                mainContext: context,
                title: "پروفایل کاربر",
                onTapSearch: () {},
              ),

              Expanded(
                child: SizedBox(
                  width: width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: height * 0.2,
                        left: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala.svg",
                        ),
                      ),
                      Positioned(
                        top: height * 0.2,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TxtTitle(
                                    text: "نام و نام خانوادگی",
                                    color: ConsColors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextField(
                                    isTextStart: true,
                                    controller: fullNameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "نام و نام خانوادگی الزامی است";
                                      }
                                      return null;
                                    },
                                  ),
                                  //////
                                  SizedBox(height: 20),
                                  TxtTitle(
                                    text: "کدملی",
                                    color: ConsColors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    isTextStart: true,
                                    controller: nationalCodeController,
                                    validator: (value) {
                                      if (value != null &&
                                          value.isNotEmpty &&
                                          value.length != 10) {
                                        return "کد ملی باید ۱۰ رقم باشد";
                                      }
                                      return null;
                                    },
                                  ),
                                  /////
                                  SizedBox(height: 20),
                                  TxtTitle(
                                    text: "شماره تماس",
                                    color: ConsColors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    isTextStart: true,
                                    isShowText: true,
                                    readOnly: true,
                                    controller: mobileController,
                                  ),

                                  ///
                                  SizedBox(height: 20),
                                  TxtTitle(
                                    text: "استان",
                                    color: ConsColors.blue,
                                  ),
                                  SizedBox(height: 10),

                                  CustomDropdownField<String>(
                                    value: selectedProvince,
                                    items:
                                        [
                                              'تهران',
                                              'اصفهان',
                                              'شیراز',
                                              'مشهد',
                                              'تبریز',
                                            ]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProvince = value;
                                      });
                                    },
                                  ),

                                  SizedBox(height: 20),
                                  TxtTitle(text: "شهر", color: ConsColors.blue),
                                  SizedBox(height: 10),
                                  CustomDropdownField<String>(
                                    value: selectedProvince,
                                    items:
                                        [
                                              'تهران',
                                              'اصفهان',
                                              'شیراز',
                                              'مشهد',
                                              'تبریز',
                                            ]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCity = value;
                                      });
                                    },
                                  ),

                                  /////
                                  SizedBox(height: 20),
                                  TxtTitle(
                                    text: "ادرس دقیق",
                                    color: ConsColors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    isTextStart: true,
                                    controller: addressController,
                                  ),
                                  SizedBox(height: 20),
                                  CustomBtnGradient(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        print("✅ فرم معتبره و میشه ارسال کرد");
                                      }
                                    },
                                    title: "ثبت و ویرایش اطلاعات",
                                  ),
                                ],
                              ),
                            ),
                          ),
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
