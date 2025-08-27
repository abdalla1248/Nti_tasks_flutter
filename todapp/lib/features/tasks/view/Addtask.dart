import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/helpers/snackbar_helper.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/add_task._state.dart';
import '../cubit/add_task_cubit.dart';
class AddTaskScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  const AddTaskScreen({super.key, required this.tasks});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is AddTaskFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AddTaskSuccess) {
            // Pop the new task back to Home so it can be added immediately
            Navigator.pop(context, state.task);
            SnackbarHelper.show(context, 'Task added successfully!',
                backgroundColor: Colors.green);
          }
        },
        builder: (context, state) {
          final cubit = AddTaskCubit.get(context);
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
              title:
                  const Text('Add Task', style: TextStyle(color: Colors.black)),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
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
                    controller: cubit.titleController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Description",
                    controller: cubit.descController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: _boxDecoration(),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: cubit.selectedType,
                        items: cubit.taskTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type["title"],
                            child: Row(
                              children: [
                                Icon(type["icon"], color: type["color"]),
                                const SizedBox(width: 12),
                                Text(type["title"]),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) => cubit.changeType(value!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) cubit.pickDate(date);

                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) cubit.pickTime(time);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _boxDecoration(),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.green),
                          const SizedBox(width: 12),
                          Text(
                            cubit.selectedDate != null
                                ? "${cubit.selectedDate!.day}/${cubit.selectedDate!.month}/${cubit.selectedDate!.year}"
                                : "Pick a date",
                          ),
                          const Spacer(),
                          Text(
                            cubit.selectedTime != null
                                ? cubit.selectedTime!.format(context)
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
                      onPressed: state is AddTaskLoading
                          ? null
                          : () => cubit.submitTask(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is AddTaskLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Add Task',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    );
  }
}
