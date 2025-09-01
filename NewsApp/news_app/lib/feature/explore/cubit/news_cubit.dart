import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repo/news_repo.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;

  NewsCubit(this.newsRepo) : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  Future<void> getNews() async {
    emit(NewsLoading());
    final response = await newsRepo.getEveryThing();

    response.fold(
      (error) => emit(NewsError(error)),
      (model) => emit(NewsSuccess(model)),
    );
  }
}
