import 'package:dartz/dartz.dart';
import 'package:restaurant/core/network/api_helper.dart';
import 'package:restaurant/core/network/api_response.dart';
import 'package:restaurant/core/network/end_points.dart';
import 'package:restaurant/feature/home/data/model/product_model.dart';
import 'package:restaurant/feature/home/data/model/sliders_model.dart';

class HomeRepo {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, SlidersModel>> getSliders() async {
    try {
      ApiResponse response = await _apiHelper.getRequest(
        endPoint: EndPoints.sliders,
        isProtected: true,
      );
      if (response.status && response.data != null) {
        return Right(SlidersModel.fromJson(response.data));
      } else {
        return Left('Failed to load sliders');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductModel>> getBestSellerProducts() async {
    try {
      ApiResponse response = await _apiHelper.getRequest(
        endPoint: EndPoints.bestSellerProducts,
        isProtected: true,
      );
      if (response.status && response.data != null) {
        return Right(ProductModel.fromJson(response.data));
      } else {
        return Left('Failed to load best seller products');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductModel>> getTopRatedProducts() async {
    try {
      ApiResponse response = await _apiHelper.getRequest(
        endPoint: EndPoints.topRatedProducts,
        isProtected: true,
      );
      if (response.status && response.data != null) {
        return Right(ProductModel.fromJson(response.data));
      } else {
        return Left('Failed to load top rated products');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
