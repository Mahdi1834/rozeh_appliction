import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/customer_address_model_for_send.dart';
import 'package:rozeh_project/locator.dart';

class AddressApiProvider {
  final Dio dio;

  AddressApiProvider(this.dio);

  // ============================================================
  // Get Addresses
  // ============================================================

  Future<Response> callGetAddresses() async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.get(
      "${Constants.baseUrl}/customer/addresses",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }

  // ============================================================
  // Create Address
  // ============================================================

  Future<Response> callCreateAddress({
    required CustomerAddressModelForSend addressModel,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.post(
      "${Constants.baseUrl}/customer/addresses",
      data: addressModel.toJson(),
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }

  // ============================================================
  // Update Address
  // ============================================================

  Future<Response> callUpdateAddress({
    required int addressId,
    required CustomerAddressModelForSend addressModel,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.put(
      "${Constants.baseUrl}/customer/addresses/$addressId",
      data: addressModel.toJson(),
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }

  // ============================================================
  // Delete Address
  // ============================================================

  Future<Response> callDeleteAddress({
    required int addressId,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.delete(
      "${Constants.baseUrl}/customer/addresses/$addressId",
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }
}