part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<TaskModel> tasks;

  TaskSuccess(this.tasks);
}

final class TaskError extends TaskState {
  final String message;

  TaskError(this.message);
}

class CompleteTaskLoading extends TaskState {
  final int taskId;

  CompleteTaskLoading(this.taskId);
}

class CompleteTaskSuccess extends TaskState {}
