import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_response.dart';
import 'end_points.dart';

class ApiHelper {
  // Singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() => _instance;
  ApiHelper._init();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.ecoBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    try {
      final options = await _buildOptions(isProtected);

      final response = await dio.post(
        endPoint,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: options,
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = true,
    bool isProtected = false,
  }) async {
    try {
      final options = await _buildOptions(isProtected);

      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
        options: options,
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  /// Builds request headers if token is needed
  Future<Options> _buildOptions(bool isProtected) async {
    final options = Options();

    if (isProtected) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token != null && token.isNotEmpty) {
        options.headers = {
          "Authorization": "Bearer $token",
        };
      }
    }

    return options;
  }
}
