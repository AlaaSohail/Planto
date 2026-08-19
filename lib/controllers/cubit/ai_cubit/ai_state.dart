part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoading extends AiState {}

final class AiSuccess extends AiState {
  final String message;

  AiSuccess(this.message);
}

final class AiError extends AiState {
  final String message;

  AiError(this.message);
}
