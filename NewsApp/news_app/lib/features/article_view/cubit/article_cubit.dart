import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/article_view/cubit/article_state.dart';

class ArticleCubit extends Cubit<ArticleState>{
  ArticleCubit():super(InitialState());
  static ArticleCubit get(context)=>BlocProvider.of(context);
  bool bookMark = false;

  changeBookmark(){
    bookMark = !bookMark;
    emit(BookmarkVisibility());
  }

  String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return "${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }

}