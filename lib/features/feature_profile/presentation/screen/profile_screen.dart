import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_profile/data/model/customer_info_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/profile_model_for_send.dart';
import 'package:rozeh_project/features/feature_profile/presentation/bloc/profile_bloc.dart';
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
    super.initState();
    setMobile();
    BlocProvider.of<ProfileBloc>(context).add(GetCustomerInfoEvent());
    BlocProvider.of<ProfileBloc>(context).add(GetProvincesEvent());
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
          color: ConsColors.blueLight,
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
                      addressController.text =
                          customerInfoModel.data?.address ?? "";
                      nationalCodeController.text =
                          (customerInfoModel.data?.nationalCode ?? "")
                              .toPersianDigit();
                      selectedProvince =
                          (customerInfoModel.data?.provinceId ?? "").toString();
                      selectedCity =
                          (customerInfoModel.data?.cityId ?? "").toString();
                      if (customerInfoModel.data?.provinceId != null ||
                          (customerInfoModel.data?.provinceId ?? "")
                              .toString()
                              .isNotEmpty)
                        BlocProvider.of<ProfileBloc>(context).add(
                          GetCitiesEvent(
                            provinceId:
                                customerInfoModel.data!.provinceId.toString(),
                          ),
                        );
                    });
                  }
                },
                child: CustomAppBarWithSearch(
                  mainContext: context,
                  title: "پروفایل کاربر",
                  onTapSearch: () {},
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
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
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
                                    color: ConsColors.blue,
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
                                    color: ConsColors.blue,
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
                                    text: "استان",
                                    color: ConsColors.blue,
                                  ),
                                  const SizedBox(height: 10),

                                  // Dropdown استان
                                  BlocConsumer<ProfileBloc, ProfileState>(
                                    listenWhen:
                                        (previous, current) =>
                                            previous.provincesStatus !=
                                            current.provincesStatus,
                                    buildWhen:
                                        (previous, current) =>
                                            previous.provincesStatus !=
                                            current.provincesStatus,
                                    listener: (context, state) {
                                      if (state.provincesStatus
                                          is ProvincesStatusError) {
                                        final provincesStatusError =
                                            state.provincesStatus
                                                as ProvincesStatusError;
                                        SnackbarHelper.show(
                                          context: context,
                                          message:
                                              provincesStatusError.message!,
                                          status: SnackbarStatus.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state.provincesStatus
                                          is ProvincesStatusLoading) {
                                        return const DotLoadingWidget(size: 30);
                                      }
                                      if (state.provincesStatus
                                          is ProvincesStatusError) {
                                        return Center(
                                          child: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<ProfileBloc>(
                                                context,
                                              ).add(GetProvincesEvent());
                                            },
                                            icon: const Icon(
                                              Icons.refresh,
                                              color: ConsColors.blue,
                                            ),
                                          ),
                                        );
                                      }
                                      if (state.provincesStatus
                                          is ProvincesStatusCompleted) {
                                        final provincesStatusCompleted =
                                            state.provincesStatus
                                                as ProvincesStatusCompleted;
                                        final provincesModel =
                                            provincesStatusCompleted
                                                .provincesModel;

                                        // بررسی مقدار انتخاب شده معتبره یا نه
                                        if (selectedProvince != null &&
                                            !provincesModel.data!.any(
                                              (p) =>
                                                  p.id.toString() ==
                                                  selectedProvince,
                                            )) {
                                          selectedProvince = null;
                                          selectedCity = null;
                                        }

                                        return CustomDropdownField<String>(
                                          value: selectedProvince,
                                          items:
                                              provincesModel.data!
                                                  .map(
                                                    (province) =>
                                                        DropdownMenuItem<
                                                          String
                                                        >(
                                                          value:
                                                              province.id
                                                                  .toString(),
                                                          child: Text(
                                                            province.name ??
                                                                "-",
                                                          ),
                                                        ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedProvince = value;
                                              selectedCity =
                                                  null; // ریست کردن شهر
                                            });
                                            BlocProvider.of<ProfileBloc>(
                                              context,
                                            ).add(
                                              GetCitiesEvent(
                                                provinceId: value!,
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),

                                  const SizedBox(height: 20),
                                  TxtTitle(text: "شهر", color: ConsColors.blue),
                                  const SizedBox(height: 10),

                                  // Dropdown شهر
                                  BlocBuilder<ProfileBloc, ProfileState>(
                                    buildWhen:
                                        (previous, current) =>
                                            previous.citiesStatus !=
                                            current.citiesStatus,
                                    builder: (context, state) {
                                      if (state.citiesStatus
                                          is CitiesStatusLoading) {
                                        return const DotLoadingWidget(size: 30);
                                      }
                                      if (state.citiesStatus
                                          is CitiesStatusCompleted) {
                                        final citiesStatusCompleted =
                                            state.citiesStatus
                                                as CitiesStatusCompleted;
                                        final cities =
                                            citiesStatusCompleted
                                                .citiesModel
                                                .data ??
                                            [];

                                        // بررسی مقدار انتخاب شده معتبره یا نه
                                        if (selectedCity != null &&
                                            !cities.any(
                                              (c) =>
                                                  c.id.toString() ==
                                                  selectedCity,
                                            )) {
                                          selectedCity = null;
                                        }

                                        return CustomDropdownField<String>(
                                          value: selectedCity,
                                          items:
                                              cities
                                                  .map(
                                                    (city) => DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: city.id.toString(),
                                                      child: Text(
                                                        city.name ?? "-",
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCity = value;
                                            });
                                          },
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),

                                  const SizedBox(height: 20),
                                  TxtTitle(
                                    text: "ادرس دقیق",
                                    color: ConsColors.blue,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    textInputType: TextInputType.multiline,
                                    isTextStart: true,
                                    controller: addressController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "آدرس الزامی است";
                                      }
                                      return null;
                                    },
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
                                            if (selectedProvince == null ||
                                                selectedProvince!.isEmpty) {
                                              SnackbarHelper.show(
                                                context: context,
                                                message:
                                                    "لطفا استان را انتخاب کنید",
                                                status: SnackbarStatus.error,
                                              );
                                              return;
                                            }
                                            if (selectedCity == null ||
                                                selectedCity!.isEmpty) {
                                              SnackbarHelper.show(
                                                context: context,
                                                message:
                                                    "لطفا شهر را انتخاب کنید",
                                                status: SnackbarStatus.error,
                                              );
                                              return;
                                            }

                                            ProfileModelForSend
                                            profileModelForSend =
                                                ProfileModelForSend(
                                                  fullName:
                                                      fullNameController.text
                                                          .trim(),
                                                  nationalCode:
                                                      nationalCodeController
                                                          .text
                                                          .trim().toEnglishDigit(),
                                                  address:
                                                      addressController.text
                                                          .trim(),
                                                  provinceId: int.parse(
                                                    selectedProvince!,
                                                  ),
                                                  cityId: int.parse(
                                                    selectedCity!,
                                                  ),
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
