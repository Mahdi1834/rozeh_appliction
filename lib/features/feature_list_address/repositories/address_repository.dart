import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_list_address/data/api/address_api_provider.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/customer_address_model_for_send.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/delete_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/list_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/store_address_model.dart';

class AddressRepository {
  final AddressApiProvider apiProvider;

  AddressRepository(this.apiProvider);

  // ============================================================
  // Get Addresses
  // ============================================================

  Future<DataState<ListAddressModel>> fetchAddresses() async {
    try {
      final Response response = await apiProvider.callGetAddresses();

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final ListAddressModel listAddressModel =
        ListAddressModel.fromJson(response.data);

        return DataSuccess(listAddressModel);
      }

      return DataFailed(
        "خطا در دریافت آدرس ها !!!",
      );
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Create Address
  // ============================================================

  Future<DataState<StoreAddressModel>> createAddress({
    required CustomerAddressModelForSend addressModel,
  }) async {
    try {
      final Response response = await apiProvider.callCreateAddress(
        addressModel: addressModel,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final StoreAddressModel storeAddressModel =
        StoreAddressModel.fromJson(response.data);

        return DataSuccess(storeAddressModel);
      }

      return DataFailed(
        "خطا در ثبت آدرس !!!",
      );
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Update Address
  // ============================================================

  Future<DataState<StoreAddressModel>> updateAddress({
    required int addressId,
    required CustomerAddressModelForSend addressModel,
  }) async {
    try {
      final Response response = await apiProvider.callUpdateAddress(
        addressId: addressId,
        addressModel: addressModel,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final StoreAddressModel storeAddressModel =
        StoreAddressModel.fromJson(response.data);

        return DataSuccess(storeAddressModel);
      }

      return DataFailed(
        "خطا در ویرایش آدرس !!!",
      );
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Delete Address
  // ============================================================

  Future<DataState<DeleteAddressModel>> deleteAddress({
    required int addressId,
  }) async {
    try {
      final Response response = await apiProvider.callDeleteAddress(
        addressId: addressId,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final DeleteAddressModel deleteAddressModel =
        DeleteAddressModel.fromJson(response.data);

        return DataSuccess(deleteAddressModel);
      }

      return DataFailed(
        "خطا در حذف آدرس !!!",
      );
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }
}