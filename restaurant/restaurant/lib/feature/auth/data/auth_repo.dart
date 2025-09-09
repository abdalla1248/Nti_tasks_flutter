import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/feature/auth/data/model/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_helper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/end_points.dart';
import 'model/user_model.dart';

class AuthRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.status) {
        final loginResponseModel =
            LoginResponseModel.fromJson(response.data as Map<String, dynamic>);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('access_token', loginResponseModel.accessToken ?? '');
        prefs.setString('refresh_token', loginResponseModel.refreshToken ?? '');

        return Right(loginResponseModel.user!);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, Unit>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }

      final response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: data,
      );

      if (response.status) {
        return right(unit);
      } else {
        return left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
