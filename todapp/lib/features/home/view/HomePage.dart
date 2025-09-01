import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_colors.dart';
import 'package:todapp/features/profile/view/UserUpdate.dart';
import '../../tasks/view/Addtask.dart';
import '../../tasks/data/model/task_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/header_section.dart';
import 'widgets/progress_card.dart';
import 'widgets/in_progress_section.dart';
import 'widgets/task_groups_section.dart';
import 'widgets/empty_state.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..setUsername(username),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

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
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final result = await AppNavigator.push(
                  context,
                  AddTaskScreen(
                    tasks: cubit.tasks.map((t) => t.toJson()).toList(),
                  ),
                );
                // No manual add needed; snapshot listener updates automatically
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.card),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    HeaderSection(
                      name: state.username,
                      onEdit: () async {
                        final updatedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                UserUpdatePage(initialName: state.username),
                          ),
                        );
                        if (updatedName != null) {
                          cubit.setUsername(updatedName);
                        }
                      },
                    ),
                    if (cubit.tasks.isNotEmpty) ...[
                      ProgressCard(
                        progressPercentage: cubit.progressPercentage,
                        tasks: cubit.tasks,
                      ),
                      InProgressSection(
                        inProgressTasks: cubit.inProgressTasks,
                        markCompleted: (TaskModel task) async {
                          await cubit.markTaskCompleted(task);
                        },
                      ),
                      TaskGroupsSection(
                        taskTypes: cubit.taskTypes,
                        tasks: cubit.tasks,
                      ),
                      const SizedBox(height: 80),
                    ] else
                      const EmptyState(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
