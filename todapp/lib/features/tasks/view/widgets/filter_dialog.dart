import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Function({
    required String category,
    required String status,
    DateTime? date,
    TimeOfDay? time,
  }) onFilter;

  const FilterDialog({super.key, required this.onFilter});

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

  String _formatDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null) return "Any date";
    const months = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    String dateStr = "${date.day} ${months[date.month]}, ${date.year}";
    if (time != null) {
      final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
      final minute = time.minute.toString().padLeft(2, '0');
      final ampm = time.hour >= 12 ? 'pm' : 'am';
      return "$dateStr   $hour:$minute $ampm";
    }
    return dateStr;
  }

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
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // Category chips
          _buildChoiceChips(categories, selectedCategory, (c) {
            setState(() => selectedCategory = c);
          }),

          const SizedBox(height: 12),

          // Status chips
          _buildChoiceChips(statuses, selectedStatus, (s) {
            setState(() => selectedStatus = s);
          }),

          const SizedBox(height: 16),

          // Date picker
          GestureDetector(
            onTap: _pickDateTime,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _formatDateTime(pickedDate, pickedTime),
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  if (pickedDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        setState(() {
                          pickedDate = null;
                          pickedTime = null;
                        });
                      },
                    )
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Filter button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onFilter(
                  category: selectedCategory,
                  status: selectedStatus,
                  date: pickedDate,
                  time: pickedTime,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Filter",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildChoiceChips(
    List<String> items,
    String selectedItem,
    Function(String) onSelected,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items.map((item) {
          final sel = selectedItem == item;
          return ChoiceChip(
            label: Text(item),
            selected: sel,
            onSelected: (_) => onSelected(item),
            selectedColor: Colors.green,
            backgroundColor: Colors.white,
            labelStyle: TextStyle(
              color: sel ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
            shape: const StadiumBorder(
                side: BorderSide(color: Colors.black26)),
          );
        }).toList(),
      ),
    );
  }
}
