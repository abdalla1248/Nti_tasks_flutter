import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/explore_view/cubit/news_state.dart';
import 'package:news_app/features/explore_view/data/repo/news_repo.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);

  final TextEditingController searchController = TextEditingController();
  String currentCategory = "travel"; // default start

  // Load news by category
  Future<void> getNews({String? category}) async {
    emit(NewsLoading());
    final repo = NewsRepo();
    final response =
        await repo.getNews(searchKeyWord: category ?? currentCategory);

    response.fold(
      (error) => emit(NewsError(error)),
      (articles) {
        currentCategory = category ?? currentCategory;
        emit(NewsSuccess(articles));
      },
    );
  }

  // Search news
  Future<void> getNewsBySearch(String query) async {
    emit(NewsLoading());
    final repo = NewsRepo();
    final response = await repo.getNews(searchKeyWord: query);

    response.fold(
      (error) => emit(NewsError(error)),
      (articles) => emit(NewsSuccess(articles)),
    );
  }
}
