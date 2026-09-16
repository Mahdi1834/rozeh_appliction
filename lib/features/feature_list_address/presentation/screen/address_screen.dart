import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:neshan_maps_flutter/location_picker.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/core/widgets/snackbar_helper.dart';
import 'package:rozeh_project/core/widgets/text_field/custom_textfield.dart';
import 'package:rozeh_project/core/widgets/txt_title.dart';
import 'package:rozeh_project/features/feature_list_address/data/key/api_keys.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/customer_address_model_for_send.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/list_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/bloc/address_bloc.dart';
import 'package:rozeh_project/features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/screen/reservation_screen.dart';
import 'package:rozeh_project/locator.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "address_screen";
  static const routePath = "address_screen";

  const AddressScreen({super.key, this.editingAddress});

  final Addresses? editingAddress;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final PageController _pageController = PageController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  final AddressBloc addressBloc = locator<AddressBloc>();
  final ProfileBloc profileBloc = locator<ProfileBloc>();

  int _currentPage = 0;

  // ------------------------------------------------------------
  // Location
  // ------------------------------------------------------------

  double? selectedLatitude;
  double? selectedLongitude;

  String selectedMapAddress = "";

  // ------------------------------------------------------------
  // Province / City
  // ------------------------------------------------------------

  int? selectedProvinceId;
  int? selectedCityId;

  String? selectedProvince;
  String? selectedCity;

  // ------------------------------------------------------------
  // Edit
  // ------------------------------------------------------------

  Addresses? get editingAddress => widget.editingAddress;

  bool get isEdit => editingAddress != null;

  bool _isDefault = false;

  // ------------------------------------------------------------
  // Page titles
  // ------------------------------------------------------------

  final List<String> _titles = ["انتخاب موقعیت", "اطلاعات آدرس"];

  // ------------------------------------------------------------
  // Init
  // ------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    debugPrint("AddressScreen initState");
    debugPrint("ProfileBloc: $profileBloc");
    // دریافت لیست استان‌ها
    profileBloc.add(GetProvincesEvent());
    if (widget.editingAddress != null) {
      _fillEditData();
    }
  }

  // ------------------------------------------------------------
  // Fill edit data
  // ------------------------------------------------------------

  void _fillEditData() {
    final address = editingAddress;

    if (address == null) {
      return;
    }

    titleController.text = address.title ?? "";
    addressController.text = address.address ?? "";
    postalCodeController.text = address.postalCode ?? "";

    selectedProvinceId = address.provinceId?.toInt();
    selectedCityId = address.cityId?.toInt();

    selectedProvince = address.province?.name;
    selectedCity = address.city?.name;

    _isDefault = address.isDefault ?? false;

    if (address.latitude != null &&
        address.latitude!.trim().isNotEmpty &&
        address.longitude != null &&
        address.longitude!.trim().isNotEmpty) {
      selectedLatitude = double.tryParse(address.latitude!);
      selectedLongitude = double.tryParse(address.longitude!);
    }

    // برای Edit باید شهرهای استان قبلی را هم بگیریم
    if (selectedProvinceId != null) {
      profileBloc.add(
        GetCitiesEvent(provinceId: selectedProvinceId!.toString()),
      );
    }
  }

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------

  @override
  void dispose() {
    _pageController.dispose();

    titleController.dispose();
    addressController.dispose();
    postalCodeController.dispose();

    super.dispose();
  }

  // ------------------------------------------------------------
  // Previous
  // ------------------------------------------------------------

  void _previousPage() {
    if (_currentPage == 0) {
      context.pop();
      return;
    }

    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ------------------------------------------------------------
  // Save
  // ------------------------------------------------------------

  void _saveAddress() {
    final model = CustomerAddressModelForSend(
      title: titleController.text.trim(),
      address: addressController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      provinceId: selectedProvinceId,
      cityId: selectedCityId,
      latitude: selectedLatitude,
      longitude: selectedLongitude,
      isDefault: _isDefault,
    );

    if (isEdit) {
      addressBloc.add(
        UpdateAddressEvent(
          addressId: editingAddress!.id!.toInt(),
          addressModel: model,
        ),
      );
    } else {
      addressBloc.add(StoreAddressEvent(addressModel: model));
    }
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: context.appColors.inputBackground,
        body: Column(
          children: [
            CustomAppBarBackBtn(
              title: isEdit ? "ویرایش آدرس" : "افزودن آدرس",
              mainContext: context,
            ),

            Expanded(
              child: BlocListener<AddressBloc, AddressState>(
                bloc: addressBloc,
                listenWhen: (previous, current) {
                  return previous.storeAddressStatus !=
                          current.storeAddressStatus ||
                      previous.updateAddressStatus !=
                          current.updateAddressStatus;
                },
                listener: (context, state) {
                  // --------------------------------------------------
                  // Store Error
                  // --------------------------------------------------

                  if (state.storeAddressStatus is StoreAddressStatusError) {
                    final status =
                        state.storeAddressStatus as StoreAddressStatusError;

                    SnackbarHelper.show(
                      context: context,
                      message: status.message ?? "خطا در ثبت آدرس",
                      status: SnackbarStatus.error,
                    );
                  }

                  // --------------------------------------------------
                  // Update Error
                  // --------------------------------------------------

                  if (state.updateAddressStatus is UpdateAddressStatusError) {
                    final status =
                        state.updateAddressStatus as UpdateAddressStatusError;

                    SnackbarHelper.show(
                      context: context,
                      message: status.message ?? "خطا در ویرایش آدرس",
                      status: SnackbarStatus.error,
                    );
                  }

                  // --------------------------------------------------
                  // Store Success
                  // --------------------------------------------------

                  if (state.storeAddressStatus is StoreAddressStatusCompleted) {
                    SnackbarHelper.show(
                      context: context,
                      message: "آدرس با موفقیت ثبت شد",
                      status: SnackbarStatus.success,
                    );
                    BlocProvider.of<AddressBloc>(
                      context,
                    ).add(ListAddressEvent());
                    context.pop(true);
                  }

                  // --------------------------------------------------
                  // Update Success
                  // --------------------------------------------------

                  if (state.updateAddressStatus
                      is UpdateAddressStatusCompleted) {
                    SnackbarHelper.show(
                      context: context,
                      message: "آدرس با موفقیت ویرایش شد",
                      status: SnackbarStatus.success,
                    );
                    BlocProvider.of<AddressBloc>(
                      context,
                    ).add(ListAddressEvent());
                    context.pop(true);
                  }
                },

                child: Column(
                  children: [
                    _buildProgress(width, context),

                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [_buildMapPage(), _buildAddressForm(width)],
                      ),
                    ),

                    _buildBottomButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Progress
  // ------------------------------------------------------------

  Widget _buildProgress(double width, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_titles.length * 2 - 1, (index) {
          // خط بین مراحل
          if (index.isOdd) {
            final int realIndex = (index / 2).floor();

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

          // مرحله
          final int stepIndex = (index / 2).floor();

          final bool isActive = stepIndex <= _currentPage;

          final bool isDone = stepIndex < _currentPage;

          return Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // عنوان مرحله
                Text(
                  _titles[stepIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color:
                        isActive
                            ? context.appColors.warning
                            : context.appColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 6),

                // شماره مرحله
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? context.appColors.warning
                            : isDone
                            ? context.appColors.warning.withOpacity(0.3)
                            : context.appColors.textSecondary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${stepIndex + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ------------------------------------------------------------
  // Map
  // ------------------------------------------------------------

  Widget _buildMapPage() {
    LatLng initialCenter = const LatLng(35.6892, 51.3890);

    // اگر Edit است و مختصات قبلی دارد
    if (selectedLatitude != null && selectedLongitude != null) {
      initialCenter = LatLng(selectedLatitude!, selectedLongitude!);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: NeshanLocationPicker(
          mapKey: kMapKey,
          reverseGeocodingApiKey: kReverseGeocodingApiKey,
          // searchApiKey: kSearchApiKey,
          enableDebug: false,

          mapConfig: NeshanMapConfig(
            showCurrentLocationButton: true,
            initialCenter: initialCenter,
            initialZoom: 15,
          ),

          // ------------------------------------------------------
          // Location Accepted
          // ------------------------------------------------------
          onLocationAccepted: (LatLng position, String address) {
            if (!mounted) {
              return;
            }

            setState(() {
              selectedLatitude = position.latitude;

              selectedLongitude = position.longitude;

              selectedMapAddress = address;

              // اگر آدرس دستی وارد نشده،
              // آدرس نشان را قرار بده
              if (addressController.text.trim().isEmpty &&
                  address.trim().isNotEmpty) {
                addressController.text = address;
              }
            });

            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },

          // ------------------------------------------------------
          // Error
          // ------------------------------------------------------
          onError: (message, exception, stackTrace) {
            debugPrint("Neshan picker error: $message");

            if (!mounted) {
              return;
            }
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Address Form
  // ------------------------------------------------------------

  Widget _buildAddressForm(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: context.appColors.card,
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: context.appColors.warning.withValues(alpha: 0.8),
              blurRadius: 5.3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------
                // Location Info
                // ------------------------------------------------
                if (selectedLatitude != null && selectedLongitude != null)
                  _buildLocationInfo(),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Title
                // ------------------------------------------------
                TxtTitle(
                  text: "عنوان آدرس",
                  color: context.appColors.textPrimary,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  isTextStart: true,
                  controller: titleController,
                  hintText: "مثلاً خانه، محل کار",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "عنوان آدرس را وارد کنید";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Province
                // ------------------------------------------------
                TxtTitle(text: "استان", color: context.appColors.textPrimary),

                const SizedBox(height: 10),

                _buildProvinceDropdown(),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // City
                // ------------------------------------------------
                TxtTitle(text: "شهر", color: context.appColors.textPrimary),

                const SizedBox(height: 10),

                _buildCityDropdown(),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Address
                // ------------------------------------------------
                TxtTitle(
                  text: "آدرس دقیق",
                  color: context.appColors.textPrimary,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  isTextStart: true,
                  textInputType: TextInputType.multiline,
                  controller: addressController,
                  hintText: "آدرس دقیق را وارد کنید",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "آدرس دقیق را وارد کنید";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Postal Code
                // ------------------------------------------------
                TxtTitle(text: "کد پستی", color: context.appColors.textPrimary),

                const SizedBox(height: 10),

                CustomTextField(
                  isTextStart: true,
                  controller: postalCodeController,
                  hintText: "کد پستی",
                  textInputType: TextInputType.number,
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // Default Address
                // ------------------------------------------------
                _buildDefaultAddress(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Location Info
  // ------------------------------------------------------------

  Widget _buildLocationInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: context.appColors.secondary),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "موقعیت انتخاب شده",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  selectedMapAddress.trim().isNotEmpty
                      ? selectedMapAddress
                      : "${selectedLatitude!.toStringAsFixed(6)}, "
                          "${selectedLongitude!.toStringAsFixed(6)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            icon: Icon(
              Icons.edit_location_alt_outlined,
              color: context.appColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Province Dropdown
  // ------------------------------------------------------------

  Widget _buildProvinceDropdown() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,

      buildWhen: (previous, current) {
        return previous.provincesStatus != current.provincesStatus;
      },

      builder: (context, state) {
        // ------------------------------------------------------------
        // Loading
        // ------------------------------------------------------------
        if (state.provincesStatus is ProvincesStatusLoading) {
          return _buildDropdownContainer(
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.appColors.secondary,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "در حال دریافت استان‌ها...",
                    style: TextStyle(color: context.appColors.textSecondary),
                  ),
                ),
              ],
            ),
          );
        }

        // ------------------------------------------------------------
        // Error
        // ------------------------------------------------------------
        if (state.provincesStatus is ProvincesStatusError) {
          final status = state.provincesStatus as ProvincesStatusError;

          return _buildDropdownContainer(
            child: Row(
              children: [
                const Icon(Icons.error_outline, size: 21, color: Colors.red),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    status.message ?? "خطا در دریافت استان‌ها",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  tooltip: "تلاش مجدد",
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    profileBloc.add(GetProvincesEvent());
                  },
                  icon: Icon(Icons.refresh, color: context.appColors.secondary),
                ),
              ],
            ),
          );
        }

        // ------------------------------------------------------------
        // Completed
        // ------------------------------------------------------------
        if (state.provincesStatus is ProvincesStatusCompleted) {
          final status = state.provincesStatus as ProvincesStatusCompleted;

          final provinces = status.provincesModel.data ?? [];

          // ----------------------------------------------------------
          // Empty
          // ----------------------------------------------------------
          if (provinces.isEmpty) {
            return _buildDropdownContainer(
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: context.appColors.textSecondary,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "استانی یافت نشد",
                      style: TextStyle(color: context.appColors.textSecondary),
                    ),
                  ),

                  IconButton(
                    tooltip: "تلاش مجدد",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      profileBloc.add(GetProvincesEvent());
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: context.appColors.secondary,
                    ),
                  ),
                ],
              ),
            );
          }

          // ----------------------------------------------------------
          // Dropdown
          // ----------------------------------------------------------
          return _buildDropdownContainer(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value:
                    provinces.any(
                          (province) =>
                              province.id?.toInt() == selectedProvinceId,
                        )
                        ? selectedProvinceId
                        : null,

                isExpanded: true,

                hint: Text(
                  "استان را انتخاب کنید",
                  style: TextStyle(color: context.appColors.textSecondary),
                ),

                items:
                    provinces.map((province) {
                      return DropdownMenuItem<int>(
                        value: province.id?.toInt(),
                        child: Text(province.name ?? ""),
                      );
                    }).toList(),

                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    selectedProvinceId = value;

                    selectedCityId = null;

                    selectedProvince = null;

                    selectedCity = null;
                  });

                  profileBloc.add(GetCitiesEvent(provinceId: value.toString()));
                },
              ),
            ),
          );
        }

        // ------------------------------------------------------------
        // Initial
        // ------------------------------------------------------------
        return _buildDropdownContainer(
          child: Text(
            "استان را انتخاب کنید",
            style: TextStyle(color: context.appColors.textSecondary),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // City Dropdown
  // ------------------------------------------------------------

  Widget _buildCityDropdown() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: profileBloc,
      buildWhen: (previous, current) {
        return previous.citiesStatus != current.citiesStatus;
      },
      builder: (context, state) {
        final bool disabled = selectedProvinceId == null;

        // ------------------------------------------------------------
        // Province not selected
        // ------------------------------------------------------------
        if (disabled) {
          return _buildDropdownContainer(
            child: Row(
              children: [
                Icon(
                  Icons.location_city_outlined,
                  size: 20,
                  color: context.appColors.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "ابتدا استان را انتخاب کنید",
                    style: TextStyle(color: context.appColors.textSecondary),
                  ),
                ),
              ],
            ),
          );
        }

        // ------------------------------------------------------------
        // Loading
        // ------------------------------------------------------------
        if (state.citiesStatus is CitiesStatusLoading) {
          return _buildDropdownContainer(
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.appColors.secondary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "در حال دریافت شهرها...",
                    style: TextStyle(color: context.appColors.textSecondary),
                  ),
                ),
              ],
            ),
          );
        }

        // ------------------------------------------------------------
        // Error
        // ------------------------------------------------------------
        if (state.citiesStatus is CitiesStatusError) {
          final status = state.citiesStatus as CitiesStatusError;

          return _buildDropdownContainer(
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 21, color: Colors.red),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    status.message ?? "خطا در دریافت شهرها",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  tooltip: "تلاش مجدد",
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    profileBloc.add(
                      GetCitiesEvent(
                        provinceId: selectedProvinceId!.toString(),
                      ),
                    );
                  },
                  icon: Icon(Icons.refresh, color: context.appColors.secondary),
                ),
              ],
            ),
          );
        }

        // ------------------------------------------------------------
        // Completed
        // ------------------------------------------------------------
        if (state.citiesStatus is CitiesStatusCompleted) {
          final status = state.citiesStatus as CitiesStatusCompleted;

          final cities = status.citiesModel.data ?? [];

          // ----------------------------------------------------------
          // Empty
          // ----------------------------------------------------------
          if (cities.isEmpty) {
            return _buildDropdownContainer(
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: context.appColors.textSecondary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "شهری برای این استان یافت نشد",
                      style: TextStyle(color: context.appColors.textSecondary),
                    ),
                  ),
                  IconButton(
                    tooltip: "تلاش مجدد",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      profileBloc.add(
                        GetCitiesEvent(
                          provinceId: selectedProvinceId!.toString(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: context.appColors.secondary,
                    ),
                  ),
                ],
              ),
            );
          }

          // ----------------------------------------------------------
          // Dropdown
          // ----------------------------------------------------------
          return Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
              color: context.appColors.inputBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: context.appColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value:
                    cities.any((city) => city.id?.toInt() == selectedCityId)
                        ? selectedCityId
                        : null,

                isExpanded: true,

                hint: Text(
                  "شهر را انتخاب کنید",
                  style: TextStyle(color: context.appColors.textSecondary),
                ),

                items:
                    cities.map((city) {
                      return DropdownMenuItem<int>(
                        value: city.id?.toInt(),
                        child: Text(city.name ?? ""),
                      );
                    }).toList(),

                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedCityId = value;
                  });
                },
              ),
            ),
          );
        }

        // ------------------------------------------------------------
        // Initial
        // ------------------------------------------------------------
        return _buildDropdownContainer(
          child: Text(
            "شهر را انتخاب کنید",
            style: TextStyle(color: context.appColors.textSecondary),
          ),
        );
      },
    );
  }

  Widget _buildDropdownContainer({required Widget child}) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: context.appColors.inputBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.appColors.border),
      ),
      child: child,
    );
  }

  // ------------------------------------------------------------
  // Default Address
  // ------------------------------------------------------------

  Widget _buildDefaultAddress() {
    return Row(
      children: [
        Checkbox(
          value: _isDefault,
          activeColor: context.appColors.secondary,
          onChanged: (value) {
            setState(() {
              _isDefault = value ?? false;
            });
          },
        ),

        Expanded(
          child: Text(
            "این آدرس به عنوان آدرس پیش‌فرض انتخاب شود",
            style: TextStyle(color: context.appColors.textPrimary),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Bottom Buttons
  // ------------------------------------------------------------

  Widget _buildBottomButtons() {
    // صفحه نقشه دکمه پایین ندارد.
    // تأیید موقعیت توسط خود Neshan انجام می‌شود.
    if (_currentPage == 0) {
      return const SizedBox.shrink();
    }

    final bool isLoading =
        addressBloc.state.storeAddressStatus is StoreAddressStatusLoading ||
        addressBloc.state.updateAddressStatus is UpdateAddressStatusLoading;

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: BlocBuilder<AddressBloc, AddressState>(
        buildWhen: (previous, current) {
          return previous.storeAddressStatus != current.storeAddressStatus ||
              previous.updateAddressStatus != current.updateAddressStatus;
        },

        builder: (context, state) {
          if (state.storeAddressStatus is StoreAddressStatusLoading) {
            return DotLoadingWidget(size: 50);
          }
          if (state.updateAddressStatus is UpdateAddressStatusLoading) {
            return DotLoadingWidget(size: 50);
          }
          return Row(
            children: [
              // ------------------------------------------------------
              // Previous
              // ------------------------------------------------------
              Expanded(
                child: OutlinedButton(
                  onPressed: isLoading ? null : _previousPage,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: context.appColors.textPrimary),
                    ),
                  ),
                  child: TxtTitle(
                    text: "مرحله قبل",
                    color: context.appColors.textPrimary,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ------------------------------------------------------
              // Save
              // ------------------------------------------------------
              Expanded(
                child: CustomBtnGradient(
                  title: isEdit ? "ویرایش آدرس" : "ثبت آدرس",
                  onPressed: isLoading ? () {} : _saveAddress,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
