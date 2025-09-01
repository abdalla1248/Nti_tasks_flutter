

import '../data/model/news_model.dart';

abstract class NewsState{}

class NewsInitial extends NewsState{}
class NewsLoading extends NewsState{}
class NewsSuccess extends NewsState
{
  ArticleResponsModel model;
  NewsSuccess(this.model);
}
class NewsError extends NewsState
{
  String error;
  NewsError(this.error);
}