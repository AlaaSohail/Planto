import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/SettingScreen.dart';
import 'package:simple_icons/simple_icons.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../controllers/services/location_service.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';
import '../../widgets/dropDownMenu.dart';
import '../nav_bar_screens/HomeScreen.dart';
import 'LoginScreen.dart';
import 'VerifyEmailScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationController = TextEditingController();

  final _countryController = TextEditingController();
  bool isObscure = true;
  bool isObscure2 = true;

  Country? selectedCountry;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    _countryController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _selectCountry() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
          _countryController.text = country.displayName;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();

    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (_) =>
                    VerifyEmailScreen(email: emailController.text.trim()),
              ),
            );
          } else if (state is RegisterError) {
            if (emailController.text.isEmpty ||
                passwordController.text.isEmpty ||
                confirmPasswordController.text.isEmpty ||
                nameController.text.isEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xfff7fbf5),

            appBar: AppBar(
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      "Join Planto 🌱",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 24.sp,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Create an account to start growing',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 20.h),

                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 8.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'FULL NAME',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AuthTextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            prefix: ContainerIcons(
                              icon: "assets/images/user.png",
                            ),
                            obscureText: false,
                            hintText: "enter your name",
                          ),

                          Text(
                            'EMAIL ADDRESS',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          AuthTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,

                            validator: (value) {
                              if (value!.isEmpty || value == null) {
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
                          SizedBox(height: 4),
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
                          SizedBox(height: 4.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8, top: 2).r,
                                child: MSHCheckbox(
                                  size: 20.sp,
                                  value: isChecked,
                                  colorConfig:
                                      MSHColorConfig.fromCheckedUncheckedDisabled(
                                        uncheckedColor: Colors.grey,
                                        checkedColor: AppColors.textPrimary,
                                      ),
                                  style: MSHCheckboxStyle.stroke,
                                  onChanged: (selected) {
                                    setState(() {
                                      isChecked = selected;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    children: [
                                      const TextSpan(
                                        text:
                                            "By creating an account, you agree to our ",
                                      ),
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (_) => SettingScreen(),
                                              ),
                                            );
                                          },
                                      ),
                                      const TextSpan(text: " and "),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (_) => SettingScreen(),
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          BlocBuilder<UserCubit, UserState>(
                            builder: (context, state) {
                              final isLoading = state is RegisterLoading;

                              return MainButton(
                                content: isLoading
                                    ? "Signing Up..."
                                    : "Sign Up",

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
                                  if (_formKey.currentState!.validate() &&
                                      isChecked == true) {
                                    final position =
                                        await LocationService.getCurrentLocation();

                                    await userCubit.Register(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                      name: nameController.text,
                                      phone: phoneNumberController.text,
                                      image: 'assets/images/farmer.png',

                                      latitude: position?.latitude,
                                      longitude: position?.longitude,
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
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 0.3.h,
                            color: Colors.grey,
                            margin: EdgeInsets.only(right: 16.r),
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
                            margin: EdgeInsets.only(left: 16.r),
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
                            userCubit.googleLogin();
                          },
                          icon: Icon(
                            SimpleIcons.google,
                            color: SimpleIconColors.gmail,
                            size: 42.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            userCubit.facebookLogin();
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
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Sign In",
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
