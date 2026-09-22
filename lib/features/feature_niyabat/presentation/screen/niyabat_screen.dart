import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';
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

import 'package:rozeh_project/features/feature_niyabat/data/model/intentions_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/niyabat_model_for_send.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/tavaslats_model.dart';
import 'package:rozeh_project/features/feature_niyabat/presentation/bloc/niyabat_bloc.dart';

import 'package:rozeh_project/locator.dart';

class NiyabatScreen extends StatefulWidget {
  static const routePath = "niyabat_screen";
  static const routeName = "niyabat_screen";

  final CalendarItem? editingNiyabat;

  const NiyabatScreen({super.key, this.editingNiyabat});

  @override
  State<NiyabatScreen> createState() => _NiyabatScreenState();
}

class _NiyabatScreenState extends State<NiyabatScreen> {
  // ============================================================
  // Bloc
  // ============================================================

  late final NiyabatBloc niyabatBloc;

  // ============================================================
  // Selected values
  // ============================================================

  Intentions? selectedIntention;
  Tavaslats? selectedTavaslat;

  String? selectedIntentionName;
  String? selectedTavaslatName;

  // ============================================================
  // Controllers
  // ============================================================

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  // ============================================================
  // Form
  // ============================================================

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ============================================================
  // PageView
  // ============================================================

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<String> _titles = [
    "اطلاعات نیابت",
    "تایید اطلاعات",
    "تایید نیابت",
  ];

  // ============================================================
  // Edit
  // ============================================================

  bool get isEdit => widget.editingNiyabat != null;

  // ============================================================
  // Init
  // ============================================================

  @override
  void initState() {
    super.initState();

    niyabatBloc = locator<NiyabatBloc>();

    titleController.text = widget.editingNiyabat?.title ?? "";

    descriptionController.text = widget.editingNiyabat?.description ?? "";

    niyabatBloc.add(GetIntentionEvent());

    niyabatBloc.add(GetTavaslatEvent());
  }

  // ============================================================
  // Dispose
  // ============================================================

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  // ============================================================
  // Initial selections
  // ============================================================

  void _setInitialSelections({
    required List<Intentions> intentions,
    required List<Tavaslats> tavaslats,
  }) {
    if (!isEdit) {
      return;
    }

    // ==========================================================
    // Intention
    // ==========================================================

    if (selectedIntention == null &&
        widget.editingNiyabat?.intentionId != null) {
      final intention = intentions.cast<Intentions?>().firstWhere(
        (item) =>
            item?.id?.toInt() == widget.editingNiyabat?.intentionId?.toInt(),
        orElse: () => null,
      );

      if (intention != null) {
        selectedIntention = intention;
        selectedIntentionName = intention.title;
      }
    }

    // ==========================================================
    // Tavaslat
    // ==========================================================

    if (selectedTavaslat == null && widget.editingNiyabat?.tavaslatId != null) {
      final tavaslat = tavaslats.cast<Tavaslats?>().firstWhere(
        (item) =>
            item?.id?.toInt() == widget.editingNiyabat?.tavaslatId?.toInt(),
        orElse: () => null,
      );

      if (tavaslat != null) {
        selectedTavaslat = tavaslat;
        selectedTavaslatName = tavaslat.title;
      }
    }
  }

  // ============================================================
  // Validate form
  // ============================================================

