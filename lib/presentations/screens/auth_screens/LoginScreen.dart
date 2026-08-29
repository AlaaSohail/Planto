import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/cubit/user_cubit/user_cubit.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/NavBarScreen.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:simple_icons/simple_icons.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';
import '../nav_bar_screens/HomeScreen.dart';
import '../nav_bar_screens/ProfileScreen.dart';
import 'CheckEmailResetPassword.dart';
import 'RegisterScreen.dart';
import 'VerifyCodeScreen.dart';

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
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (_) => const NavBarScreen()),
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xfff7fbf5),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              title: AppTheme.plantCareAILogo(),
              leadingWidth: 55.w,
              leading: AppTheme.backButton(context),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),

                    Text(
                      "Welcome back",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: 4.h),

                    Text(
                      'Sign in to continue growing',
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
                            'EMAIL ADDRESS',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 4.h),
                          AuthTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your email";
                              }

                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return "Enter valid email";
                              }

                              return null;
                            },

                            prefix: ContainerIcons(
                              icon: "assets/images/at.png",
                            ),
                            obscureText: false,
                            hintText: "example@alaasohail.com",
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'PASSWORD',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 4.h),
                          AuthTextField(
                            controller: passwordController,
                            hintText: "Enter your password",
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
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
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
                                      builder: (_) => CheckEmailResetPassword(),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => CheckEmailResetPassword(
                                        email: emailController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Forgot Password?",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          BlocBuilder<UserCubit, UserState>(
                            builder: (context, state) {
                              final isLoading = state is LoginLoading;

                              return MainButton(
                                content: isLoading
                                    ? "Signing in..."
                                    : "Sign In",

                                icon: isLoading
                                    ? SpinKitDualRing(
                                        color: Theme.of(context).primaryColor,
                                        size: 20.sp,
                                      )
                                    : Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.textPrimary,
                                        size: 20.sp,
                                      ),

                                onPressed: () async {
                                  if (isLoading) return;

                                  if (_formKey.currentState!.validate()) {
                                    await userCubit.Login(
                                      emailController.text.trim(),
                                      passwordController.text,
                                    );
                                  }
                                },

                                mainAxisSize: MainAxisSize.max,

                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),

                                buttonStyle: AppButtonTheme.theme.style!
                                    .copyWith(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
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
                          "Or continue with",
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

                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<UserCubit>().googleLogin();
                          },
                          icon: Icon(
                            SimpleIcons.google,
                            color: SimpleIconColors.gmail,
                            size: 42.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<UserCubit>().facebookLogin();
                          },
                          icon: Icon(
                            SimpleIcons.facebook,
                            color: SimpleIconColors.facebook,
                            size: 42.sp,
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            SimpleIcons.apple,
                            color: SimpleIconColors.apple,
                            size: 42.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Don't have an account?"),
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
                            "Sign Up Free",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
