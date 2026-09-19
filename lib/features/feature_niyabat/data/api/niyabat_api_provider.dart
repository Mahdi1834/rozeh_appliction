import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/niyabat_model_for_send.dart';
import 'package:rozeh_project/locator.dart';

class NiyabatApiProvider {
  final Dio dio;

  NiyabatApiProvider(this.dio);

  // ============================================================
  // Get tavasolat
  // ============================================================

  Future<Response> callGetTavaslats() async {
    final response = await dio.get(
      "${Constants.baseUrl}/public/niyabat/tavaslats",
      options: Options(headers: {"Accept": "application/json"}),
    );

    return response;
  }

  // ============================================================
  // Get intention
  // ============================================================

  Future<Response> callGetIntention() async {
    final response = await dio.get(
      "${Constants.baseUrl}/public/niyabat/intentions",
      options: Options(headers: {"Accept": "application/json"}),
    );

    return response;
  }

  // ============================================================
  // Get Niyabates
  // ============================================================

  Future<Response> callGetListNiyabat({int page = 1}) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.get(
      "${Constants.baseUrl}/niyabat/calendar",
      queryParameters: {'page': page},
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
  // Create Niyabat
  // ============================================================

  Future<Response> callCreateNiyabat({
    required NiyabatModelForSend niyabatModelForSend,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.post(
      "${Constants.baseUrl}/niyabat/calendar",
      data: niyabatModelForSend.toJson(),
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
  // Update Niyabat
  // ============================================================

  Future<Response> callUpdateNiyabat({
    required int niyabatId,
    required NiyabatModelForSend niyabatModelForSend,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.put(
      "${Constants.baseUrl}/niyabat/calendar/$niyabatId",
      data: niyabatModelForSend.toJson(),
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
  // Delete Niyabat
  // ============================================================

  Future<Response> callDeleteNiyabat({required int niyabatId}) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.delete(
      "${Constants.baseUrl}/niyabat/calendar/$niyabatId",
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
