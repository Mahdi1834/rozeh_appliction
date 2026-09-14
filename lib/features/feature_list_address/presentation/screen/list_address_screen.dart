import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rozeh_project/core/config/theme/theme_extensions.dart';
import 'package:rozeh_project/core/widgets/app_bar/custom_app_bar_with_txt_one_icon.dart';
import 'package:rozeh_project/core/widgets/custom_btn_gradient.dart';
import 'package:rozeh_project/core/widgets/dot_loading_widget.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/list_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/bloc/address_bloc.dart';
import 'package:rozeh_project/features/feature_list_address/presentation/screen/address_screen.dart';
import 'package:rozeh_project/locator.dart';

class ListAddressScreen extends StatefulWidget {
  static const routePath = "list_address_screen";
  static const routeName = "list_address_screen";

  const ListAddressScreen({super.key});

  @override
  State<ListAddressScreen> createState() => _ListAddressScreenState();
}

class _ListAddressScreenState extends State<ListAddressScreen> {
  late AddressBloc addressBloc;

  @override
  void initState() {
    super.initState();

    addressBloc = locator<AddressBloc>();

    addressBloc.add(ListAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: context.appColors.inputBackground,
          child: Column(
            children: [
              CustomAppBarBackBtn(
                mainContext: context,
                title: "مدیریت آدرس ها",
              ),

              const SizedBox(height: 10),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<AddressBloc, AddressState>(
                        bloc: addressBloc,
                        builder: (context, state) {
                          final status = state.listAddressStatus;

                          // ==================================================
                          // Loading
                          // ==================================================

                          if (status is ListAddressStatusLoading) {
                            return const DotLoadingWidget(size: 50);
                          }

                          // ==================================================
                          // Error
                          // ==================================================

                          if (status is ListAddressStatusError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      size: 55,
                                      color: context.appColors.textSecondary,
                                    ),

                                    const SizedBox(height: 15),

                                    Text(
                                      status.message!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: context.appColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    SizedBox(
                                      width: 150,
                                      height: 45,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          addressBloc.add(ListAddressEvent());
                                        },
                                        child: const Text("تلاش مجدد"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // ==================================================
                          // Completed
                          // ==================================================

                          if (status is ListAddressStatusCompleted) {
                            final ListAddressModel listModel =
                                status.listAddressModel;

                            final addresses = listModel.data?.addresses ?? [];

                            // ==============================================
                            // Empty
                            // ==============================================

                            if (addresses.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_off_outlined,
                                      size: 65,
                                      color: context.appColors.textSecondary,
                                    ),

                                    const SizedBox(height: 15),

                                    Text(
                                      "هنوز آدرسی ثبت نکرده‌اید",
                                      style: TextStyle(
                                        color: context.appColors.textSecondary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "برای ثبت آدرس جدید روی دکمه پایین صفحه بزنید",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: context.appColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            // ==============================================
                            // Address List
                            // ==============================================

                            return RefreshIndicator(
                              onRefresh: () async {
                                addressBloc.add(ListAddressEvent());
                              },
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                itemCount: addresses.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) {
                                  final address = addresses[index];

                                  return _AddressItem(
                                    address: address,
                                    onTap: () {
                                      context.pushNamed(
                                        AddressScreen.routeName,
                                        extra: address,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }

                          // ==================================================
                          // Initial
                          // ==================================================

                          return const SizedBox();
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ========================================================
                    // Add Address Button
                    // ========================================================
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 50,
                      child: CustomBtnGradient(
                        title: "افزودن آدرس جدید",
                        onPressed: () {
                          context.pushNamed(AddressScreen.routeName);
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Address Item
// ============================================================================

class _AddressItem extends StatelessWidget {
  final Addresses address;
  final VoidCallback onTap;

  const _AddressItem({required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color:
                address.isDefault == true
                    ? context.appColors.primary
                    : context.appColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================================================================
            // Title + Default
            // ================================================================
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: context.appColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: context.appColors.primary,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    address.title ?? "بدون عنوان",
                    style: TextStyle(
                      color: context.appColors.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                if (address.isDefault == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: context.appColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "پیش‌فرض",
                      style: TextStyle(
                        color: context.appColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // ================================================================
            // Province / City
            // ================================================================
            Row(
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 18,
                  color: context.appColors.textSecondary,
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: Text(
                    _getLocationName(address),
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // ================================================================
            // Address
            // ================================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.home_outlined,
                  size: 18,
                  color: context.appColors.textSecondary,
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: Text(
                    address.address ?? "-",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.appColors.textPrimary,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),

            // ================================================================
            // Postal Code
            // ================================================================
            if (address.postalCode != null &&
                address.postalCode!.isNotEmpty) ...[
              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(
                    Icons.markunread_mailbox_outlined,
                    size: 18,
                    color: context.appColors.textSecondary,
                  ),

                  const SizedBox(width: 7),

                  Text(
                    "کد پستی: ${address.postalCode}",
                    style: TextStyle(
                      color: context.appColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 12),

            // ================================================================
            // Edit
            // ================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "مشاهده و ویرایش",
                  style: TextStyle(
                    color: context.appColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(width: 4),

                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 13,
                  color: context.appColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getLocationName(Addresses address) {
    final province = address.province?.name;
    final city = address.city?.name;

    if (province != null && city != null) {
      return "$province، $city";
    }

    if (city != null) {
      return city;
    }

    if (province != null) {
      return province;
    }

    return "استان و شهر مشخص نشده";
  }
}
