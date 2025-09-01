import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_dialog_state.dart';


class FilterDialogCubit extends Cubit<FilterDialogState> {
  FilterDialogCubit()
      : super(FilterDialogState(
          selectedCategory: 'All',
          selectedStatus: 'All',
        ));

  void setCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setStatus(String status) {
    emit(state.copyWith(selectedStatus: status));
  }

  void setDateTime(DateTime? date, ) {
    emit(state.copyWith(pickedDate: date));
  }

  void clearDateTime() {
    emit(state.copyWith(pickedDate: null, pickedTime: null));
  }
}
