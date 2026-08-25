part of 'ai_cubit.dart';

@immutable
sealed class AiState {}

final class AiInitial extends AiState {}

final class AiLoading extends AiState {}

final class AiChatSuccess extends AiState {
  final String message;

  AiChatSuccess(this.message);
}

final class AiChatError extends AiState {
  final String message;

  AiChatError(this.message);
}

final class AiAnalyzeSuccess extends AiState {
  final AiAnalysisModel aiAnalysisModel;

  AiAnalyzeSuccess(this.aiAnalysisModel);
}

final class AiAnalyzeError extends AiState {
  final String message;

  AiAnalyzeError(this.message);
}

final class UploadAnalyzeImageLoading extends AiState {}

final class UploadAnalyzeImageSuccess extends AiState {}

final class UploadAnalyzeImageError extends AiState {
  final String message;

  UploadAnalyzeImageError(this.message);
}
