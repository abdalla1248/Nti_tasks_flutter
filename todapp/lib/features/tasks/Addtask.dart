import 'package:flutter/material.dart';
import 'package:todapp/core/utils/app_assets.dart';

import '../../core/helpers/snackbar_helper.dart';
import '../../core/widgets/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;

  const AddTaskScreen({super.key, required this.tasks});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String selectedType = "Home";

  final List<Map<String, dynamic>> taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink},
    {"title": "Personal", "icon": Icons.person, "color": Colors.green},
    {"title": "Work", "icon": Icons.work, "color": Colors.black},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Add Task', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                AppAssets.flag,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            CustomTextField(
              hintText: "Task Title",
              controller: _titleController,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              
              hintText: "Description",
              controller: _descController,
              maxLines: 4,
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: _boxDecoration(),
              
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: selectedType,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: taskTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type["title"],
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: type["color"].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              type["icon"],
                              color: type["color"],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(type["title"], style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedType = value!),
                ),
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _pickDateTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: _boxDecoration(),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 12),
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day} ${_monthName(selectedDate!.month)}, ${selectedDate!.year}"
                          : "Pick a date",
                    ),
                    const Spacer(),
                    Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : "Pick time",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          selectedDate = date;
          selectedTime = time;
        });
      }
    }
  }

  void _submitTask() {
    if (_titleController.text.trim().isEmpty) {
      SnackbarHelper.show(context, 'Please enter a task title', backgroundColor: Colors.red);
      return;
    }

    if (selectedDate == null || selectedTime == null) {
      SnackbarHelper.show(context, 'Please select date and time', backgroundColor: Colors.red);
      return;
    }

    final newTask = {
      "title": _titleController.text.trim(),
      "description": _descController.text.trim(),
      "type": selectedType,
      "date": "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
      "time": selectedTime!.format(context),
      "isCompleted": false,
      "icon": _getIconForType(selectedType),
      "color": _getColorForType(selectedType),
    };

    SnackbarHelper.show(context, 'Task added successfully!', backgroundColor: Colors.green);
    Navigator.pop(context, newTask);
  }

  

  String _monthName(int month) {
    const months = [
      "", "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month];
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case "Home":
        return Icons.home;
      case "Personal":
        return Icons.person;
      case "Work":
        return Icons.work;
      default:
        return Icons.home;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case "Home":
        return Colors.pink;
      case "Personal":
        return Colors.green;
      case "Work":
        return Colors.black;
      default:
        return Colors.pink;
    }
  }
}
