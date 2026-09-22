import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';
import 'package:rozeh_project/core/widgets/card_with_button_in_dip.dart';
import 'package:rozeh_project/core/widgets/custom_btn.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:rozeh_project/core/widgets/dropdown/custom_multi_dropdown_field.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/core/widgets/txt_title_not_bold.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/list_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/bloc/address_bloc.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/screen/address_screen.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/maddah_model.dart';

import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_send_model.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/bloc/reservation_bloc.dart';

import 'package:rozeh_project/locator.dart';

class ReservationScreen extends StatefulWidget {
  static const routePath = "reservation_screen";
  static const routeName = "reservation_screen";

  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  // ============================================================
  // Selected values
  // ============================================================

  List<String> selectedMaddahIds = [];
  List<String> selectedMaddahNames = [];
  List<String> selectedMaddahAssignments = [];

  String? selectedType;
  String? selectedTypeName;

  String? selectedAgeGroup;
  String? selectedAgeGroupName;

  String? selectedGender;
  String? selectedGenderName;

  // ============================================================
  // Address
  // ============================================================

  late final AddressBloc addressBloc;

  int? selectedAddressId;
  Addresses? selectedAddress;

  // ============================================================
  // Controllers
  // ============================================================

  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // ============================================================
  // PageView
  // ============================================================

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<String> _titles = ["رزرو جلسه", "تایید اطلاعات", "تایید رزرو"];

  // ============================================================
  // Init
  // ============================================================

  @override
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<ReservationBloc>(context);

    bloc.add(GetMaddahEvent());

    bloc.add(GetRozehTypeEvent());
    bloc.add(GetAgeGroupEvent());

