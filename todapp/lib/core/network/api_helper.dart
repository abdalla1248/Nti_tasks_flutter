import 'package:dio/dio.dart';

import 'api_response.dart';
import 'end_points.dart';

class ApiHelper
{
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    return _instance;
  }
  ApiHelper._init();

  Dio dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.ecoBaseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      )
  );
  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
    bool sendRefreshToken = false
  }) async
  {
    return ApiResponse.fromResponse(await dio.post(
        endPoint,
        data: isFormData? FormData.fromMap(data??{}): data,
    ));
  }
  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = true,
    bool isProtected = false
  }) async
  {
    return ApiResponse.fromResponse(await dio.get(
      endPoint,
      queryParameters: queryParameters,
      data: isFormData? FormData.fromMap(data??{}): data,
    ));
  }

}


