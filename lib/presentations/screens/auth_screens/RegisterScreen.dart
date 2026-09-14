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
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/LoginSocialMedia.dart';
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
    final localization = AppLocalizations.of(context)!;

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
            appBar: AppBar(
              title: AppTheme.plantCareAILogo(context),
              titleSpacing: 0,

              leading: AppTheme.backButton(context),
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
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Text(
                              localization.registerJoinPlanto,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              localization.registerSubtitle,
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
                                    localization.registerFullName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  AuthTextField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.registerEnterName;
                                      }
                                      return null;
                                    },
                                    prefix: ContainerIcons(
                                      icon: "assets/images/user.png",
                                    ),
                                    obscureText: false,
                                    hintText: localization.registerEnterName,
                                  ),

                                  Text(
                                    localization.registerEmailAddress,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  AuthTextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,

                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return localization.registerEnterEmail;
                                      }

                                      if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                      ).hasMatch(value)) {
                                        return localization.registerValidEmail;
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
                                    localization.registerPassword,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),

                                  AuthTextField(
                                    controller: passwordController,
                                    hintText:
                                        localization.registerMinCharacters,
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
                                            .registerPleaseEnterPassword;
                                      }

                                      if (value.length < 8) {
                                        return localization
                                            .registerPasswordMinLength;
                                      }
                                      return null;
                                    },
                                  ),
                                  Text(
                                    localization.registerConfirmPassword,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),

                                  AuthTextField(
                                    controller: confirmPasswordController,
                                    hintText: localization
                                        .registerConfirmPasswordHint,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: isObscure2,
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
                                        return localization
                                            .registerPleaseEnterPassword;
                                      }

                                      if (value.length < 8) {
                                        return localization
                                            .registerPasswordMinLength;
                                      }

                                      if (value != passwordController.text) {
                                        return localization
                                            .registerPasswordsNotMatch;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 4.h),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 8,
                                          top: 2,
                                        ).r,
                                        child: MSHCheckbox(
                                          size: 20.sp,
                                          value: isChecked,
                                          colorConfig:
                                              MSHColorConfig.fromCheckedUncheckedDisabled(
                                                uncheckedColor: Colors.grey,
                                                checkedColor:
                                                    AppColors.textPrimary,
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
                                              TextSpan(
                                                text: localization
                                                    .registerTermsText,
                                              ),
                                              TextSpan(
                                                text: localization
                                                    .registerTermsOfService,

                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color:
                                                          AppColors.secondary,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (_) =>
                                                                SettingScreen(),
                                                          ),
                                                        );
                                                      },
                                              ),
                                              TextSpan(
                                                text:
                                                    ' ${localization.registerAnd} ',
                                              ),
                                              TextSpan(
                                                text: localization
                                                    .registerPrivacyPolicy,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color:
                                                          AppColors.secondary,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),

                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder: (_) =>
                                                                SettingScreen(),
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
                                      final isLoading =
                                          state is RegisterLoading;

                                      return MainButton(
                                        content: isLoading
                                            ? localization.registerSigningUp
                                            : localization.registerSignUp,

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
                                                  .validate() &&
                                              isChecked == true) {
                                            final position =
                                                await LocationService.getCurrentLocation();

                                            await userCubit.Register(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text,
                                              name: nameController.text,
                                              phone: phoneNumberController.text,
                                              image:
                                                  'https://res.cloudinary.com/n4qtd6co/image/upload/v1788421140/farmer_hw0ugv.png',

                                              latitude: position?.latitude,
                                              longitude: position?.longitude,
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
                                  localization.registerOrContinueWith,
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
                            SizedBox(height: 8.h),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(localization.registerAlreadyHaveAccount),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    localization.registerSignIn,
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
