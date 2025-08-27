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

class ViewTasksPage extends StatefulWidget {
  final List<TaskModel> tasks;

  const ViewTasksPage({super.key, required this.tasks});

  @override
  State<ViewTasksPage> createState() => _ViewTasksPageState();
}

class _ViewTasksPageState extends State<ViewTasksPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewTasksCubit(initialTasks: widget.tasks),
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
            body: Column(
              children: [
                SearchBarWidget(
                  controller: _searchController,
                  onChanged: cubit.searchTasks,
                ),
                ResultsHeader(count: state.filteredTasks.length),
                const SizedBox(height: 16),
                Expanded(
                  child: TaskListView(
                    tasks: state.filteredTasks,
                    getStatusColor: getStatusColor,
                    onTapTask: (task) async {
                      final updatedTask = await Navigator.push<TaskModel?>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditTaskPage(task: task),
                        ),
                      );
                      if (updatedTask != null) {
                        cubit.updateTask(updatedTask);
                      }
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FilterButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => BlocProvider.value(
                    value:
                        context.read<ViewTasksCubit>(), // reuse existing cubit
                    child: const FilterDialog(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
