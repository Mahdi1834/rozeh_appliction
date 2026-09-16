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
                                      child: CustomBtnGradient(

                                        onPressed: () {
                                          addressBloc.add(ListAddressEvent());
                                        },
                                        title:"تلاش مجدد",
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

  const _AddressItem({
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appColors;

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 4),
      decoration: BoxDecoration(
        color: theme.navigationBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
          address.isDefault == true
              ? theme.primary
              : theme.border,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primary.withValues(alpha: 0.15),
            blurRadius: 5.3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ============================================================
                  // عنوان + پیش‌فرض
                  // ============================================================
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.primary,
                              theme.primary.withValues(alpha: 0.70),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.title ?? 'بدون عنوان',
                              style: TextStyle(
                                color: theme.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              _getLocationName(address),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.textPrimary.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // پیش‌فرض
                      if (address.isDefault == true)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: theme.primary.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.primary.withValues(alpha: 0.20),
                            ),
                          ),
                          child: Text(
                            'پیش‌فرض',
                            style: TextStyle(
                              color: theme.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ============================================================
                  // آدرس
                  // ============================================================
                  _buildInfoRow(
                    context,
                    icon: Icons.home_outlined,
                    title: 'آدرس',
                    value: address.address ?? 'آدرس ثبت نشده',
                  ),

                  // ============================================================
                  // کد پستی
                  // ============================================================
                  if (address.postalCode != null &&
                      address.postalCode!.isNotEmpty) ...[
                    const SizedBox(height: 10),

                    _buildInfoRow(
                      context,
                      icon: Icons.markunread_mailbox_outlined,
                      title: 'کد پستی',
                      value: address.postalCode!,
                    ),
                  ],

                  const SizedBox(height: 12),

                  // ============================================================
                  // مشاهده و ویرایش
                  // ============================================================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: theme.primary.withValues(alpha: 0.10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_location_alt_outlined,
                          size: 17,
                          color: theme.primary,
                        ),

                        const SizedBox(width: 7),

                        Expanded(
                          child: Text(
                            'مشاهده و ویرایش آدرس',
                            style: TextStyle(
                              color: theme.textPrimary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 13,
                          color: theme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Info Row
  // ============================================================

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
      }) {
    final theme = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: theme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            size: 18,
            color: theme.primary,
          ),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.textPrimary.withValues(alpha: 0.50),
                ),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.textPrimary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // Province / City
  // ============================================================

  String _getLocationName(Addresses address) {
    final province = address.province?.name;
    final city = address.city?.name;

    if (province != null && city != null) {
      return '$province، $city';
    }

    if (city != null) {
      return city;
    }

    if (province != null) {
      return province;
    }

    return 'استان و شهر مشخص نشده';
  }
}
