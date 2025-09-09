import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void changePage(int index) => emit(index);

  void nextPage(int totalPages) {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  void skipToLast(int totalPages) => emit(totalPages - 1);
}
