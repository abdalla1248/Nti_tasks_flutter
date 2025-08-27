
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';
import '../cubit/edit_task_cubit.dart';

class EditTaskPage extends StatelessWidget {
  final TaskModel task;
  const EditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTaskCubit(TaskRepo())..init(task),
      child: BlocConsumer<EditTaskCubit, EditTaskState>(
        listener: (context, state) {
          if (state is EditTaskError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is EditTaskSuccess || state is EditTaskDeleted) {
            Navigator.pop(context, state is EditTaskSuccess ? state.task : null);
          }
        },
        builder: (context, state) {
          if (state is! EditTaskLoaded && state is! EditTaskSuccess) {
            return const Center(child: CircularProgressIndicator());
          }

          final taskState = state is EditTaskLoaded ? state.task : (state as EditTaskSuccess).task;
          final cubit = context.read<EditTaskCubit>();
          final isCompleted = taskState.isDone;
          final statusText = isCompleted ? 'Done' : 'In Progress';
          final statusColor = isCompleted ? Colors.green : Colors.orange;
          final statusMsg = isCompleted ? 'Congrats!' : "Believe you can, and you're halfway there.";

          return Scaffold(
            backgroundColor: const Color(0xFFF5F7F6),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text("Edit Task", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ElevatedButton.icon(
                    onPressed: cubit.deleteTask,
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
                            image: AssetImage('assets/images/flag.png'),
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
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              statusMsg,
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
                        value: taskState.type ?? 'Home',
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
                        onChanged: (value) => cubit.updateType(value!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(text: taskState.title),
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
                    onChanged: cubit.updateTitle,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(text: taskState.description),
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
                    onChanged: cubit.updateDescription,
                  ),
                  const SizedBox(height: 16),
                  Container(
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
                          '30 June, 2022', // Replace with actual date
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                        const Spacer(),
                        Text(
                          '10:00 pm', // Replace with actual time
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (!isCompleted)
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: cubit.markDone,
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
                      onPressed: cubit.saveTask,
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
        },
      ),
    );
  }
}
