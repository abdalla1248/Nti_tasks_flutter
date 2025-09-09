import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkCubit extends Cubit<List<ArticlesModel>> {
  static final BookmarkCubit _instance = BookmarkCubit._internal();
  factory BookmarkCubit() => _instance;

  BookmarkCubit._internal() : super([]) {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedBookmarks = prefs.getStringList('bookmarks');
    if (savedBookmarks != null) {
      final List<ArticlesModel> loadedBookmarks = savedBookmarks
          .map((jsonString) =>
              ArticlesModel.fromJson(jsonDecode(jsonString)))
          .toList();
      emit(loadedBookmarks);
    }
  }

  Future<void> addBookmark(ArticlesModel article) async {
    final updatedBookmarks = [...state, article];
    emit(updatedBookmarks);
    await _saveBookmarks(updatedBookmarks);
  }

  Future<void> removeBookmark(ArticlesModel article) async {
    final updatedBookmarks =
        state.where((a) => a.url != article.url).toList(); // use unique url
    emit(updatedBookmarks);
    await _saveBookmarks(updatedBookmarks);
  }

  Future<void> _saveBookmarks(List<ArticlesModel> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        bookmarks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('bookmarks', jsonList);
  }
}