    addressBloc = locator<AddressBloc>();
    addressBloc.add(ListAddressEvent());
  }

  // ============================================================
  // Dispose
  // ============================================================

  @override
  void dispose() {
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    descriptionController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  // ============================================================
  // Add address
  // ============================================================

  Future<void> _addNewAddress() async {
    final result = await context.pushNamed(AddressScreen.routeName);

    if (!mounted) {
      return;
    }

    if (result == true) {
      addressBloc.add(ListAddressEvent());
    }
  }

  // ============================================================
  // Select address
  // ============================================================

  void _selectAddress(Addresses address) {
    final id = address.id?.toInt();

    if (id == null) {
      return;
    }

    setState(() {
      selectedAddressId = id;
      selectedAddress = address;
    });
  }

  // ============================================================
  // Date picker
  // ============================================================

  Future<void> _selectDate() async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
      initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
    );

    if (picked == null || !mounted) {
      return;
    }

    setState(() {
      final year = picked.year.toString();
      final month = picked.month.toString().padLeft(2, '0');
      final day = picked.day.toString().padLeft(2, '0');

      dateController.text = "$year/$month/$day".toPersianDigit();
    });
  }

  // ============================================================
  // Time picker
  // ============================================================

  Future<void> _selectTime(TextEditingController controller) async {
    int selectedHour = 3;
    int selectedMinute = 0;
    bool isPm = false;

    // اگر قبلاً ساعت انتخاب شده باشد،
    // BottomSheet با همان ساعت باز می‌شود.
    if (controller.text.isNotEmpty) {
      // مقدار نمایشی فارسی را فقط برای پردازش به اعداد انگلیسی تبدیل می‌کنیم.
      final englishTime = controller.text.toEnglishDigit();
      final parts = englishTime.split(':');

      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);

        if (hour != null && hour >= 0 && hour <= 23) {
          isPm = hour >= 12;

          selectedHour = hour % 12;

          if (selectedHour == 0) {
            selectedHour = 12;
          }
        }

        if (minute != null && minute >= 0 && minute <= 59) {
          selectedMinute = minute;
        }
      }
    }

    final result = await showModalBottomSheet<TimeOfDay>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      builder: (sheetContext) {
        return TimePickerBottomSheet(
          initialHour: selectedHour,
          initialMinute: selectedMinute,
          initialIsPm: isPm,
        );
      },
    );

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      // فقط نمایش فارسی است.
      controller.text =
          ("${result.hour.toString().padLeft(2, '0')}:"
              "${result.minute.toString().padLeft(2, '0')}")
              .toPersianDigit();
    });
  }

  // ============================================================
  // Time -> minutes
  // ============================================================

  int? _timeToMinutes(String value) {
    // مقدار داخل Controller برای نمایش فارسی است؛
    // قبل از پردازش آن را به اعداد انگلیسی تبدیل می‌کنیم.
    final englishValue = value.toEnglishDigit();
    final parts = englishValue.split(':');

    if (parts.length != 2) {
      return null;
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) {
      return null;
    }

    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      return null;
    }

    return hour * 60 + minute;
  }

  String _timeToApiFormat(String value) {
    return value.toEnglishDigit();
  }

  // ============================================================
  // Validate form
  // ============================================================

  bool _validateForm() {
    // مداح و سخنران عمداً اینجا بررسی نمی‌شوند.
    // هر دو اختیاری هستند.

    if (selectedType == null ||
        selectedGender == null ||
        selectedAgeGroup == null ||
        selectedAddressId == null ||
        dateController.text.trim().isEmpty ||
        startTimeController.text.trim().isEmpty ||
        endTimeController.text.trim().isEmpty) {
      SnackbarHelper.show(
        context: context,
        message: "لطفاً تمام فیلدهای ضروری را پر کنید.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    final start = _timeToMinutes(startTimeController.text);

    final end = _timeToMinutes(endTimeController.text);

    if (start == null || end == null) {
      SnackbarHelper.show(
        context: context,
        message: "زمان شروع و پایان را به درستی انتخاب کنید.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    if (end <= start) {
      SnackbarHelper.show(
        context: context,
        message: "زمان پایان باید بعد از زمان شروع باشد.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    return true;
  }

  // ============================================================
  // Submit
  // ============================================================

  void _onSubmit() {
    if (!_validateForm()) {
      return;
    }

    final jalaliParts = dateController.text.split("/");

    if (jalaliParts.length != 3) {
      SnackbarHelper.show(
        context: context,
        message: "تاریخ انتخاب شده معتبر نیست.",
        status: SnackbarStatus.error,
      );

      return;
    }

    final jalaliDate = Jalali(
      int.parse(jalaliParts[0].toEnglishDigit()),
      int.parse(jalaliParts[1].toEnglishDigit()),
      int.parse(jalaliParts[2].toEnglishDigit()),
    );

    final gregorianDate = jalaliDate.toGregorian();

    final formattedDate =
        "${gregorianDate.year.toString().padLeft(4, '0')}-"
        "${gregorianDate.month.toString().padLeft(2, '0')}-"
        "${gregorianDate.day.toString().padLeft(2, '0')}";

    // ============================================================
    // User IDs
    // ============================================================

    final userIds = selectedMaddahIds.map(int.parse).toList();

    // ============================================================
    // Request
    // ============================================================

    final rozehRequest = RozehRequestSendModel(
      rozehId: int.parse(selectedType!),
      ageGroupId: int.parse(selectedAgeGroup!),
      gender: selectedGender!,
      addressId: selectedAddressId!,
      date: formattedDate,
      userIds: userIds,
      startTime: _timeToApiFormat(startTimeController.text),
      endTime: _timeToApiFormat(endTimeController.text),
      description:
          descriptionController.text.trim().isEmpty
              ? null
              : descriptionController.text.trim(),
    );

    BlocProvider.of<ReservationBloc>(
      context,
    ).add(StoreRozehRequestEvent(rozehRequestSendModel: rozehRequest));
  }

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.background,
          child: Column(
            children: [
              CustomAppBarBackBtn(
                mainContext: context,
                title: "فرم ثبت درخواست رزرو",
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
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          _buildProgressHeader(),

                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                buildSingleChildScrollViewLevel1(
                                  context,
                                  width,
                                ),
                                buildSingleChildScrollViewLevel2(
                                  context,
                                  width,
                                ),
                                buildSingleChildScrollViewLevel3(
                                  context,
                                  width,
                                ),
                              ],
                            ),
                          ),
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

  // ============================================================
  // Progress header
  // ============================================================

  Widget _buildProgressHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_titles.length * 2 - 1, (index) {
          if (index.isOdd) {
            final realIndex = (index / 2).floor();

            return Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 22),
                child: CustomPaint(
                  painter: DottedLinePainter(
                    color:
                        realIndex < _currentPage
                            ? context.appColors.warning
                            : context.appColors.border,
                  ),
                  size: const Size(double.infinity, 2),
                ),
              ),
            );
          }

          final stepIndex = (index / 2).floor();

          final isActive = stepIndex <= _currentPage;

          return Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TxtTitle(
                  text: _titles[stepIndex],
                  color:
                      isActive
                          ? context.appColors.warning
                          : context.appColors.textSecondary,
                  size: 12,
                ),

                const SizedBox(height: 6),

                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? context.appColors.warning
                            : context.appColors.textSecondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: TxtTitleNotBold(
                    text: '${stepIndex + 1}',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ============================================================
  // Level 1
  // ============================================================

  Widget buildSingleChildScrollViewLevel1(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: context.appColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========================================================
            // Maddah + Speaker
            // ========================================================
            TxtTitle(
              text: "مداح و سخنران",
              color: context.appColors.textPrimary,
            ),

            const SizedBox(height: 10),

            _buildMaddahDropdown(context),

            const SizedBox(height: 8),

            Text(
              "انتخاب مداح و سخنران اختیاری است.",
              style: TextStyle(
                color: context.appColors.textSecondary,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Date
            // ========================================================
            TxtTitle(text: "تاریخ", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: CustomTextField(
                  isTextStart: true,
                  readOnly: true,
                  controller: dateController,
                  suffixIcon: Icon(
                    Icons.calendar_month_rounded,
                    size: 17,
                    color: context.appColors.warning,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Start + End Time
            // ========================================================
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxtTitle(
                        text: "زمان شروع",
                        color: context.appColors.textPrimary,
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () => _selectTime(startTimeController),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            isTextStart: true,
                            readOnly: true,
                            controller: startTimeController,
                            suffixIcon: Icon(
                              Icons.access_time_rounded,
                              size: 17,
                              color: context.appColors.warning,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxtTitle(
                        text: "زمان پایان",
                        color: context.appColors.textPrimary,
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () => _selectTime(endTimeController),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            isTextStart: true,
                            readOnly: true,
                            controller: endTimeController,
                            suffixIcon: Icon(
                              Icons.access_time_rounded,
                              size: 17,
                              color: context.appColors.warning,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Type + Age Group
            // ========================================================
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxtTitle(
                        text: "نوع مراسم",
                        color: context.appColors.textPrimary,
                      ),
                      const SizedBox(height: 10),
                      _buildRozehTypeDropdown(context),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxtTitle(
                        text: "رنج سنی",
                        color: context.appColors.textPrimary,
                      ),
                      const SizedBox(height: 10),
                      _buildAgeGroupDropdown(context),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Gender
            // ========================================================
            TxtTitle(
              text: "جنسیت شرکت کنندگان",
              color: context.appColors.textPrimary,
            ),

            const SizedBox(height: 10),

            _buildGenderDropdown(context),

            const SizedBox(height: 20),

            // ========================================================
            // Address
            // ========================================================
            TxtTitle(text: "آدرس مراسم", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            _buildAddressDropdown(),

            const SizedBox(height: 30),

            // ========================================================
            // Next
            // ========================================================
            Center(
              child: CustomBtnGradient(
                onPressed: () {
                  if (!_validateForm()) {
                    return;
                  }

                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  setState(() {
                    _currentPage++;
                  });
                },
                title: "ثبت و رزرو مراسم",
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Level 2
  // ============================================================

  Widget buildSingleChildScrollViewLevel2(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: context.appColors.card,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildConfirmRow(
                      title: "تاریخ مراسم:",
                      value: dateController.text.trim(),
                    ),

                    const SizedBox(height: 20),

                    _buildConfirmRow(
                      title: "مداح و سخنران:",
                      value:
                          selectedMaddahNames.isEmpty
                              ? "انتخاب نشده"
                              : selectedMaddahNames.join("، "),
                    ),

                    const SizedBox(height: 20),

                    _buildConfirmRow(
                      title: "نوع مراسم:",
                      value: selectedTypeName ?? "",
                    ),

                    const SizedBox(height: 20),

                    _buildConfirmRow(
                      title: "مخاطبین:",
                      value: selectedGenderName ?? "",
                    ),

                    const SizedBox(height: 20),

                    _buildConfirmRow(
                      title: "رنج سنی:",
                      value: selectedAgeGroupName ?? "",
                    ),

                    const SizedBox(height: 20),

                    _buildConfirmRow(
                      title: "عنوان آدرس:",
                      value: selectedAddress?.title ?? "آدرس انتخاب نشده",
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ========================================================
          // Cost
          // ========================================================
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: context.appColors.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TxtTitle(
                  size: 15,
                  text: "هزینه قابل پرداخت:",
                  color: context.appColors.textSecondary,
                ),
                TxtTitle(
                  size: 16,
                  text: "0 تومان",
                  color: context.appColors.warning,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ========================================================
          // Submit
          // ========================================================
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

                final regex = RegExp(r'(\d{4})-(\d{2})-(\d{2})');

                final match = regex.firstMatch(message);

                if (match != null) {
                  final year = int.parse(match.group(1)!);

                  final month = int.parse(match.group(2)!);

                  final day = int.parse(match.group(3)!);

                  final jalaliDate = Jalali.fromGregorian(
                    Gregorian(year, month, day),
                  );

                  final formattedJalali =
                      "${jalaliDate.year}/"
                      "${jalaliDate.month.toString().padLeft(2, '0')}/"
                      "${jalaliDate.day.toString().padLeft(2, '0')}";

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

                BlocProvider.of<ReservationBloc>(
                  context,
                ).add(GetRozehRequestEvent(page: "1"));
                BlocProvider.of<HomeBloc>(
                  context,
                ).add(GetLatestRequestCustomerEvent());

                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );

                setState(() {
                  _currentPage++;
                });
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

          // ========================================================
          // Back
          // ========================================================
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomBtn(
              title: "بازگشت",
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );

                setState(() {
                  _currentPage--;
                });
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // Confirm row
  // ============================================================

  Widget _buildConfirmRow({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TxtTitleNotBold(
          size: 15,
          text: title,
          color: context.appColors.textSecondary,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: TxtTitle(
            size: 16,
            text: value,
            color: context.appColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Level 3
  // ============================================================

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
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  SvgPicture.asset("assets/images/money.svg"),

                  const SizedBox(height: 20),

                  TxtTitle(
                    isAlignCenter: true,
                    size: 16,
                    text: "درخواست رزرو شما با موفقیت ثبت شد .",
                    color: context.appColors.textPrimary,
                  ),

                  const SizedBox(height: 10),

                  TxtTitleNotBold(
                    textAlign: TextAlign.center,
                    text:
                        "برای مشاهده درخواست های رزرو شده به صفحه اصلی بازگردید .",
                    color: context.appColors.textPrimary,
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
            onPressed: () {
              // setState(() {
              //   selectedMaddahIds.clear();
              //   selectedMaddahNames.clear();
              //   selectedMaddahAssignments.clear();
              //
              //   selectedType = null;
              //   selectedTypeName = null;
              //
              //   selectedAgeGroup = null;
              //   selectedAgeGroupName = null;
              //
              //   selectedGender = null;
              //   selectedGenderName = null;
              //
              //   selectedAddressId = null;
              //   selectedAddress = null;
              //
              //   dateController.clear();
              //   startTimeController.clear();
              //   endTimeController.clear();
              //   descriptionController.clear();
              //
              //   _currentPage = 0;
              // });
              //
              // _pageController.animateToPage(
              //   0,
              //   duration:
              //   const Duration(
              //     milliseconds: 300,
              //   ),
              //   curve:
              //   Curves.easeInOut,
              // );
              context.pop();
            },
            title: "بازگشت به صفحه رزرو",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // Address Dropdown
  // ============================================================

  Widget _buildAddressDropdown() {
    return BlocBuilder<AddressBloc, AddressState>(
      bloc: addressBloc,
      builder: (context, state) {
        final status = state.listAddressStatus;

        // ========================================================
        // Loading
        // ========================================================

        if (status is ListAddressStatusLoading) {
          return Container(
            height: 55,
            decoration: BoxDecoration(
              color: context.appColors.inputBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.appColors.border),
            ),
            child: const Center(child: DotLoadingWidget(size: 28)),
          );
        }

        // ========================================================
        // Error
        // ========================================================

        if (status is ListAddressStatusError) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: context.appColors.inputBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.appColors.border),
                  ),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "خطا در دریافت آدرس‌ها",
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              SizedBox(
                height: 55,
                width: 55,
                child: OutlinedButton(
                  onPressed: () {
                    addressBloc.add(ListAddressEvent());
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: context.appColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Icon(
                    Icons.refresh_rounded,
                    color: context.appColors.primary,
                  ),
                ),
              ),
            ],
          );
        }

        // ========================================================
        // Completed
        // ========================================================

        if (status is ListAddressStatusCompleted) {
          final addresses = status.listAddressModel.data?.addresses ?? [];

          // ======================================================
          // Empty
          // ======================================================

          if (addresses.isEmpty) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: context.appColors.inputBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: context.appColors.border),
                    ),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "آدرسی ثبت نشده",
                      style: TextStyle(
                        color: context.appColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                SizedBox(
                  height: 55,
                  width: 55,
                  child: OutlinedButton(
                    onPressed: _addNewAddress,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: BorderSide(color: context.appColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Icon(
                      Icons.add_location_alt_outlined,
                      color: context.appColors.primary,
                    ),
                  ),
                ),
              ],
            );
          }

          // ======================================================
          // Check selected address
          // ======================================================

          final hasSelectedAddress = addresses.any(
            (address) => address.id?.toInt() == selectedAddressId,
          );

          // اگر آدرس انتخاب‌شده دیگر وجود نداشت
          if (selectedAddressId != null && !hasSelectedAddress) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;

              setState(() {
                selectedAddressId = null;
                selectedAddress = null;
              });
            });
          }

          // ======================================================
          // Dropdown
          // ======================================================

          return Row(
            children: [
              Expanded(
                child: CustomDropdownField<int>(
                  value: hasSelectedAddress ? selectedAddressId : null,
                  items:
                      addresses.map((address) {
                        return DropdownMenuItem<int>(
                          value: address.id?.toInt(),
                          child: Text(
                            address.title ?? "بدون عنوان",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    final selected = addresses.firstWhere(
                      (address) => address.id?.toInt() == value,
                    );

                    _selectAddress(selected);
                  },
                ),
              ),

              const SizedBox(width: 8),

              // ==================================================
              // Add new address
              // ==================================================
              SizedBox(
                height: 40,
                width: 40,
                child: OutlinedButton(
                  onPressed: _addNewAddress,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: context.appColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Icon(
                    Icons.add_location_alt_outlined,
                    color: context.appColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ============================================================
  // Maddah
  // ============================================================

  Widget _buildMaddahDropdown(BuildContext context) {
    return BlocConsumer<ReservationBloc, ReservationState>(
      listenWhen:
          (previous, current) => previous.maddahStatus != current.maddahStatus,

      buildWhen:
          (previous, current) => previous.maddahStatus != current.maddahStatus,

      listener: (context, state) {
        if (state.maddahStatus is MaddahStatusError) {
          final error = state.maddahStatus as MaddahStatusError;

          SnackbarHelper.show(
            context: context,
            message: error.message ?? "خطا در دریافت لیست مداحان و سخنران‌ها",
            status: SnackbarStatus.error,
          );
        }
      },

      builder: (context, state) {
        // ==========================================================
        // Loading
        // ==========================================================

        if (state.maddahStatus is MaddahStatusLoading) {
          return const DotLoadingWidget(size: 30);
        }

        // ==========================================================
        // Error
        // ==========================================================

        if (state.maddahStatus is MaddahStatusError) {
          return Center(
            child: IconButton(
              onPressed: () {
                BlocProvider.of<ReservationBloc>(context).add(GetMaddahEvent());
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: context.appColors.textPrimary,
              ),
            ),
          );
        }

        // ==========================================================
        // Completed
        // ==========================================================

        if (state.maddahStatus is MaddahStatusCompleted) {
          final completed = state.maddahStatus as MaddahStatusCompleted;

          final users = completed.maddahModel.data?.users ?? [];

          return CustomMultiSelectDropdownField<User>(
            items: users,

            selectedValues: selectedMaddahIds,

            // --------------------------------------------------------
            // ID
            // --------------------------------------------------------
            itemValue: (user) {
              return user.id?.toString() ?? "";
            },

            // --------------------------------------------------------
            // Chip title
            // --------------------------------------------------------
            itemTitle: (user) {
              return user.fullName ?? "-";
            },

            // --------------------------------------------------------
            // Chip subtitle
            // --------------------------------------------------------
            itemSubtitle: (user) {
              return user.assignmentLabel ?? "";
            },

            itemSearchText: (user) {
              return [
                user.fullName,
                user.assignmentLabel,
                user.assignmentDisplay,
              ].whereType<String>().join(" ");
            },

            hintText: "مداح یا سخنران را انتخاب کنید",

            // --------------------------------------------------------
            // Popup item
            // --------------------------------------------------------
            itemLabel: (user) {
              final assignment = user.assignmentLabel ?? "";

              return Row(
                children: [
                  // Avatar
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: context.appColors.warning.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      color: context.appColors.warning,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Name + Assignment
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName ?? "-",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: context.appColors.textPrimary,
                            fontFamily: 'IRANSansX',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        if (assignment.isNotEmpty) ...[
                          const SizedBox(height: 3),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: context.appColors.warning.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              assignment,
                              style: TextStyle(
                                color: context.appColors.secondary,
                                fontFamily: 'IRANSansX',
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },

            // --------------------------------------------------------
            // Changed
            // --------------------------------------------------------
            onChanged: (selectedUsers) {
              setState(() {
                selectedMaddahIds =
                    selectedUsers
                        .where((user) => user.id != null)
                        .map((user) => user.id.toString())
                        .toList();

                selectedMaddahNames =
                    selectedUsers.map((user) => user.fullName ?? "-").toList();

                selectedMaddahAssignments =
                    selectedUsers
                        .map((user) => user.assignmentLabel ?? "")
                        .toList();
              });
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ============================================================
  // Speaker
  // ============================================================

  // ============================================================
  // Rozeh Type
  // ============================================================

  Widget _buildRozehTypeDropdown(BuildContext context) =>
      BlocConsumer<ReservationBloc, ReservationState>(
        listenWhen:
            (previous, current) =>
                previous.rozehTypeStatus != current.rozehTypeStatus,

        buildWhen:
            (previous, current) =>
                previous.rozehTypeStatus != current.rozehTypeStatus,

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
                icon: Icon(Icons.refresh, color: context.appColors.textPrimary),
              ),
            );
          }

          if (state.rozehTypeStatus is RozehTypeStatusCompleted) {
            final types =
                (state.rozehTypeStatus as RozehTypeStatusCompleted)
                    .rozehTypeModel
                    .data!
                    .rozeh!;

            final selectedStillExists =
                selectedType != null &&
                types.any((t) => t.id.toString() == selectedType);

            return CustomDropdownField<String>(
              value: selectedStillExists ? selectedType : null,

              items:
                  types.map((t) {
                    return DropdownMenuItem<String>(
                      value: t.id.toString(),
                      child: Text(
                        t.title ?? "-",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                final selected = types.firstWhere(
                  (t) => t.id.toString() == value,
                );

                setState(() {
                  selectedType = value;
                  selectedTypeName = selected.title;
                });
              },
            );
          }

          return const SizedBox.shrink();
        },
      );

  // ============================================================
  // Age Group
  // ============================================================

  Widget _buildAgeGroupDropdown(BuildContext context) =>
      BlocConsumer<ReservationBloc, ReservationState>(
        listenWhen:
            (previous, current) =>
                previous.ageGroupStatus != current.ageGroupStatus,

        buildWhen:
            (previous, current) =>
                previous.ageGroupStatus != current.ageGroupStatus,

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
                  BlocProvider.of<ReservationBloc>(
                    context,
                  ).add(GetAgeGroupEvent());
                },
                icon: Icon(Icons.refresh, color: context.appColors.textPrimary),
              ),
            );
          }

          if (state.ageGroupStatus is AgeGroupStatusCompleted) {
            final ageGroups =
                (state.ageGroupStatus as AgeGroupStatusCompleted)
                    .ageGroupModel
                    .data!
                    .ageGroup!;

            final selectedStillExists =
                selectedAgeGroup != null &&
                ageGroups.any((a) => a.id.toString() == selectedAgeGroup);

            return CustomDropdownField<String>(
              value: selectedStillExists ? selectedAgeGroup : null,

              items:
                  ageGroups.map((a) {
                    return DropdownMenuItem<String>(
                      value: a.id.toString(),
                      child: Text(
                        a.title ?? "-",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),

              onChanged: (value) {
                if (value == null) {
                  return;
                }

                final selected = ageGroups.firstWhere(
                  (a) => a.id.toString() == value,
                );

                setState(() {
                  selectedAgeGroup = value;
                  selectedAgeGroupName = selected.title;
                });
              },
            );
          }

          return const SizedBox.shrink();
        },
      );

  // ============================================================
  // Gender
  // ============================================================

  Widget _buildGenderDropdown(BuildContext context) {
    final genderItems = const [
      {'value': 'man', 'label': 'آقایان'},
      {'value': 'woman', 'label': 'بانوان'},
      {'value': 'family', 'label': 'خانوادگی'},
    ];

    return CustomDropdownField<String>(
      value: selectedGender,

      items:
          genderItems.map((item) {
            return DropdownMenuItem<String>(
              value: item['value']!,
              child: Text(item['label']!),
            );
          }).toList(),

      onChanged: (value) {
        if (value == null) {
          return;
        }

        final selected = genderItems.firstWhere(
          (item) => item['value'] == value,
        );

        setState(() {
          selectedGender = value;
          selectedGenderName = selected['label'];
        });
      },
    );
  }
}

// ============================================================================
// Time Picker Bottom Sheet
// ============================================================================

class TimePickerBottomSheet extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final bool initialIsPm;

  const TimePickerBottomSheet({
    super.key,
    required this.initialHour,
    required this.initialMinute,
    required this.initialIsPm,
  });

  @override
  State<TimePickerBottomSheet> createState() => _TimePickerBottomSheetState();
}

class _TimePickerBottomSheetState extends State<TimePickerBottomSheet> {
  late int selectedHour;
  late int selectedMinute;
  late bool isPm;

  late FixedExtentScrollController hourController;

  late FixedExtentScrollController minuteController;

  late FixedExtentScrollController amPmController;

  final List<int> hours = List.generate(12, (index) => index + 1);

  final List<int> minutes = List.generate(60, (index) => index);

  @override
  void initState() {
    super.initState();

    selectedHour = widget.initialHour;

    selectedMinute = widget.initialMinute;

    isPm = widget.initialIsPm;

    hourController = FixedExtentScrollController(
      initialItem: hours.indexOf(selectedHour),
    );

    minuteController = FixedExtentScrollController(initialItem: selectedMinute);

    amPmController = FixedExtentScrollController(initialItem: isPm ? 1 : 0);
  }

  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    amPmController.dispose();

    super.dispose();
  }

  int _convertTo24Hour() {
    if (isPm) {
      if (selectedHour == 12) {
        return 12;
      }

      return selectedHour + 12;
    }

    if (selectedHour == 12) {
      return 0;
    }

    return selectedHour;
  }

  void _submit() {
    final hour = _convertTo24Hour();

    Navigator.pop(context, TimeOfDay(hour: hour, minute: selectedMinute));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: colors.navigationBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ======================================================
            // Handle
            // ======================================================
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              "انتخاب ساعت مراسم",
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "ساعت و دقیقه مورد نظر را انتخاب کنید",
              style: TextStyle(color: colors.textSecondary, fontSize: 12),
            ),

            const SizedBox(height: 18),

            // ======================================================
            // Picker
            // ======================================================
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: colors.inputBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Selected row
                  Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        // ==========================================================
                        // Hour
                        // ==========================================================
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 45,
                            scrollController: hourController,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedHour = hours[index];
                              });
                            },
                            children:
                                hours.map((hour) {
                                  return Center(
                                    child: Text(
                                      hour.toString().padLeft(2, '0').toPersianDigit(),
                                      style: TextStyle(
                                        color: colors.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),

                        // ==========================================================
                        // :
                        // ==========================================================
                        Text(
                          ":",
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // ==========================================================
                        // Minute
                        // ==========================================================
                        Expanded(
                          child: CupertinoPicker(
                            itemExtent: 45,
                            scrollController: minuteController,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMinute = minutes[index];
                              });
                            },
                            children:
                                minutes.map((minute) {
                                  return Center(
                                    child: Text(
                                      minute.toString().padLeft(2, '0').toPersianDigit(),
                                      style: TextStyle(
                                        color: colors.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // ==========================================================
                        // AM / PM
                        // ==========================================================
                        SizedBox(
                          width: 65,
                          child: CupertinoPicker(
                            itemExtent: 45,
                            scrollController: amPmController,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                isPm = index == 1;
                              });
                            },
                            children: [
                              Center(
                                child: Text(
                                  "ق.ظ",
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "ب.ظ",
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ======================================================
            // Current selected time
            // ======================================================
            Text(
              ("${selectedHour.toString().padLeft(2, '0')}:"
              "${selectedMinute.toString().padLeft(2, '0')} "
              "${isPm ? 'ب.ظ' : 'ق.ظ'}").toPersianDigit(),
              style: TextStyle(
                color: context.appColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // ======================================================
            // Confirm
            // ======================================================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomBtnGradient(title: "تأیید ساعت", onPressed: _submit),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Dotted Line
// ============================================================================

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 4;

    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