  bool _validateForm() {
    final formState = formKey.currentState;

    if (formState == null) {
      SnackbarHelper.show(
        context: context,
        message: "فرم قابل اعتبارسنجی نیست.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    if (!formState.validate()) {
      return false;
    }

    if (selectedIntention == null) {
      SnackbarHelper.show(
        context: context,
        message: "لطفاً نیت را انتخاب کنید.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    if (selectedIntention?.id == null) {
      SnackbarHelper.show(
        context: context,
        message: "نیت انتخاب‌شده معتبر نیست.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    if (selectedTavaslat == null) {
      SnackbarHelper.show(
        context: context,
        message: "لطفاً توسل را انتخاب کنید.",
        status: SnackbarStatus.error,
      );

      return false;
    }

    if (selectedTavaslat?.id == null) {
      SnackbarHelper.show(
        context: context,
        message: "توسل انتخاب‌شده معتبر نیست.",
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

    final intentionId = selectedIntention?.id?.toInt();
    final tavaslatId = selectedTavaslat?.id?.toInt();

    if (intentionId == null) {
      SnackbarHelper.show(
        context: context,
        message: "شناسه نیت معتبر نیست.",
        status: SnackbarStatus.error,
      );

      return;
    }

    if (tavaslatId == null) {
      SnackbarHelper.show(
        context: context,
        message: "شناسه توسل معتبر نیست.",
        status: SnackbarStatus.error,
      );

      return;
    }

    final model = NiyabatModelForSend(
      intentionId: intentionId,
      tavaslatId: tavaslatId,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );

    // ==========================================================
    // Update
    // ==========================================================

    if (isEdit) {
      final id = widget.editingNiyabat?.id;

      if (id == null) {
        SnackbarHelper.show(
          context: context,
          message: "شناسه روضه نیابتی معتبر نیست.",
          status: SnackbarStatus.error,
        );

        return;
      }

      niyabatBloc.add(
        UpdateNiyabatEvent(niyabatId: id.toInt(), niyabatModelForSend: model),
      );

      return;
    }

    // ==========================================================
    // Store
    // ==========================================================

    niyabatBloc.add(StoreNiyabatEvent(niyabatModelForSend: model));
  }

  // ============================================================
  // Next page
  // ============================================================

  Future<void> _goToNextPage() async {
    if (_currentPage >= _titles.length - 1) {
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ============================================================
  // Previous page
  // ============================================================

  Future<void> _goToPreviousPage() async {
    if (_currentPage <= 0) {
      return;
    }

    await _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ============================================================
  // Reset form
  // ============================================================

  Future<void> _resetForm() async {
    formKey.currentState?.reset();

    selectedIntention = null;
    selectedIntentionName = null;

    selectedTavaslat = null;
    selectedTavaslatName = null;

    titleController.clear();
    descriptionController.clear();

    await _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
                title: isEdit ? "ویرایش روضه نیابتی" : "ثبت روضه نیابتی",
              ),

              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // ==================================================
                    // Mandala - Left
                    // ==================================================
                    Positioned(
                      top: height * 0.2,
                      left: 0,
                      child: SvgPicture.asset(
                        height: height * 0.35,
                        "assets/images/mandala.svg",
                        color: context.appColors.appBarSecondary,
                      ),
                    ),

                    // ==================================================
                    // Mandala - Right
                    // ==================================================
                    Positioned(
                      top: height * 0.2,
                      right: 0,
                      child: SvgPicture.asset(
                        height: height * 0.35,
                        "assets/images/mandala (1).svg",
                        color: context.appColors.appBarSecondary,
                      ),
                    ),

                    // ==================================================
                    // Main Content
                    // ==================================================
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        children: [
                          // ==================================================
                          // Progress Header
                          // ==================================================
                          _buildProgressHeader(),

                          // ==================================================
                          // PageView + Form
                          // ==================================================
                          Expanded(
                            child: Form(
                              key: formKey,
                              child: PageView(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(),

                                onPageChanged: (index) {
                                  if (!mounted) {
                                    return;
                                  }

                                  setState(() {
                                    _currentPage = index;
                                  });
                                },

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
  // Progress Header
  // ============================================================

  Widget _buildProgressHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_titles.length * 2 - 1, (index) {
          // ========================================================
          // Dotted line
          // ========================================================

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

          // ========================================================
          // Step
          // ========================================================

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
            // Title
            // ========================================================
            TxtTitle(
              text: "اطلاعات روضه نیابتی",
              color: context.appColors.textPrimary,
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Intention
            // ========================================================
            TxtTitle(text: "نیت", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            _buildIntentionDropdown(context),

            const SizedBox(height: 20),

            // ========================================================
            // Tavaslat
            // ========================================================
            TxtTitle(text: "توسل", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            _buildTavaslatDropdown(context),

            const SizedBox(height: 20),

            // ========================================================
            // Title
            // ========================================================
            TxtTitle(text: "عنوان", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            CustomTextField(
              controller: titleController,
              hintText: "عنوان روضه نیابتی را وارد کنید",
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "عنوان را وارد کنید";
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            // ========================================================
            // Description
            // ========================================================
            TxtTitle(text: "توضیحات", color: context.appColors.textPrimary),

            const SizedBox(height: 10),

            CustomTextField(
              controller: descriptionController,
              hintText: "توضیحات را وارد کنید",
              textInputType: TextInputType.multiline,
            ),

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

                  _goToNextPage();
                },
                title: "ثبت و ادامه",
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
                    // ==================================================
                    // Intention
                    // ==================================================
                    _buildConfirmRow(
                      title: "نیت:",
                      value: selectedIntentionName ?? "انتخاب نشده",
                    ),

                    const SizedBox(height: 20),

                    // ==================================================
                    // Tavaslat
                    // ==================================================
                    _buildConfirmRow(
                      title: "توسل:",
                      value: selectedTavaslatName ?? "انتخاب نشده",
                    ),

                    const SizedBox(height: 20),

                    // ==================================================
                    // Title
                    // ==================================================
                    _buildConfirmRow(
                      title: "عنوان:",
                      value:
                          titleController.text.trim().isEmpty
                              ? "بدون عنوان"
                              : titleController.text.trim(),
                    ),

                    const SizedBox(height: 20),

                    // ==================================================
                    // Description
                    // ==================================================
                    _buildConfirmRow(
                      title: "توضیحات:",
                      value:
                          descriptionController.text.trim().isEmpty
                              ? "بدون توضیحات"
                              : descriptionController.text.trim(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==========================================================
          // Submit
          // ==========================================================
          BlocConsumer<NiyabatBloc, NiyabatState>(
            bloc: niyabatBloc,

            listenWhen:
                (previous, current) =>
                    previous.storeNiyabatStatus != current.storeNiyabatStatus ||
                    previous.updateNiyabatStatus != current.updateNiyabatStatus,

            listener: (context, state) {
              // ======================================================
              // Store Error
              // ======================================================

              if (state.storeNiyabatStatus is StoreNiyabatStatusError) {
                final error =
                    state.storeNiyabatStatus as StoreNiyabatStatusError;

                SnackbarHelper.show(
                  context: context,
                  message: error.message ?? "خطا در ثبت روضه نیابتی",
                  status: SnackbarStatus.error,
                );
              }

              // ======================================================
              // Store Completed
              // ======================================================

              if (state.storeNiyabatStatus is StoreNiyabatStatusCompleted) {
                SnackbarHelper.show(
                  context: context,
                  message: "روضه نیابتی با موفقیت ثبت شد 🎉",
                  status: SnackbarStatus.success,
                );
                BlocProvider.of<HomeBloc>(context).add(GetLatestRequestCustomerEvent());
                _goToNextPage();
              }

              // ======================================================
              // Update Error
              // ======================================================

              if (state.updateNiyabatStatus is UpdateNiyabatStatusError) {
                final error =
                    state.updateNiyabatStatus as UpdateNiyabatStatusError;

                SnackbarHelper.show(
                  context: context,
                  message: error.message ?? "خطا در ویرایش روضه نیابتی",
                  status: SnackbarStatus.error,
                );
              }

              // ======================================================
              // Update Completed
              // ======================================================

              if (state.updateNiyabatStatus is UpdateNiyabatStatusCompleted) {
                SnackbarHelper.show(
                  context: context,
                  message: "روضه نیابتی با موفقیت ویرایش شد 🎉",
                  status: SnackbarStatus.success,
                );

                _goToNextPage();
              }
            },

            builder: (context, state) {
              // ======================================================
              // Loading
              // ======================================================

              if (state.storeNiyabatStatus is StoreNiyabatStatusLoading ||
                  state.updateNiyabatStatus is UpdateNiyabatStatusLoading) {
                return const Center(child: DotLoadingWidget(size: 30));
              }

              // ======================================================
              // Submit button
              // ======================================================

              return Center(
                child: CustomBtnGradient(
                  onPressed: _onSubmit,
                  title: isEdit ? "ویرایش روضه نیابتی" : "ثبت روضه نیابتی",
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // ==========================================================
          // Back
          // ==========================================================
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomBtn(title: "بازگشت", onPressed: _goToPreviousPage),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // Confirm Row
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
                    text:
                        isEdit
                            ? "روضه نیابتی شما با موفقیت ویرایش شد."
                            : "روضه نیابتی شما با موفقیت ثبت شد.",
                    color: context.appColors.textPrimary,
                  ),

                  const SizedBox(height: 10),

                  TxtTitleNotBold(
                    textAlign: TextAlign.center,
                    text:
                        "برای مشاهده روضه‌های نیابتی ثبت شده به صفحه مربوطه بازگردید.",
                    color: context.appColors.textPrimary,
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
            onPressed: () {
              context.pop();
            },
            title: "بازگشت به لیست روضه‌های نیابتی",
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // Intention Dropdown
  // ============================================================

  Widget _buildIntentionDropdown(BuildContext context) {
    return BlocConsumer<NiyabatBloc, NiyabatState>(
      bloc: niyabatBloc,

      listenWhen:
          (previous, current) =>
              previous.intentionsStatus != current.intentionsStatus,

      buildWhen:
          (previous, current) =>
              previous.intentionsStatus != current.intentionsStatus,

      listener: (context, state) {
        if (state.intentionsStatus is IntentionsStatusError) {
          final error = state.intentionsStatus as IntentionsStatusError;

          SnackbarHelper.show(
            context: context,
            message: error.message ?? "خطا در دریافت لیست نیت‌ها",
            status: SnackbarStatus.error,
          );
        }
      },

      builder: (context, state) {
        // ==========================================================
        // Loading
        // ==========================================================

        if (state.intentionsStatus is IntentionsStatusLoading) {
          return const DotLoadingWidget(size: 30);
        }

        // ==========================================================
        // Error
        // ==========================================================

        if (state.intentionsStatus is IntentionsStatusError) {
          return Center(
            child: IconButton(
              onPressed: () {
                niyabatBloc.add(GetIntentionEvent());
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

        if (state.intentionsStatus is IntentionsStatusCompleted) {
          final intentions =
              (state.intentionsStatus as IntentionsStatusCompleted)
                  .intentionsModel
                  .data
                  ?.intentions ??
              [];

          // ========================================================
          // پیدا کردن آیتم مربوط به ویرایش
          // ========================================================

          if (isEdit &&
              selectedIntention == null &&
              widget.editingNiyabat?.intentionId != null) {
            final selectedId = widget.editingNiyabat!.intentionId!.toInt();

            for (final intention in intentions) {
              if (intention.id?.toInt() == selectedId) {
                selectedIntention = intention;
                selectedIntentionName = intention.title;
                break;
              }
            }
          }

          // ========================================================
          // بررسی معتبر بودن مقدار انتخاب‌شده
          // ========================================================

          Intentions? validSelectedIntention;

          if (selectedIntention != null) {
            for (final intention in intentions) {
              if (intention.id?.toInt() == selectedIntention!.id?.toInt()) {
                // بسیار مهم:
                // آبجکت موجود در همین لیست را استفاده می‌کنیم.
                validSelectedIntention = intention;
                break;
              }
            }
          }

          // ========================================================
          // اگر آیتم وجود نداشت، انتخاب را پاک کن
          // ========================================================

          if (selectedIntention != null && validSelectedIntention == null) {
            selectedIntention = null;
            selectedIntentionName = null;
          }

          return CustomDropdownField<Intentions>(
            value: validSelectedIntention,

            items:
                intentions.map((item) {
                  return DropdownMenuItem<Intentions>(
                    value: item,
                    child: Text(
                      item.title ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),

            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedIntention = value;
                selectedIntentionName = value.title;
              });
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // ============================================================
  // Tavaslat Dropdown
  // ============================================================

  Widget _buildTavaslatDropdown(BuildContext context) {
    return BlocConsumer<NiyabatBloc, NiyabatState>(
      bloc: niyabatBloc,

      listenWhen:
          (previous, current) =>
              previous.tavaslatsStatus != current.tavaslatsStatus,

      buildWhen:
          (previous, current) =>
              previous.tavaslatsStatus != current.tavaslatsStatus,

      listener: (context, state) {
        if (state.tavaslatsStatus is TavaslatsStatusError) {
          final error = state.tavaslatsStatus as TavaslatsStatusError;

          SnackbarHelper.show(
            context: context,
            message: error.message ?? "خطا در دریافت لیست توسل‌ها",
            status: SnackbarStatus.error,
          );
        }
      },

      builder: (context, state) {
        // ==========================================================
        // Loading
        // ==========================================================

        if (state.tavaslatsStatus is TavaslatsStatusLoading) {
          return const DotLoadingWidget(size: 30);
        }

        // ==========================================================
        // Error
        // ==========================================================

        if (state.tavaslatsStatus is TavaslatsStatusError) {
          return Center(
            child: IconButton(
              onPressed: () {
                niyabatBloc.add(GetTavaslatEvent());
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

        if (state.tavaslatsStatus is TavaslatsStatusCompleted) {
          final tavaslats =
              (state.tavaslatsStatus as TavaslatsStatusCompleted)
                  .tavaslatsModel
                  .data
                  ?.tavaslats ??
              [];

          // ========================================================
          // پیدا کردن آیتم مربوط به ویرایش
          // ========================================================

          if (isEdit &&
              selectedTavaslat == null &&
              widget.editingNiyabat?.tavaslatId != null) {
            final selectedId = widget.editingNiyabat!.tavaslatId!.toInt();

            for (final tavaslat in tavaslats) {
              if (tavaslat.id?.toInt() == selectedId) {
                selectedTavaslat = tavaslat;
                selectedTavaslatName = tavaslat.title;
                break;
              }
            }
          }

          // ========================================================
          // بررسی معتبر بودن مقدار انتخاب‌شده
          // ========================================================

          Tavaslats? validSelectedTavaslat;

          if (selectedTavaslat != null) {
            for (final tavaslat in tavaslats) {
              if (tavaslat.id?.toInt() == selectedTavaslat!.id?.toInt()) {
                // بسیار مهم:
                // آبجکت موجود در همین لیست را استفاده می‌کنیم.
                validSelectedTavaslat = tavaslat;
                break;
              }
            }
          }

          // ========================================================
          // اگر آیتم وجود نداشت، انتخاب را پاک کن
          // ========================================================

          if (selectedTavaslat != null && validSelectedTavaslat == null) {
            selectedTavaslat = null;
            selectedTavaslatName = null;
          }

          return CustomDropdownField<Tavaslats>(
            value: validSelectedTavaslat,

            items:
                tavaslats.map((item) {
                  return DropdownMenuItem<Tavaslats>(
                    value: item,
                    child: Text(
                      item.title ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),

            onChanged: (value) {
              if (value == null) {
                return;
              }

              setState(() {
                selectedTavaslat = value;
                selectedTavaslatName = value.title;
              });
            },
          );
        }

        return const SizedBox.shrink();
      },
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
