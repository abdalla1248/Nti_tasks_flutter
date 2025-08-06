// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:todo_app/pages/EditTaskPage.dart';
import 'package:todo_app/widgets/custom_text_field.dart';

class ViewTasksPage extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;

  const ViewTasksPage({super.key, required this.tasks});

  @override
  State<ViewTasksPage> createState() => _ViewTasksPageState();
}

class _ViewTasksPageState extends State<ViewTasksPage> {
  List<Map<String, dynamic>> filteredTasks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTasks = List.from(widget.tasks);
  }

  void _searchTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = List.from(widget.tasks);
      } else {
        filteredTasks = widget.tasks.where((task) {
          return task["title"].toLowerCase().contains(query.toLowerCase()) ||
              task["description"].toLowerCase().contains(query.toLowerCase()) ||
              task["type"].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return Colors.green.withAlpha(100);
      case "Done":
        return Colors.green;
      case "Missed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String selectedCategory = 'All';
        String selectedStatus = 'All';
        DateTime? pickedDate;
        TimeOfDay? pickedTime;

        DateTime _parseTaskDate(dynamic rawDate) {
          if (rawDate is DateTime) return rawDate;
          if (rawDate is String) {
            try {
              if (rawDate.contains('/')) {
                final p = rawDate.split('/');
                return DateTime(
                  int.tryParse(p[2]) ?? DateTime.now().year,
                  int.tryParse(p[1]) ?? DateTime.now().month,
                  int.tryParse(p[0]) ?? DateTime.now().day,
                );
              } else {
                return DateTime.parse(rawDate);
              }
            } catch (_) {
              return DateTime.now();
            }
          }
          return DateTime.now();
        }

        String _formatDateTime(DateTime? date, TimeOfDay? time) {
          if (date == null) return "Any date";
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
          String dateStr = "${date.day} ${months[date.month]}, ${date.year}";
          if (time != null) {
            final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
            final minute = time.minute.toString().padLeft(2, '0');
            final ampm = time.hour >= 12 ? 'pm' : 'am';
            return "$dateStr   $hour:$minute $ampm";
          }
          return dateStr;
        }

        return StatefulBuilder(
          builder: (context, dialogSetState) {
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
                dialogSetState(() {
                  pickedDate = d;
                  pickedTime = t;
                });
              }
            }

            return Dialog(
              backgroundColor: Colors.white,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  // Category chips
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories.map((c) {
                        final sel = selectedCategory == c;
                        return ChoiceChip(
                          label: Text(c),
                          selected: sel,
                          onSelected: (_) =>
                              dialogSetState(() => selectedCategory = c),
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
                  ),

                  const SizedBox(height: 12),

                  // Status chips
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: statuses.map((s) {
                        final sel = selectedStatus == s;
                        return ChoiceChip(
                          label: Text(s),
                          selected: sel,
                          onSelected: (_) =>
                              dialogSetState(() => selectedStatus = s),
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
                  ),

                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: _pickDateTime,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
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
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ),
                          if (pickedDate != null)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () => dialogSetState(() {
                                pickedDate = null;
                                pickedTime = null;
                              }),
                            )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var results = buttoncheck(selectedCategory, pickedDate,
                            _parseTaskDate, selectedStatus);

                        Navigator.pop(context);
                        setState(() {
                          filteredTasks = results;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Filter",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      },
    );
  }

  List<Map<String, dynamic>> buttoncheck(
      String selectedCategory,
      DateTime? pickedDate,
      DateTime _parseTaskDate(dynamic rawDate),
      String selectedStatus) {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final results = widget.tasks.where((task) {
      if (selectedCategory != 'All' && task['type'] != selectedCategory)
        return false;

      if (pickedDate != null) {
        final tDate = _parseTaskDate(task['date']);
        if (!(tDate.year == pickedDate!.year &&
            tDate.month == pickedDate!.month &&
            tDate.day == pickedDate!.day)) {
          return false;
        }
      }

      final tDateForStatus = _parseTaskDate(task['date']);
      final bool tCompleted = task['isCompleted'] == true;
      final bool tMissed = !tCompleted && tDateForStatus.isBefore(today);
      final tStatus =
          tMissed ? 'Missed' : (tCompleted ? 'Done' : 'In Progress');

      if (selectedStatus != 'All' && tStatus != selectedStatus) return false;

      return true;
    }).toList();
    return results;
  }

  void _updateTask(Map<String, dynamic> updatedTask, int index) {
    setState(() {
      widget.tasks[index] = updatedTask;
      filteredTasks = List.from(widget.tasks);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      widget.tasks.removeAt(index);
      filteredTasks = List.from(widget.tasks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                
              ),
              child: CustomTextField(
                controller: _searchController,
                hintText: "Search...",
                onChanged: _searchTasks,
                suffixIcon: Icons.search,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  "Results",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${filteredTasks.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                // normalize taskDate (DateTime or string)
                DateTime taskDate;
                final rawDate = task['date'];
                if (rawDate is DateTime) {
                  taskDate = rawDate;
                } else if (rawDate is String) {
                  try {
                    if (rawDate.contains('/')) {
                      final p = rawDate.split('/');
                      taskDate = DateTime(
                        int.tryParse(p[2]) ?? DateTime.now().year,
                        int.tryParse(p[1]) ?? DateTime.now().month,
                        int.tryParse(p[0]) ?? DateTime.now().day,
                      );
                    } else {
                      taskDate = DateTime.parse(rawDate);
                    }
                  } catch (_) {
                    taskDate = DateTime.now();
                  }
                } else {
                  taskDate = DateTime.now();
                }

                final today = DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day);
                final bool isCompleted = task['isCompleted'] == true;
                final bool isMissed = !isCompleted && taskDate.isBefore(today);

                final status = isMissed
                    ? 'Missed'
                    : (isCompleted ? 'Done' : 'In Progress');
                final bool isprogress = !isCompleted;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskPage(
                          task: task,
                          taskIndex: widget.tasks.indexOf(task),
                          onUpdate: _updateTask,
                          onDelete: _deleteTask,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.09),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(100),
                                blurRadius: 5,
                                offset: Offset(0, 4),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage('assets/flag.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                task["description"],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  color:
                                      isprogress ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Icon(
                              task["icon"],
                              color: task["color"],
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            onPressed: () {
              _showFilterDialog();
            },
            icon: const Icon(Icons.tune, color: Colors.white, size: 24),
            padding: const EdgeInsets.all(16),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
