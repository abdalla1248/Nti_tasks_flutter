import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/features/tasks/cubit/view_tasks_cubit.dart';
class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String selectedCategory = 'All';
  String selectedStatus = 'All';
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  final categories = ['All', 'Work', 'Home', 'Personal'];
  final statuses = ['All', 'In Progress', 'Missed', 'Done'];

  Future<void> _pickDateTime() async {
    final d = await showDatePicker(
      context: context,
      initialDate: pickedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) {
      final t = await showTimePicker(
        context: context,
        initialTime: pickedTime ?? TimeOfDay.now(),
      );
      setState(() {
        pickedDate = d;
        pickedTime = t;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewTasksCubit>();

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category chips (2 rows)
            _buildFilterRow(categories.sublist(0, 3), selectedCategory, (c) => setState(() => selectedCategory = c)),
            const SizedBox(height: 8),
            _buildFilterRow([categories[3]], selectedCategory, (c) => setState(() => selectedCategory = c)),
            const SizedBox(height: 18),
            // Status chips (2 rows)
            _buildFilterRow(statuses.sublist(0, 3), selectedStatus, (s) => setState(() => selectedStatus = s)),
            const SizedBox(height: 8),
            _buildFilterRow([statuses[3]], selectedStatus, (s) => setState(() => selectedStatus = s)),
            const SizedBox(height: 22),
            // Date/time picker
            GestureDetector(
              onTap: _pickDateTime,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 10),
                    Text(
                      pickedDate != null
                          ? "${pickedDate!.day} ${_monthName(pickedDate!.month)}, ${pickedDate!.year}"
                          : "Any date",
                      style: const TextStyle(fontSize: 15),
                    ),
                    if (pickedTime != null && pickedDate != null) ...[
                      const SizedBox(width: 10),
                      Text(_formatTime(pickedTime!), style: const TextStyle(fontSize: 15)),
                    ],
                    const Spacer(),
                    if (pickedDate != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() {
                          pickedDate = null;
                          pickedTime = null;
                        }),
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
                  cubit.filterTasks(
                    category: selectedCategory,
                    status: selectedStatus,
                    date: pickedDate,
                    time: pickedTime,
                  );
                  Navigator.pop(context);
                },
                child: const Text("Filter", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow(List<String> items, String selectedItem, Function(String) onSelected) {
    return Row(
      children: items.map((item) {
        final isSelected = selectedItem == item;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: OutlinedButton(
            onPressed: () => onSelected(item),
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? Colors.green : Colors.white,
              side: BorderSide(color: Colors.green, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              elevation: 0,
            ),
            child: Text(
              item,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June', 'July',
      'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final period = t.period == DayPeriod.am ? 'am' : 'pm';
    return '${hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')} $period';
  }
}
