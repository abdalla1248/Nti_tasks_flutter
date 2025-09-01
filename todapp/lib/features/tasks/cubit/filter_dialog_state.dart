import 'package:flutter/material.dart';

class FilterDialogState {
  final String selectedCategory;
  final String selectedStatus;
  final DateTime? pickedDate;
  final TimeOfDay? pickedTime;
  FilterDialogState({
    required this.selectedCategory,
    required this.selectedStatus,
    this.pickedDate,
    this.pickedTime,
  });

  FilterDialogState copyWith({
    String? selectedCategory,
    String? selectedStatus,
    DateTime? pickedDate,
    TimeOfDay? pickedTime,
  }) {
    return FilterDialogState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      pickedDate: pickedDate ?? this.pickedDate,
      pickedTime: pickedTime ?? this.pickedTime,
    );
  }
}
