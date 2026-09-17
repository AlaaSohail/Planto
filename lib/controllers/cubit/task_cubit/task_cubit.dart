import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

import '../../core/api/api_consumer.dart';
import '../../core/errors/exceptions.dart';
import '../../models/task_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.api) : super(TaskInitial());

  final ApiConsumer api;

  List<TaskModel> tasks = [];

  String getTodayDate() {
    final now = DateTime.now();

    final year = now.year.toString().padLeft(4, '0');
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Future<void> getTodayTasks() async {
    emit(TaskLoading());

    try {
      final date = getTodayDate();

      final response = await api.get(
        ApiEndpoints.todayTasks,
        queryParameters: {
          'date': date,
        },
      );

      final List data = response['tasks'] ?? [];

      tasks = data
          .map(
            (task) => TaskModel.fromJson(
          Map<String, dynamic>.from(task),
        ),
      )
          .toList();

      emit(TaskSuccess(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> completeTask(int taskId) async {
    try {
      emit(CompleteTaskLoading(taskId));

      final date = getTodayDate();

      await api.post(
        ApiEndpoints.completeTask(taskId.toString()),
        data: {
          'completed_date': date,
        },
      );

      await getTodayTasks();

      emit(CompleteTaskSuccess());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
