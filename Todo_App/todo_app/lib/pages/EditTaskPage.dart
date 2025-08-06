import 'package:flutter/material.dart';

class EditTaskPage extends StatefulWidget {
  final Map<String, dynamic> task;
  final int taskIndex;
  final Function(Map<String, dynamic> updatedTask, int index) onUpdate;
  final Function(int index) onDelete;

  const EditTaskPage({
    super.key,
    required this.task,
    required this.taskIndex,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late String selectedType;
  late TextEditingController titleController;
  late TextEditingController descController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    selectedType = widget.task['type'];
    titleController = TextEditingController(text: widget.task['title']);
    descController = TextEditingController(text: widget.task['description']);
    isCompleted = widget.task['isCompleted'] ?? false;

    final dateParts = (widget.task['date'] ?? '').split('/');
    final timeParts = (widget.task['time'] ?? '').split(":");

    if (dateParts.length == 3 && timeParts.length == 2) {
      selectedDate = DateTime(
        int.tryParse(dateParts[2]) ?? DateTime.now().year,
        int.tryParse(dateParts[1]) ?? DateTime.now().month,
        int.tryParse(dateParts[0]) ?? DateTime.now().day,
      );
      selectedTime = TimeOfDay(
        hour: int.tryParse(timeParts[0]) ?? 12,
        minute: int.tryParse(timeParts[1].split(' ')[0]) ?? 0,
      );
    } else {
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
    }
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  void _updateTask() {
    final updatedTask = {
      ...widget.task,
      'type': selectedType,
      'title': titleController.text,
      'description': descController.text,
      'date': "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
      'time': selectedTime.format(context),
      'isCompleted': isCompleted,
    };
    widget.onUpdate(updatedTask, widget.taskIndex);
    Navigator.pop(context);
  }

  void _deleteTask() {
    widget.onDelete(widget.taskIndex);
    Navigator.pop(context);
  }

  String _monthName(int month) {
    const months = [
      '',
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    bool isMissed = !isCompleted &&
        DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ).isBefore(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Task",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton.icon(
              onPressed: _deleteTask,
              icon: const Icon(Icons.delete, color: Colors.white, size: 18),
              label: const Text("Delete", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: const DecorationImage(
                      image: AssetImage('assets/flag.png'),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 5,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isMissed ? 'Missed' : isCompleted ? "Done" : "In Progress",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isMissed
                            ? ''
                            : isCompleted
                                ? 'Congrats!'
                                : 'Believe you can, and you\'re halfway there.',
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedType,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: [
                    DropdownMenuItem(
                      value: 'Home',
                      child: Row(
                        children: const [
                          Icon(Icons.home, color: Colors.pink),
                          SizedBox(width: 8),
                          Text('Home'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Personal',
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Colors.green),
                          SizedBox(width: 8),
                          Text('Personal'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Work',
                      child: Row(
                        children: const [
                          Icon(Icons.work, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Work'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) => setState(() => selectedType = value!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                _pickDate();
                _pickTime();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "${selectedDate.day} ${_monthName(selectedDate.month)}, ${selectedDate.year}    ${selectedTime.format(context)}",
                      style: const TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!isCompleted)
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setState(() => isCompleted = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Mark as Done", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _updateTask,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
