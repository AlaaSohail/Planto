import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/core/errors/exceptions.dart';
import 'package:plant_care/controllers/models/login_model.dart';
import 'package:plant_care/controllers/models/register_model.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';
import 'package:plant_care/controllers/services/service_locator.dart';

import '../../cache/cache_helper.dart';
import '../../core/functions/upload_image.dart';
import '../../models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());

  final ApiConsumer api;

  LoginModel? loginUser;
  RegisterModel? register;
  UserModel? user;

  XFile? userImage;

  uploadUserImage(XFile image) {
    userImage = image;
  }

  // =====================================================
  // LOGIN
  // =====================================================

  Future<void> Login(String email, String password) async {
    emit(LoginLoading());

    try {
      final response = await api.post(
        ApiEndpoints.login,
        data: {ApiKeys.email: email.trim(), ApiKeys.password: password},
      );

      loginUser = LoginModel.fromMap(response);

      // Decode JWT
      final decodedToken = JwtDecoder.decode(loginUser!.token);

      // Save token
      await getIt<CacheHelper>().saveData(
        key: ApiKeys.token,
        value: loginUser!.token,
      );

      // Save user ID
      await getIt<CacheHelper>().saveData(
        key: ApiKeys.id,
        value: decodedToken[ApiKeys.id],
      );

      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginError(e.errorModel.errorMessage));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  // =====================================================
  // RESET PASSWORD
  // =====================================================

  forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await api.post(
        ApiEndpoints.forgotPassword,
        data: {ApiKeys.email: email.trim()},
      );
      emit(ForgotPasswordSuccess(response["message"]));
    } on ServerException catch (e) {
      emit(ForgotPasswordError(e.errorModel.errorMessage));
    }
  }

  verifyCode(String email, String code) async {
    emit(VerifyCodeLoading());
    try {
      final response = await api.post(
        ApiEndpoints.verifyResetCode,
        data: {ApiKeys.email: email.trim(), ApiKeys.code: code},
      );
      emit(VerifyCodeSuccess(response["resetToken"]));
    } on ServerException catch (e) {
      emit(VerifyCodeError(e.errorModel.errorMessage));
    }
  }

  Future<void> resetPassword(String resetToken, String password) async {
    emit(ResetPasswordLoading());

    try {
      final response = await api.post(
        ApiEndpoints.resetPassword,
        data: {ApiKeys.resetToken: resetToken, ApiKeys.password: password},
      );

      emit(
        ResetPasswordSuccess(
          response['message']?.toString() ?? 'Password changed successfully',
        ),
      );
    } on ServerException catch (e) {
      emit(ResetPasswordError(e.errorModel.errorMessage.toString()));
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }

  // =====================================================
  // REGISTER
  // =====================================================

  Future<void> Register({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String phone,
    required String image,
    double? latitude,
    double? longitude,
    String? fcmToken,
  }) async {
    emit(RegisterLoading());

    try {
      final response = await api.post(
        ApiEndpoints.register,
        data: {
          ApiKeys.email: email.trim(),
          ApiKeys.password: password,
          ApiKeys.confirmPassword: confirmPassword,
          ApiKeys.name: name,
          ApiKeys.phone: phone.isEmpty ? null : phone,
          ApiKeys.image: image.isEmpty ? null : image,
          ApiKeys.latitude: latitude,
          ApiKeys.longitude: longitude,
        },
      );

      register = RegisterModel.fromMap(response);

      emit(RegisterSuccess(register!.message));
    } on ServerException catch (e) {
      emit(RegisterError(e.errorModel.errorMessage));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  // =====================================================
  // RESEND VERIFICATION EMAIL
  // =====================================================

  Future<void> resendVerificationEmail(String email) async {
    emit(ResendVerificationLoading());

    try {
      final response = await api.post(
        ApiEndpoints.resendVerification,
        data: {ApiKeys.email: email.trim()},
      );

      emit(
        ResendVerificationSuccess(
          response["message"] ?? "Verification email sent successfully",
        ),
      );
    } on ServerException catch (e) {
      emit(ResendVerificationError(e.errorModel.errorMessage));
    } catch (e) {
      emit(ResendVerificationError(e.toString()));
    }
  }

  // =====================================================
  // VERIFY EMAIL
  // =====================================================

  Future<void> verifyEmail(String token) async {
    emit(VerifyEmailLoading());

    try {
      final response = await api.get(
        "${ApiEndpoints.verifyEmail}?token=$token",
      );

      emit(
        VerifyEmailSuccess(
          response["message"] ?? "Email verified successfully",
        ),
      );
    } on ServerException catch (e) {
      emit(VerifyEmailError(e.errorModel.errorMessage));
    } catch (e) {
      emit(VerifyEmailError(e.toString()));
    }
  }

  // =====================================================
  // GET USER PROFILE
  // =====================================================

  Future<void> getUserProfile() async {
    emit(UserLoading());

    try {
      final response = await api.get(ApiEndpoints.profile);

      user = UserModel.fromJson(response["user"]);

      // Save latest user data locally
      await getIt<CacheHelper>().saveData(
        key: ApiKeys.cachedUser,
        value: jsonEncode(user!.toJson()),
      );

      emit(UserSuccess(user: user!));
    } on ServerException catch (e) {
      await _loadCachedUser(e.errorModel.errorMessage);
    } catch (e) {
      await _loadCachedUser(e.toString());
    }
  }

  Future<void> _loadCachedUser(String errorMessage) async {
    final cachedUser = getIt<CacheHelper>().getDataString(
      key: ApiKeys.cachedUser,
    );

    if (cachedUser != null && cachedUser.isNotEmpty) {
      try {
        final userData = jsonDecode(cachedUser);

        user = UserModel.fromJson(Map<String, dynamic>.from(userData));

        emit(UserSuccess(user: user!));
        return;
      } catch (_) {
        // Cache is invalid
      }
    }

    emit(UserError(errorMessage));
  }

  // =====================================================
  // UPDATE LOCATION
  // =====================================================

  Future<void> updateLocation({
    required double latitude,
    required double longitude,
  }) async {
    emit(UserLoading());

    try {
      final response = await api.put(
        ApiEndpoints.updateLocation,
        data: {ApiKeys.latitude: latitude, ApiKeys.longitude: longitude},
      );

      emit(UserLocationUpdated());
    } on ServerException catch (e) {
      emit(UserError(e.errorModel.errorMessage));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  logout() async {
    try {
      final response = await api.post(ApiEndpoints.logout);
      await getIt<CacheHelper>().removeData(key: ApiKeys.token);
      await getIt<CacheHelper>().removeData(key: ApiKeys.id);
      emit(UserLogoutSuccess(response["message"]));

      emit(UserLogout());
    } on ServerException catch (e) {
      emit(UserError(e.errorModel.errorMessage));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // =====================================================
  // FACEBOOK LOGIN
  // =====================================================

  Future<void> facebookLogin() async {
    emit(LoginLoading());

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status != LoginStatus.success) {
        emit(LoginError(result.message ?? 'Facebook login was cancelled'));

        return;
      }

      final accessToken = result.accessToken?.tokenString;

      if (accessToken == null || accessToken.isEmpty) {
        emit(LoginError('Facebook access token not found'));

        return;
      }

      final response = await api.post(
        ApiEndpoints.facebookLogin,
        data: {'token': accessToken},
      );

      loginUser = LoginModel.fromMap(response);

      final decodedToken = JwtDecoder.decode(loginUser!.token);

      await getIt<CacheHelper>().saveData(
        key: ApiKeys.token,
        value: loginUser!.token,
      );

      await getIt<CacheHelper>().saveData(
        key: ApiKeys.id,
        value: decodedToken[ApiKeys.id],
      );

      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginError(e.errorModel.errorMessage));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  // =====================================================
  // GOOGLE LOGIN
  // =====================================================

  // =====================================================
  // GOOGLE LOGIN
  // =====================================================

  Future<void> googleLogin() async {
    emit(LoginLoading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      final GoogleSignInAccount account = await googleSignIn.authenticate();

      final GoogleSignInAuthentication authentication = account.authentication;

      final String? idToken = authentication.idToken;

      if (idToken == null || idToken.isEmpty) {
        emit(LoginError('Google ID token not found'));
        return;
      }

      final response = await api.post(
        ApiEndpoints.googleLogin,
        data: {'token': idToken},
      );

      loginUser = LoginModel.fromMap(response);

      final decodedToken = JwtDecoder.decode(loginUser!.token);

      await getIt<CacheHelper>().saveData(
        key: ApiKeys.token,
        value: loginUser!.token,
      );

      await getIt<CacheHelper>().saveData(
        key: ApiKeys.id,
        value: decodedToken[ApiKeys.id],
      );

      emit(LoginSuccess());
    } on ServerException catch (e) {
      emit(LoginError(e.errorModel.errorMessage));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> updateProfileDetails(
    String name,
    String email,
    String phoneNumber, {
    XFile? userImage,
  }) async {
    emit(UpdateProfileDetailsLoading());

    try {
      final response = await api.put(
        ApiEndpoints.profile,
        data: {
          ApiKeys.name: name,
          ApiKeys.email: email,
          ApiKeys.phone: phoneNumber,

          if (userImage != null) 'image': await uploadImageToAPI(userImage),
        },
        isFormData: true,
      );

      emit(UpdateProfileDetailsSuccess(response["message"]));
      await getUserProfile();
    } on ServerException catch (e) {
      emit(UpdateProfileDetailsError(e.errorModel.errorMessage));
    } catch (e) {
      emit(UpdateProfileDetailsError(e.toString()));
    }
  }

  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(UserLoading());
    emit(UpdatePasswordLoading());
    try {
      final response = await api.put(
        ApiEndpoints.updatePassword,
        data: {
          ApiKeys.oldPassword: currentPassword,
          ApiKeys.newPassword: newPassword,
        },
      );
      emit(UpdatePasswordSuccess(response["message"]));
    } on ServerException catch (e) {
      emit(UpdatePasswordError(e.errorModel.errorMessage));
    } catch (e) {
      emit(UpdatePasswordError(e.toString()));
    }
  }
}
