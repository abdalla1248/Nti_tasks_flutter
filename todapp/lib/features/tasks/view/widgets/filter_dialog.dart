import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_text_styles.dart';
import '../../cubit/filter_dialog_cubit.dart';
import '../../cubit/filter_dialog_state.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  static const categories = ['All', 'Work', 'Home', 'Personal'];
  static const statuses = ['All', 'In Progress', 'Missed', 'Done'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterDialogCubit(),
      child: BlocBuilder<FilterDialogCubit, FilterDialogState>(
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Dialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.all(constraints.maxWidth < 400 ? 12 : 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category chips (2 rows)
                        _buildFilterRow(
                            categories.sublist(0, 3),
                            state.selectedCategory,
                            (c) => context
                                .read<FilterDialogCubit>()
                                .setCategory(c),
                            constraints),
                        const SizedBox(height: 8),
                        _buildFilterRow(
                            [categories[3]],
                            state.selectedCategory,
                            (c) => context
                                .read<FilterDialogCubit>()
                                .setCategory(c),
                            constraints),
                        const SizedBox(height: 18),
                        // Status chips (2 rows)
                        _buildFilterRow(
                            statuses.sublist(0, 3),
                            state.selectedStatus,
                            (s) =>
                                context.read<FilterDialogCubit>().setStatus(s),
                            constraints),
                        const SizedBox(height: 8),
                        _buildFilterRow(
                            [statuses[3]],
                            state.selectedStatus,
                            (s) =>
                                context.read<FilterDialogCubit>().setStatus(s),
                            constraints),
                        const SizedBox(height: 22),
                        // Date/time picker
                        GestureDetector(
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: state.pickedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            context.read<FilterDialogCubit>().setDateTime(d);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    constraints.maxWidth < 400 ? 10 : 14,
                                vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: Colors.green),
                                const SizedBox(width: 10),
                                Text(
                                  state.pickedDate != null
                                      ? "${state.pickedDate!.day} ${_monthName(state.pickedDate!.month)}, ${state.pickedDate!.year}"
                                      : "Any date",
                                  style: const TextStyle(fontSize: 15),
                                ),
                                if (state.pickedDate != null)
                                  IconButton(
                                    icon: const Icon(Icons.clear, size: 18),
                                    onPressed: () => context
                                        .read<FilterDialogCubit>()
                                        .clearDateTime(),
                                  )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Filter button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            onPressed: () {
                              AppNavigator.pop(context, state);
                            },
                            child: Text("Filter", style: AppTextStyles.button),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterRow(List<String> items, String selectedItem,
      Function(String) onSelected, BoxConstraints constraints) {
    return Row(
      children: items.map((item) {
        final isSelected = selectedItem == item;
        return Padding(
          padding: EdgeInsets.only(right: constraints.maxWidth < 400 ? 6 : 10),
          child: OutlinedButton(
            onPressed: () => onSelected(item),
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? Colors.green : Colors.white,
              side: BorderSide(color: Colors.green, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth < 400 ? 12 : 18,
                vertical: 8,
              ),
              elevation: 0,
            ),
            child: Text(
              item,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: constraints.maxWidth < 400 ? 13 : 15,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  static String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }
}
