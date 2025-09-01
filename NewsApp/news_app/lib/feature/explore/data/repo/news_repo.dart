import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../model/news_model.dart';

class NewsRepo
{
  Future<Either<String, ArticleResponsModel>> getEveryThing()async
  {
    try
    {
      var dio = Dio();
      var response = await dio.get(
          'https://newsapi.org/v2/everything?q=sport&apiKey=836086f05b344448a16dd41ee51c6320'
      );

      ArticleResponsModel model = ArticleResponsModel.fromJson(response.data as Map<String, dynamic>);
      return Right(model);
    }
    on DioException catch(e)
    {
      var errorResponse = e.response?.data as Map<String, dynamic>;

      print(errorResponse['message']);
      return Left(errorResponse['message']);
    }
    catch(e)
    {
      print(e.toString());
      return Left(e.toString());
    }
  }
}