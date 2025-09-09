import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';

class NewsRepo {
  final String _apiKey = "a426c5614f414130a6db375ce60f325d";

  Future<Either<String, ArticlesResponseModels>> getNews(
      {String searchKeyWord = "travel"}) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://newsapi.org/v2/everything?q=$searchKeyWord&apiKey=$_apiKey",
      );

      final articlesResponse =
          ArticlesResponseModels.fromJson(response.data as Map<String, dynamic>);

      return Right(articlesResponse);
    } on DioException catch (e) {
      final errorResponse = e.response?.data as Map<String, dynamic>?;
      return Left(errorResponse?['message'] ?? "Network error");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
