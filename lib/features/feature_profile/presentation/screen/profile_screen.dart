import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_profile/data/model/customer_info_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/profile_model_for_send.dart';
import 'package:rozeh_project/features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'package:rozeh_project/locator.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';

class ProfileScreen extends StatefulWidget {
  static const routePath = "profile_screen";
  static const routeName = "profile_screen";

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setMobile();
    BlocProvider.of<ProfileBloc>(context).add(GetCustomerInfoEvent());

  }

  Future<void> setMobile() async {
    UserSession session = locator();
    String? mobile = await session.getMobile();
    if (mobile != null && mobile.startsWith('0')) {
      mobile = mobile.substring(1);
    }
    mobileController.text = (mobile ?? "").toPersianDigit();
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
          color: context.appColors.inputBackground,
          child: Column(
            children: [
              BlocListener<ProfileBloc, ProfileState>(
                listenWhen:
                    (previous, current) =>
                        previous.customerInfoStatus !=
                        current.customerInfoStatus,
                listener: (context, state) {
                  // TODO: implement listener

                  if (state.customerInfoStatus is CustomerInfoStatusError) {
                    CustomerInfoStatusError customerInfoStatusError =
                        state.customerInfoStatus as CustomerInfoStatusError;
                    SnackbarHelper.show(
                      context: context,
                      message: customerInfoStatusError.message!,
                      status: SnackbarStatus.error,
                    );
                  }

                  if (state.customerInfoStatus is CustomerInfoStatusCompleted) {
                    CustomerInfoStatusCompleted customerInfoStatusCompleted =
                        state.customerInfoStatus as CustomerInfoStatusCompleted;

                    CustomerInfoModel customerInfoModel =
                        customerInfoStatusCompleted.customerInfoModel;
                    setState(() {
                      fullNameController.text =
                          customerInfoModel.data?.fullName ?? "";
                      telephoneController.text =
                          customerInfoModel.data?.telephone ?? "";
                      nationalCodeController.text =
                          (customerInfoModel.data?.nationalCode ?? "")
                              .toPersianDigit();


                    });
                  }
                },
                child: CustomAppBarBackBtn(

                  mainContext: context,
                  title: "پروفایل کاربر",


                ),
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
                          color: context.appColors.appBarSecondary,
                        ),
                      ),
                      Positioned(
                        top: height * 0.2,
                        right: 0,
                        child: SvgPicture.asset(
                          height: height * 0.35,
                          "assets/images/mandala (1).svg",
                          color: context.appColors.appBarSecondary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: width,
                          height: height,
                          decoration: BoxDecoration(

                            color: context.appColors.navigationBackground,
                            border: BoxBorder.all(color: context.appColors.border),
                            boxShadow: [
                              BoxShadow(
                                color: context.appColors.warning.withValues(alpha: 0.8),
                                blurRadius: 5.3,
                                offset: Offset(0, 2),
                              ),
                            ],
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
                                    color: context.appColors.textPrimary,
                                  ),
                                  const SizedBox(height: 10),
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
                                  const SizedBox(height: 20),
                                  TxtTitle(
                                    text: "کدملی",
                                    color: context.appColors.textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    isCodeNational: true,
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
                                  const SizedBox(height: 20),
                                  TxtTitle(
                                    text: "شماره تماس",
                                    color: context.appColors.textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    isTextStart: true,
                                    isShowText: true,
                                    readOnly: true,
                                    controller: mobileController,
                                  ),
                                  const SizedBox(height: 20),

                                  TxtTitle(
                                    text: "تلفن منزل (با پیش شماره)",
                                    color: context.appColors.textPrimary,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    isTextStart: true,
                                    isShowText: false,
                                    readOnly: false,
                                    controller: telephoneController,
                                  ),

                                  const SizedBox(height: 20),
                                  BlocConsumer<ProfileBloc, ProfileState>(
                                    buildWhen:
                                        (previous, current) =>
                                            previous.updateProfileStatus !=
                                            current.updateProfileStatus,
                                    listenWhen:
                                        (previous, current) =>
                                            previous.updateProfileStatus !=
                                            current.updateProfileStatus,
                                    listener: (context, state) {
                                      // TODO: implement listener

                                      if (state.updateProfileStatus
                                          is UpdateProfileStatusError) {
                                        UpdateProfileStatusError
                                        updateProfileStatusError =
                                            state.updateProfileStatus
                                                as UpdateProfileStatusError;
                                        SnackbarHelper.show(
                                          context: context,
                                          message:
                                              updateProfileStatusError.message!,
                                          status: SnackbarStatus.error,
                                        );
                                      }

                                      if (state.updateProfileStatus
                                          is UpdateProfileStatusCompleted) {
                                        SnackbarHelper.show(
                                          context: context,
                                          message:
                                              "پروفایل با موفقیت بروزرسانی شد",
                                          status: SnackbarStatus.success,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state.updateProfileStatus
                                          is UpdateProfileStatusLoading) {
                                        return DotLoadingWidget(size: 50);
                                      }

                                      return CustomBtnGradient(
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();

                                          if (_formKey.currentState!
                                              .validate()) {


                                            ProfileModelForSend
                                            profileModelForSend =
                                                ProfileModelForSend(
                                                  fullName:
                                                      fullNameController.text
                                                          .trim(),
                                                  nationalCode:
                                                      nationalCodeController
                                                          .text
                                                          .trim()
                                                          .toEnglishDigit(),
                                                  telephone:
                                                      telephoneController.text
                                                          .trim(),
                                                );
                                            BlocProvider.of<ProfileBloc>(
                                              context,
                                            ).add(
                                              UpdateProfileEvent(
                                                profileModelForSend:
                                                    profileModelForSend,
                                              ),
                                            );
                                          }
                                        },
                                        title: "ثبت و ویرایش اطلاعات",
                                      );
                                    },
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
