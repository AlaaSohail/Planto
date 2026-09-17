import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/cubit/user_cubit/user_cubit.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/NavBarScreen.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:simple_icons/simple_icons.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/LoginSocialMedia.dart';
import '../../widgets/MainButton.dart';
import 'CheckEmailResetPassword.dart';
import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final localization = AppLocalizations.of(context)!;

    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (_) => const NavBarScreen(),
              ),
                  (route) => false,
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              title: AppTheme.plantCareAILogo(context),
              leadingWidth: 16.w,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(16.0).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),

                            Text(
                              localization.loginWelcomeBack,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(height: 4.h),

                            Text(
                              localization.loginSubtitle,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 20.h),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    localization.loginEmailAddress,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  AuthTextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.loginEnterEmail;
                                      }

                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return localization.loginValidEmail;
                                      }

                                      return null;
                                    },

                                    prefix: ContainerIcons(
                                      icon: "assets/images/at.png",
                                    ),
                                    obscureText: false,
                                    hintText: localization.loginEnterEmail,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    localization.loginPassword,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: 4.h),
                                  AuthTextField(
                                    controller: passwordController,
                                    hintText: localization.loginEnterPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: isObscure,
                                    prefix: ContainerIcons(
                                      icon: "assets/images/lock.png",
                                    ),

                                    suffix: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashFactory: NoSplash.splashFactory,

                                      onTap: () {
                                        setState(() {
                                          isObscure = !isObscure;
                                        });
                                      },

                                      child: ContainerIcons(
                                        icon: isObscure
                                            ? "assets/images/show.png"
                                            : "assets/images/close-eye.png",
                                      ),
                                    ),

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization
                                            .loginPleaseEnterPassword;
                                      }

                                      if (value.length < 8) {
                                        return localization
                                            .loginPasswordMinLength;
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        if (emailController.text.isEmpty ||
                                            emailController.text.length < 6 ||
                                            !RegExp(
                                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                            ).hasMatch(emailController.text)) {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) =>
                                                  CheckEmailResetPassword(),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (_) =>
                                                  CheckEmailResetPassword(
                                                    email: emailController.text,
                                                  ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        localization.loginForgotPassword,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  BlocBuilder<UserCubit, UserState>(
                                    builder: (context, state) {
                                      final isLoading = state is LoginLoading;

                                      return MainButton(
                                        content: isLoading
                                            ? localization.loginSigningIn
                                            : localization.loginSignIn,

                                        icon: isLoading
                                            ? SpinKitDualRing(
                                                color: Theme.of(
                                                  context,
                                                ).primaryColor,
                                                size: 20.sp,
                                              )
                                            : Icon(
                                                Icons.arrow_forward,
                                                color: AppColors.textPrimary,
                                                size: 20.sp,
                                              ),

                                        onPressed: () async {
                                          if (isLoading) return;

                                          if (_formKey.currentState!
                                              .validate()) {
                                            await userCubit.Login(
                                              emailController.text.trim(),
                                              passwordController.text,
                                            );
                                          }
                                        },

                                        mainAxisSize: MainAxisSize.max,

                                        textStyle: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall,

                                        buttonStyle: AppButtonTheme.theme.style!
                                            .copyWith(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 0.3.h,
                                    color: Colors.grey,
                                    margin: EdgeInsets.only(right: 16).r,
                                  ),
                                ),
                                Text(
                                  localization.loginOrContinueWith,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 0.3.h,
                                    color: Colors.grey,
                                    margin: EdgeInsets.only(left: 16).r,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                LoginSocialMedia(
                                  onTap: () async {
                                    await context
                                        .read<UserCubit>()
                                        .googleLogin();
                                  },
                                  imageName: 'assets/images/google.png',
                                ),

                                LoginSocialMedia(
                                  onTap: () async {
                                    await context
                                        .read<UserCubit>()
                                        .facebookLogin();
                                  },
                                  imageName: 'assets/images/facebook.png',
                                ),
                                LoginSocialMedia(
                                  onTap: () async {
                                    await context
                                        .read<UserCubit>()
                                        .facebookLogin();
                                  },
                                  imageName: 'assets/images/apple.png',
                                ),
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(localization.loginNoAccount),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    localization.loginSignUpFree,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
