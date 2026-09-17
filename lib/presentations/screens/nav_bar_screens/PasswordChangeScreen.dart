import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;
  bool isObscure3 = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title:Text(localization.changePassword,style: Theme.of(context).textTheme.headlineSmall,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,

        leading: AppTheme.backButton(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),

                /// Current Password
                Text(
                  localization.currentPassword,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 8.h),

                AuthTextField(
                  controller: currentPasswordController,
                  hintText: localization.min8Characters,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure,
                  prefix: ContainerIcons(icon: "assets/images/lock.png"),
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
                      return localization.pleaseEnterYourPassword;
                    }

                    if (value.length < 8) {
                      return localization.passwordMustBeAtLeast8Characters;
                    }

                    return null;
                  },
                ),

                SizedBox(height: 12.h),

                /// New Password
                Text(
                  localization.newPassword,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 8.h),

                AuthTextField(
                  controller: passwordController,
                  hintText: localization.newPasswordHint,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure2,
                  prefix: ContainerIcons(icon: "assets/images/lock.png"),
                  suffix: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
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
                    if (value == null || value.isEmpty) {
                      return localization.pleaseEnterYourPassword;
                    }

                    if (value.length < 8) {
                      return localization.passwordMustBeAtLeast8Characters;
                    }

                    return null;
                  },
                ),

                SizedBox(height: 12.h),

                /// Confirm Password
                Text(
                  localization.confirmPassword,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 8.h),

                AuthTextField(
                  controller: confirmPasswordController,
                  hintText: localization.confirmPasswordHint,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure3,
                  prefix: ContainerIcons(icon: "assets/images/lock.png"),
                  suffix: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      setState(() {
                        isObscure3 = !isObscure3;
                      });
                    },
                    child: ContainerIcons(
                      icon: isObscure3
                          ? "assets/images/show.png"
                          : "assets/images/close-eye.png",
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.pleaseEnterYourPassword;
                    }

                    if (value.length < 8) {
                      return localization.passwordMustBeAtLeast8Characters;
                    }

                    if (value != passwordController.text) {
                      return localization.passwordsDoNotMatch;
                    }

                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UpdatePasswordSuccess) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));

                      currentPasswordController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();

                      Navigator.pop(context, true);

                      context.read<UserCubit>().getUserProfile();
                    }

                    if (state is UpdatePasswordError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdatePasswordLoading) {
                      return Center(
                        child: SpinKitSpinningLines(
                          color: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.color!,
                          size: 30.sp,
                        ),
                      );
                    }

                    return MainButton(
                      mainAxisSize: MainAxisSize.max,
                      content: localization.save,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      buttonStyle: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<UserCubit>().updatePassword(
                            currentPasswordController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}
