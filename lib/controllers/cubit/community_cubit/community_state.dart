part of 'community_cubit.dart';

@immutable
sealed class CommunityState {}

final class CommunityInitial extends CommunityState {}

final class CommunityLoading extends CommunityState {}

final class CommunitySuccess extends CommunityState {
  final List<PostModel> post;

  CommunitySuccess(this.post);
}

final class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);
}

final class UploadPostImageLoading extends CommunityState {}

final class UploadPostImageSuccess extends CommunityState {}

final class UploadPostImageError extends CommunityState {
  final String message;

  UploadPostImageError(this.message);
}

class CommunityLikeUpdated extends CommunityState {}

class CommunityCommentsLoading extends CommunityState {}

class CommunityCommentsSuccess extends CommunityState {}

class CommunityCommentsError extends CommunityState {
  final String message;

  CommunityCommentsError(this.message);
}
class CommunityCommentAdding extends CommunityState {}
