import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import 'LoginScreen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key, this.resetToken});

  final String? resetToken;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isObscure = true;
  bool isObscure2 = true;
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }

        if (state is ResetPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: AppTheme.plantCareAILogo(),
            leading: AppTheme.backButton(context),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Update Password",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'PASSWORD',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        AuthTextField(
                          controller: passwordController,
                          hintText: "Min 8 characters",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isObscure,
                          prefix: ContainerIcons(
                            icon: "assets/images/lock.png",
                          ),

                          suffix: InkWell(
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
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              if (value!.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Text(
                          'CONFIRM PASSWORD',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        AuthTextField(
                          controller: confirmPasswordController,
                          hintText: "confirm password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isObscure2,
                          prefix: ContainerIcons(
                            icon: "assets/images/lock.png",
                          ),

                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                isObscure2 = !isObscure2;
                              });
                            },

                            child: ContainerIcons(
                              icon: isObscure2
                                  ? "assets/images/show.png"
                                  : "assets/images/close-eye.png",
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8 ||
                                value != passwordController.text) {
                              if (value!.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  MainButton(
                    content: "Update",
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      context.read<UserCubit>().resetPassword(
                        widget.resetToken!,
                        passwordController.text.trim(),
                      );
                    },
                    textStyle: Theme.of(context).textTheme.headlineSmall
                        ?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    buttonStyle: AppButtonTheme.theme.style!.copyWith(),
                    mainAxisSize: MainAxisSize.max,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
