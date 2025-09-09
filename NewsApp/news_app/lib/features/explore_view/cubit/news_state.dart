import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final ArticlesResponseModels articlesResponseModels;
  NewsSuccess(this.articlesResponseModels);
}

class NewsError extends NewsState {
  final String error;
  NewsError(this.error);
}
