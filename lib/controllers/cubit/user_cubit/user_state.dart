part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserModel user;

  UserSuccess({required this.user});
}

final class UserLocationUpdated extends UserState {}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}

final class LoginInitial extends UserState {}

final class LoginLoading extends UserState {}

final class LoginSuccess extends UserState {}

final class LoginError extends UserState {
  final String message;

  LoginError(this.message);
}

final class RegisterInitial extends UserState {}

final class RegisterLoading extends UserState {}

final class RegisterSuccess extends UserState {
  final String message;

  RegisterSuccess(this.message);
}

final class RegisterError extends UserState {
  final String message;

  RegisterError(this.message);
}

class ResendVerificationLoading extends UserState {}

class ResendVerificationSuccess extends UserState {
  final String message;

  ResendVerificationSuccess(this.message);
}

class ResendVerificationError extends UserState {
  final String message;

  ResendVerificationError(this.message);
}

class VerifyEmailLoading extends UserState {}

class VerifyEmailSuccess extends UserState {
  final String message;

  VerifyEmailSuccess(this.message);
}

class VerifyEmailError extends UserState {
  final String message;

  VerifyEmailError(this.message);
}

class ForgotPasswordLoading extends UserState {}

class ForgotPasswordSuccess extends UserState {
  final String message;

  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends UserState {
  final String message;

  ForgotPasswordError(this.message);
}

class VerifyCodeLoading extends UserState {}

class VerifyCodeSuccess extends UserState {
  final String resetToken;

  VerifyCodeSuccess(this.resetToken);
}

class VerifyCodeError extends UserState {
  final String message;

  VerifyCodeError(this.message);
}

class ResetPasswordLoading extends UserState {}

class ResetPasswordSuccess extends UserState {
  final String message;

  ResetPasswordSuccess(this.message);
}

class ResetPasswordError extends UserState {
  final String message;

  ResetPasswordError(this.message);
}

class UserLogout extends UserState {}

class UserLogoutError extends UserState {
  final String message;

  UserLogoutError(this.message);
}

class UserLogoutSuccess extends UserState {
  final String message;

  UserLogoutSuccess(this.message);
}

class UploadUserImage extends UserState {}

class UploadUserImageSuccess extends UserState {
  final String message;

  UploadUserImageSuccess(this.message);
}

class UploadUserImageError extends UserState {
  final String message;

  UploadUserImageError(this.message);
}

class UpdateProfileDetailsLoading extends UserState {}

class UpdateProfileDetailsSuccess extends UserState {
  final String message;

  UpdateProfileDetailsSuccess(this.message);
}

class UpdateProfileDetailsError extends UserState {
  final String message;

  UpdateProfileDetailsError(this.message);
}

class UpdatePasswordLoading extends UserState {}

class UpdatePasswordSuccess extends UserState {
  final String message;

  UpdatePasswordSuccess(this.message);
}

class UpdatePasswordError extends UserState {
  final String message;

  UpdatePasswordError(this.message);
}
