import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/feature/bookmark/cubit/bookmark_cubit.dart';

void main() {
  group('BookmarkCubit', () {
    late BookmarkCubit cubit;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      cubit = BookmarkCubit();
    });

    test('Initial state is empty', () {
      expect(cubit.state, []);
    });

    test('Add bookmark', () async {
      await cubit.addBookmark('Test Bookmark' as ArticlesModel);
      expect(cubit.state, ['Test Bookmark']);
    });

    test('Remove bookmark', () async {
      await cubit.addBookmark('Test Bookmark' as ArticlesModel);
      await cubit.removeBookmark('Test Bookmark' as ArticlesModel);
      expect(cubit.state, []);
    });
  });
}
