import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/features/tasks/view/widgets/task_list_view.dart';
import '../../tasks/data/model/task_model.dart';
import '../cubit/view_tasks_cubit.dart';
import 'EditTaskPage.dart';
import 'widgets/SearchBar.dart';
import 'widgets/ResultsHeader.dart';
import 'widgets/FilterButton.dart';
import 'widgets/filter_dialog.dart';

class ViewTasksPage extends StatelessWidget {
  final List<TaskModel> tasks;
  const ViewTasksPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewTasksCubit(initialTasks: tasks),
      child: BlocBuilder<ViewTasksCubit, ViewTasksState>(
        builder: (context, state) {
          final cubit = context.read<ViewTasksCubit>();

          Color getStatusColor(TaskModel task) {
            final now = DateTime.now();
            final taskDate = task.taskDateTime;

            if (!task.isDone && taskDate.isBefore(now)) {
              return Colors.red; 
            } else {
              return Colors.green.withAlpha(100); 
            }
          }

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
            body: RefreshIndicator(
              onRefresh: () async {
                final userId =
                    state.tasks.isNotEmpty ? state.tasks.first.userId : '';
                if (userId.isNotEmpty) {
                  await cubit.loadTasks(userId);
                }
              },
              child: Column(
                children: [
                  SearchBarWidget(
                    controller: TextEditingController(
                      text: state.searchQuery, 
                    ),
                    onChanged: cubit.searchTasks,
                  ),
                  ResultsHeader(count: state.filteredTasks.length),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TaskListView(
                      tasks: state.filteredTasks,
                      getStatusColor: getStatusColor,
                      onTapTask: (task) async {
                        final result =
                            await Navigator.push<Map<String, dynamic>?>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditTaskPage(task: task),
                          ),
                        );

                        if (result != null) {
                          if (result['action'] == 'update') {
                            cubit.updateTask(result['task']);
                          } else if (result['action'] == 'delete') {
                            cubit.deleteTask(task.id);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FilterButton(
              onPressed: () async {
                final filterState = await showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const FilterDialog(),
                  ),
                );

                if (filterState != null) {
                  cubit.filterTasks(
                    category: filterState.selectedCategory,
                    status: filterState.selectedStatus,
                    date: filterState.pickedDate,
                    time: filterState.pickedTime,
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
