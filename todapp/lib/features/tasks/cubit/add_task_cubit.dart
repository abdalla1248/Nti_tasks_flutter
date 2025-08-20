import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';
import '../../../core/helpers/snackbar_helper.dart';
import 'add_task._state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedType = "Home";

  final List<Map<String, dynamic>> taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink},
    {"title": "Personal", "icon": Icons.person, "color": Colors.green},
    {"title": "Work", "icon": Icons.work, "color": Colors.black},
  ];

  static AddTaskCubit get(BuildContext context) =>
      BlocProvider.of<AddTaskCubit>(context);

  void pickDate(DateTime date) {
    selectedDate = date;
    emit(AddTaskInitial());
  }

  void pickTime(TimeOfDay time) {
    selectedTime = time;
    emit(AddTaskInitial());
  }

  void changeType(String type) {
    selectedType = type;
    emit(AddTaskInitial());
  }

Future<void> submitTask(BuildContext context) async {
  if (titleController.text.trim().isEmpty) {
    SnackbarHelper.show(context, 'Please enter a task title', backgroundColor: Colors.red);
    return;
  }
  if (selectedDate == null || selectedTime == null) {
    SnackbarHelper.show(context, 'Please select date and time', backgroundColor: Colors.red);
    return;
  }

  emit(AddTaskLoading());
  print("🚀 Submitting task...");

  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      SnackbarHelper.show(context, 'User not logged in', backgroundColor: Colors.red);
      emit(AddTaskFailure('User not logged in'));
      return;
    }

    final task = TaskModel(
      id: '',
      title: titleController.text.trim(),
      description: descController.text.trim(),
      isDone: false,
      userId: user.uid,
      createdAt: Timestamp.now(),
    );

    print("📌 Saving to Firestore...");
    await TaskRepo().addTask(task);
    print("✅ Firestore saved successfully");

    emit(AddTaskSuccess());
  } catch (e) {
    print("❌ Error: $e");
    emit(AddTaskFailure(e.toString()));
    SnackbarHelper.show(context, 'Failed to add task: $e', backgroundColor: Colors.red);
  }
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
