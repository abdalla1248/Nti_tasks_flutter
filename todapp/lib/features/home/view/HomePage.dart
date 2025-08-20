import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_colors.dart';
import '../../tasks/view/Addtask.dart';
import '../cubit/home_cubit.dart';
import 'widgets/header_section.dart';
import 'widgets/progress_card.dart';
import 'widgets/in_progress_section.dart';
import 'widgets/task_groups_section.dart';
import 'widgets/empty_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.name, this.password});
  final String name;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFF5F7F6),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final result = await AppNavigator.push(
                    context, AddTaskScreen(tasks: cubit.tasks));
                if (result != null && result is Map<String, dynamic>) {
                  cubit.addTask(result);
                }
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.card),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderSection(name: name, password: password),
                    if (cubit.tasks.isNotEmpty) ...[
                      ProgressCard(
                        progressPercentage: cubit.progressPercentage,
                        tasks: cubit.tasks,
                      ),
                      InProgressSection(
                        inProgressTasks: cubit.inProgressTasks,
                        updateTaskCounts: () => cubit.emit(HomeUpdated()),
                      ),
                      TaskGroupsSection(taskTypes: cubit.taskTypes),
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
