import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rozeh_project/core/config/colors.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_search.dart';
import 'package:rozeh_project/core/widgets/card_with_button_in_dip.dart';
import 'package:rozeh_project/core/widgets/custom_btn.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_send_model.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/bloc/reservation_bloc.dart';

class ReservationScreen extends StatefulWidget {
  static const routePath = "/reservation_screen";

  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String? selectedMaddah;
  String? selectedMaddahName;
  String? selectedSpeaker;
  String? selectedSpeakerName;
  String? selectedType;
  String? selectedTypeName;
  String? selectedAgeGroup;
  String? selectedAgeGroupName;
  String? selectedGender;
  String? selectedGenderName;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<ReservationBloc>(context);
    bloc.add(GetMaddahEvent());
    bloc.add(GetSpeakerEvent());
    bloc.add(GetRozehTypeEvent());
    bloc.add(GetAgeGroupEvent());
  }

  void _onSubmit() {
    if ((selectedMaddah == null &&
            selectedSpeaker == null) || // حداقل یکی انتخاب شود
        selectedType == null ||
        selectedGender == null ||
        selectedAgeGroup == null ||
        dateController.text.isEmpty ||
        startTimeController.text.isEmpty) {
      SnackbarHelper.show(
        context: context,
        message: "لطفاً تمام فیلدهای ضروری را پر کنید.",
        status: SnackbarStatus.error,
      );
      return;
    }

    // تبدیل تاریخ Jalali به میلادی
    final jalaliParts = dateController.text.split("/"); // ["1404","08","14"]
    final jalaliDate = Jalali(
      int.parse(jalaliParts[0]),
      int.parse(jalaliParts[1]),
      int.parse(jalaliParts[2]),
    );
    final gregorianDate = jalaliDate.toGregorian(); // تبدیل به میلادی
    final formattedDate =
        "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";

    final userIds = <int>[];
    if (selectedMaddah != null) userIds.add(int.parse(selectedMaddah!));
    if (selectedSpeaker != null) userIds.add(int.parse(selectedSpeaker!));


    final rozehRequest = RozehRequestSendModel(
      rozehId: int.parse(selectedType!),
      ageGroupId: int.parse(selectedAgeGroup!),
      gender: selectedGender!,
      date: formattedDate,
      // میلادی شده
      userIds: userIds,
      startTime: startTimeController.text,
      endTime: endTimeController.text.isEmpty ? null : endTimeController.text,
      description:
          descriptionController.text.isEmpty
              ? null
              : descriptionController.text,
    );

    BlocProvider.of<ReservationBloc>(
      context,
    ).add(StoreRozehRequestEvent(rozehRequestSendModel: rozehRequest));
  }

  /// ⛅ انتخاب تاریخ شمسی
  Future<void> _selectDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
      initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
      // initialDatePickerMode: PersianDatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        final year = picked.year.toString();
        final month = picked.month.toString().padLeft(2, '0');
        final day = picked.day.toString().padLeft(2, '0');

        dateController.text = "$year/$month/$day";
      });
    }
  }

  /// ⏰ انتخاب زمان شروع یا پایان
  Future<void> _selectTime(TextEditingController controller) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );

    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
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
                title: "فرم ثبت درخواست رزرو",
                onTapSearch: () {},
              ),
              Expanded(
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
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        // غیر فعال کردن کشیدن دستی
                        children: [
                          buildSingleChildScrollViewLevel1(context, width),
                          buildSingleChildScrollViewLevel2(context, width),
                          buildSingleChildScrollViewLevel3(context, width),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSingleChildScrollViewLevel1(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------- انتخاب مداح -----------
            TxtTitle(text: "انتخاب مداح", color: ConsColors.blue),
            const SizedBox(height: 10),
            _buildMaddahDropdown(context),
            const SizedBox(height: 20),

            // ----------- انتخاب سخنران -----------
            TxtTitle(text: "انتخاب سخنران", color: ConsColors.blue),
            const SizedBox(height: 10),
            _buildSpeakerDropdown(context),
            const SizedBox(height: 20),
            // ----------- تاریخ -----------
            TxtTitle(text: "تاریخ", color: ConsColors.blue),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: CustomTextField(
                  isTextStart: true,
                  readOnly: true,
                  controller: dateController,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      size: 16,
                      Icons.calendar_month_rounded,
                      color: ConsColors.orange,
                    ),
                    onPressed: _selectDate,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ----------- زمان شروع و پایان -----------
            TxtTitle(text: "زمان شروع", color: ConsColors.blue),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectTime(startTimeController),
              child: AbsorbPointer(
                child: CustomTextField(
                  isTextStart: true,
                  readOnly: true,
                  controller: startTimeController,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      size: 16,
                      Icons.access_time,
                      color: ConsColors.orange,
                    ),
                    onPressed: _selectDate,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ----------- انتخاب نوع مراسم -----------
            TxtTitle(text: "نوع مراسم", color: ConsColors.blue),
            const SizedBox(height: 10),
            _buildRozehTypeDropdown(context),
            const SizedBox(height: 20),

            // ----------- انتخاب گروه سنی -----------
            TxtTitle(text: "رنج سنی شرکت کنندگان", color: ConsColors.blue),
            const SizedBox(height: 10),
            _buildAgeGroupDropdown(context),
            const SizedBox(height: 20),

            // ----------- جنسیت شرکت کنندگان -----------
            TxtTitle(text: "جنسیت شرکت کنندگان", color: ConsColors.blue),
            const SizedBox(height: 10),
            _buildGenderDropdown(context),

            const SizedBox(height: 30),
            // ----------- دکمه ارسال -----------
            BlocConsumer<ReservationBloc, ReservationState>(
              listenWhen:
                  (previous, current) =>
                      previous.rozehRequestStoreStatus !=
                      current.rozehRequestStoreStatus,
              listener: (context, state) {
                if (state.rozehRequestStoreStatus
                    is RozehRequestStoreStatusError) {
                  final errorState =
                      state.rozehRequestStoreStatus
                          as RozehRequestStoreStatusError;
                  SnackbarHelper.show(
                    context: context,
                    message: errorState.message ?? "خطا در ارسال درخواست",
                    status: SnackbarStatus.error,
                  );
                }
                if (state.rozehRequestStoreStatus
                    is RozehRequestStoreStatusCompleted) {
                  SnackbarHelper.show(
                    context: context,
                    message: "درخواست با موفقیت ثبت شد 🎉",
                    status: SnackbarStatus.success,
                  );
                  BlocProvider.of<HomeBloc>(
                    context,
                  ).add(GetRozehRequestEvent(page: "1"));
                }
              },
              builder: (context, state) {
                if (state.rozehRequestStoreStatus
                    is RozehRequestStoreStatusLoading) {
                  return const Center(child: DotLoadingWidget(size: 30));
                }
                return Center(
                  child: CustomBtnGradient(
                    onPressed: () {
                      if ((selectedMaddah == null &&
                              selectedSpeaker ==
                                  null) || // حداقل یکی انتخاب شود
                          selectedType == null ||
                          selectedGender == null ||
                          selectedAgeGroup == null ||
                          dateController.text.isEmpty ||
                          startTimeController.text.isEmpty) {
                        SnackbarHelper.show(
                          context: context,
                          message: "لطفاً تمام فیلدهای ضروری را پر کنید.",
                          status: SnackbarStatus.error,
                        );
                        return;
                      }

                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    title: "ثبت و رزرو مراسم",
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSingleChildScrollViewLevel2(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "تاریخ مراسم:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: dateController.text.trim(),
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "زمان مراسم:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: startTimeController.text.trim(),
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "مداح:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: selectedMaddahName ?? "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "سخنران:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: selectedSpeakerName ?? "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "نوع مراسم:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: selectedTypeName ?? "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "مخاطبین:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: selectedGenderName ?? "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "رنج سنی:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: selectedAgeGroupName ?? "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    ///////////////////
                    Row(
                      children: [
                        TxtTitleNotBold(
                          size: 15,
                          text: "آدرس:",
                          color: ConsColors.gray,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TxtTitle(
                            size: 16,
                            text: "",
                            color: ConsColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: ConsColors.blueLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TxtTitle(
                  size: 15,
                  text: "هزینه قابل پرداخت:",
                  color: ConsColors.gray,
                ),
                SizedBox(width: 10),
                TxtTitle(size: 16, text: " 0 تومان", color: ConsColors.orange),
              ],
            ),
          ),
          const SizedBox(height: 20),

          BlocConsumer<ReservationBloc, ReservationState>(
            listenWhen:
                (previous, current) =>
                    previous.rozehRequestStoreStatus !=
                    current.rozehRequestStoreStatus,
            listener: (context, state) {
              if (state.rozehRequestStoreStatus
                  is RozehRequestStoreStatusError) {
                final errorState =
                    state.rozehRequestStoreStatus
                        as RozehRequestStoreStatusError;

                String message = errorState.message ?? "خطا در ارسال درخواست";

                // Regex برای پیدا کردن تاریخ به صورت yyyy-MM-dd
                final regex = RegExp(r'(\d{4})-(\d{2})-(\d{2})');
                final match = regex.firstMatch(message);

                if (match != null) {
                  final year = int.parse(match.group(1)!);
                  final month = int.parse(match.group(2)!);
                  final day = int.parse(match.group(3)!);

                  // تبدیل به Jalali
                  final jalaliDate = Jalali.fromGregorian(
                    Gregorian(year, month, day),
                  );
                  final formattedJalali =
                      "${jalaliDate.year}/${jalaliDate.month.toString().padLeft(2, '0')}/${jalaliDate.day.toString().padLeft(2, '0')}";

                  // جایگزین کردن تاریخ میلادی با شمسی
                  message = message.replaceFirst(regex, formattedJalali);
                }

                SnackbarHelper.show(
                  context: context,
                  message: message,
                  status: SnackbarStatus.error,
                );
              }

              if (state.rozehRequestStoreStatus
                  is RozehRequestStoreStatusCompleted) {
                SnackbarHelper.show(
                  context: context,
                  message: "درخواست با موفقیت ثبت شد 🎉",
                  status: SnackbarStatus.success,
                );
                BlocProvider.of<HomeBloc>(
                  context,
                ).add(GetRozehRequestEvent(page: "1"));
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            builder: (context, state) {
              if (state.rozehRequestStoreStatus
                  is RozehRequestStoreStatusLoading) {
                return const Center(child: DotLoadingWidget(size: 30));
              }
              return Center(
                child: CustomBtnGradient(
                  onPressed: _onSubmit,
                  title: "ثبت و رزرو مراسم",
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomBtn(
              title: "بازگشت",
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSingleChildScrollViewLevel3(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),

          CardWithButtonInDip(
            child: Container(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  SvgPicture.asset("assets/images/money.svg"),
                  SizedBox(height: 20),
                  TxtTitle(
                    isAlignCenter: true,
                    size: 16,
                    text: "درخواست رزرو شما با موفقیت ثبت شد .",
                    color: ConsColors.blue,
                  ),
                  SizedBox(height: 10),
                  TxtTitleNotBold(
                    textAlign: TextAlign.center,
                    text:
                        "برای مشاهده درخواست های رزرو شده به صفحه اصلی بازگردید .",
                    color: ConsColors.blue,
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                selectedMaddah = null;
                selectedSpeaker = null;
                selectedType = null;
                selectedAgeGroup = null;
                selectedGender = null;
                dateController.clear();
                startTimeController.clear();
                endTimeController.clear();
                descriptionController.clear();
              });
              _pageController.animateToPage(
                0, // شماره صفحه (0-indexed)
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            title: "بازگشت به صفحه رزرو",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------- Dropdowns ----------
  Widget _buildMaddahDropdown(
    BuildContext context,
  ) => BlocConsumer<ReservationBloc, ReservationState>(
    listenWhen:
        (previous, current) => previous.maddahStatus != current.maddahStatus,
    buildWhen:
        (previous, current) => previous.maddahStatus != current.maddahStatus,
    listener: (context, state) {
      if (state.maddahStatus is MaddahStatusError) {
        final error = state.maddahStatus as MaddahStatusError;
        SnackbarHelper.show(
          context: context,
          message: error.message ?? "خطا در دریافت اطلاعات مداح",
          status: SnackbarStatus.error,
        );
      }
    },
    builder: (context, state) {
      if (state.maddahStatus is MaddahStatusLoading) {
        return const DotLoadingWidget(size: 30);
      }

      if (state.maddahStatus is MaddahStatusError) {
        return Center(
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ReservationBloc>(context).add(GetMaddahEvent());
            },
            icon: const Icon(Icons.refresh, color: ConsColors.blue),
          ),
        );
      }

      if (state.maddahStatus is MaddahStatusCompleted) {
        final maddahStatusCompleted =
            state.maddahStatus as MaddahStatusCompleted;
        final maddahList = maddahStatusCompleted.maddahModel.data!.maddah!;

        if (selectedMaddah != null &&
            !maddahList.any((p) => p.id.toString() == selectedMaddah)) {
          selectedMaddah = null;
        }

        return CustomDropdownField<String>(
          value: selectedMaddah,
          items:
              maddahList
                  .map(
                    (m) => DropdownMenuItem<String>(
                      value: m.id.toString(),
                      child: Text(m.fullName ?? "-"),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              selectedMaddah = value;
              selectedMaddahName =
                  maddahList
                      .firstWhere((m) => m.id.toString() == value)
                      .fullName;
            });
          },
        );
      }

      return const SizedBox.shrink();
    },
  );

  Widget _buildSpeakerDropdown(
    BuildContext context,
  ) => BlocConsumer<ReservationBloc, ReservationState>(
    listenWhen: (prev, curr) => prev.speakerStatus != curr.speakerStatus,
    buildWhen: (prev, curr) => prev.speakerStatus != curr.speakerStatus,
    listener: (context, state) {
      if (state.speakerStatus is SpeakerStatusError) {
        final error = state.speakerStatus as SpeakerStatusError;
        SnackbarHelper.show(
          context: context,
          message: error.message ?? "خطا در دریافت لیست سخنران‌ها",
          status: SnackbarStatus.error,
        );
      }
    },
    builder: (context, state) {
      if (state.speakerStatus is SpeakerStatusLoading) {
        return const DotLoadingWidget(size: 30);
      }

      if (state.speakerStatus is SpeakerStatusError) {
        return Center(
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ReservationBloc>(context).add(GetSpeakerEvent());
            },
            icon: const Icon(Icons.refresh, color: ConsColors.blue),
          ),
        );
      }

      if (state.speakerStatus is SpeakerStatusCompleted) {
        final speakers =
            (state.speakerStatus as SpeakerStatusCompleted)
                .speakerModel
                .data!
                .speaker!;

        if (selectedSpeaker != null &&
            !speakers.any((s) => s.id.toString() == selectedSpeaker)) {
          selectedSpeaker = null;
        }

        return CustomDropdownField<String>(
          value: selectedSpeaker,
          items:
              speakers
                  .map(
                    (s) => DropdownMenuItem(
                      value: s.id.toString(),
                      child: Text(s.fullName ?? "-"),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              selectedSpeaker = value;
              selectedSpeakerName =
                  speakers.firstWhere((s) => s.id.toString() == value).fullName;
            });
          },
        );
      }

      return const SizedBox.shrink();
    },
  );

  Widget _buildRozehTypeDropdown(BuildContext context) =>
      BlocConsumer<ReservationBloc, ReservationState>(
        listenWhen:
            (prev, curr) => prev.rozehTypeStatus != curr.rozehTypeStatus,
        buildWhen: (prev, curr) => prev.rozehTypeStatus != curr.rozehTypeStatus,
        listener: (context, state) {
          if (state.rozehTypeStatus is RozehTypeStatusError) {
            final error = state.rozehTypeStatus as RozehTypeStatusError;
            SnackbarHelper.show(
              context: context,
              message: error.message ?? "خطا در دریافت نوع روضه‌ها",
              status: SnackbarStatus.error,
            );
          }
        },
        builder: (context, state) {
          if (state.rozehTypeStatus is RozehTypeStatusLoading) {
            return const DotLoadingWidget(size: 30);
          }

          if (state.rozehTypeStatus is RozehTypeStatusError) {
            return Center(
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<ReservationBloc>(
                    context,
                  ).add(GetRozehTypeEvent());
                },
                icon: const Icon(Icons.refresh, color: ConsColors.blue),
              ),
            );
          }

          if (state.rozehTypeStatus is RozehTypeStatusCompleted) {
            final types =
                (state.rozehTypeStatus as RozehTypeStatusCompleted)
                    .rozehTypeModel
                    .data!
                    .rozeh!;

            if (selectedType != null &&
                !types.any((t) => t.id.toString() == selectedType)) {
              selectedType = null;
            }

            return CustomDropdownField<String>(
              value: selectedType,
              items:
                  types
                      .map(
                        (t) => DropdownMenuItem(
                          value: t.id.toString(),
                          child: Text(t.title ?? "-"),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                  selectedTypeName =
                      types.firstWhere((t) => t.id.toString() == value).title;
                });
              },
            );
          }

          return const SizedBox.shrink();
        },
      );

  Widget _buildAgeGroupDropdown(
    BuildContext context,
  ) => BlocConsumer<ReservationBloc, ReservationState>(
    listenWhen: (prev, curr) => prev.ageGroupStatus != curr.ageGroupStatus,
    buildWhen: (prev, curr) => prev.ageGroupStatus != curr.ageGroupStatus,
    listener: (context, state) {
      if (state.ageGroupStatus is AgeGroupStatusError) {
        final error = state.ageGroupStatus as AgeGroupStatusError;
        SnackbarHelper.show(
          context: context,
          message: error.message ?? "خطا در دریافت گروه‌های سنی",
          status: SnackbarStatus.error,
        );
      }
    },
    builder: (context, state) {
      if (state.ageGroupStatus is AgeGroupStatusLoading) {
        return const DotLoadingWidget(size: 30);
      }

      if (state.ageGroupStatus is AgeGroupStatusError) {
        return Center(
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ReservationBloc>(context).add(GetAgeGroupEvent());
            },
            icon: const Icon(Icons.refresh, color: ConsColors.blue),
          ),
        );
      }

      if (state.ageGroupStatus is AgeGroupStatusCompleted) {
        final ageGroups =
            (state.ageGroupStatus as AgeGroupStatusCompleted)
                .ageGroupModel
                .data!
                .ageGroup!;

        if (selectedAgeGroup != null &&
            !ageGroups.any((a) => a.id.toString() == selectedAgeGroup)) {
          selectedAgeGroup = null;
        }

        return CustomDropdownField<String>(
          value: selectedAgeGroup,
          items:
              ageGroups
                  .map(
                    (a) => DropdownMenuItem(
                      value: a.id.toString(),
                      child: Text(a.title ?? "-"),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              selectedAgeGroup = value;
              selectedAgeGroupName =
                  ageGroups.firstWhere((a) => a.id.toString() == value).title;
            });
          },
        );
      }

      return const SizedBox.shrink();
    },
  );

  Widget _buildGenderDropdown(BuildContext context) {
    final genderItems = const [
      {'value': 'man', 'label': 'بانوان'},
      {'value': 'woman', 'label': 'آقایان'},
      {'value': 'family', 'label': 'خانوادگی'},
    ];

    return CustomDropdownField<String>(
      value: selectedGender,
      items:
          genderItems
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item['value']!,
                  child: Text(item['label']!),
                ),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
          selectedGenderName =
              genderItems.firstWhere((item) => item['value'] == value)['label'];
        });
      },
    );
  }
}
