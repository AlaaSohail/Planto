import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:plant_care/controllers/cubit/user_cubit/user_cubit.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/ModalBottomSheet.dart';
import '../auth_screens/LoginScreen.dart';

class EditProfileDetailsScreen extends StatefulWidget {
  const EditProfileDetailsScreen({super.key});

  @override
  State<EditProfileDetailsScreen> createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

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
        titleSpacing: 0,
        foregroundColor: Colors.transparent,
        title: Text(
          localization.personalInfo,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AppTheme.backButton(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16.r),
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state is UpdateProfileDetailsSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is DeleteAccountLoading) {
                Center(
                  child: SpinKitSpinningLines(
                    color: Theme.of(context).textTheme.headlineSmall!.color!,
                    size: 30.sp,
                  ),
                );
              }
              if (state is DeleteAccountSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
              if (state is DeleteAccountError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state is UpdateProfileDetailsError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(
                  child: SpinKitSpinningLines(
                    color: Theme.of(context).textTheme.headlineSmall!.color!,
                    size: 30.sp,
                  ),
                );
              }

              if (state is UserSuccess) {
                final user = state.user;

                nameController.text = user.name;
                emailController.text = user.email;
                phoneNumberController.text = user.phoneNumber ?? '';

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ModalBottomSheet(
                              hintText: '',
                              actionText: '',
                              onPress: () {},
                              title: '',
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final value = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.camera,
                                          );

                                      if (value == null) return;
                                      if (!mounted) return;

                                      context.read<UserCubit>().uploadUserImage(
                                        value,
                                      );

                                      if (mounted) {
                                        setState(() {});
                                      }

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    icon: Image.asset(
                                      'assets/images/cameraa.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final value = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          );

                                      if (value == null) return;
                                      if (!mounted) return;

                                      context.read<UserCubit>().uploadUserImage(
                                        value,
                                      );

                                      if (mounted) {
                                        setState(() {});
                                      }

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    icon: Image.asset(
                                      'assets/images/picture.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: ClipOval(
                        child: context.read<UserCubit>().userImage != null
                            ? Image.file(
                                File(context.read<UserCubit>().userImage!.path),
                                width: 180.r,
                                height: 180.r,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    user.image ?? 'assets/images/farmer.png',
                                width: 180.r,
                                height: 180.r,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Container(
                                    color: AppColors.primary.withOpacity(0.1),
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall!.color!,
                                        size: 30.sp,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Container(
                                    color: AppColors.primary.withOpacity(0.1),
                                    child: Icon(
                                      Icons.person,
                                      size: 45.sp,
                                      color: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 4.h),

                          Text(
                            localization.fullName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          SizedBox(height: 8.h),

                          AuthTextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return localization.pleaseEnterYourName;
                              }

                              return null;
                            },
                            prefix: ContainerIcons(
                              icon: "assets/images/user.png",
                            ),
                            obscureText: false,
                            hintText: localization.enterYourName,
                          ),

                          SizedBox(height: 12.h),

                          Text(
                            localization.emailAddress,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          SizedBox(height: 8.h),

                          AuthTextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return localization.enterYourEmail;
                              }

                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value.trim())) {
                                return localization.enterValidEmail;
                              }

                              return null;
                            },
                            prefix: ContainerIcons(
                              icon: "assets/images/at.png",
                            ),
                            obscureText: false,
                            hintText: localization.emailExample,
                          ),

                          SizedBox(height: 12.h),

                          Text(
                            localization.phoneNumber,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          SizedBox(height: 8.h),

                          AuthTextField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,
                            prefix: ContainerIcons(
                              icon: "assets/images/calling.png",
                            ),
                            obscureText: false,
                            hintText: localization.enterPhoneNumber,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    MainButton(
                      mainAxisSize: MainAxisSize.max,
                      content: localization.saveChanges,
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      buttonStyle: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<UserCubit>().updateProfileDetails(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            phoneNumberController.text.trim(),
                            userImage: context.read<UserCubit>().userImage,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              titlePadding: EdgeInsets.fromLTRB(
                                24.w,
                                24.h,
                                24.w,
                                10.h,
                              ),
                              contentPadding: EdgeInsets.fromLTRB(
                                24.w,
                                0,
                                24.w,
                                20.h,
                              ),
                              actionsPadding: EdgeInsets.fromLTRB(
                                16.w,
                                0,
                                16.w,
                                16.h,
                              ),

                              title: Row(
                                children: [
                                  Container(
                                    width: 42.w,
                                    height: 42.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.delete_outline_rounded,
                                      color: AppColors.error,
                                      size: 23.sp,
                                    ),
                                  ),

                                  SizedBox(width: 12.w),

                                  Expanded(
                                    child: Text(
                                      localization.deleteAccount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),

                              content: Text(
                                localization.deleteAccountMessage,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      height: 1.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),

                              actions: [
                                // TextButton(
                                //   onPressed: () => Navigator.pop(context),
                                //   child: Text(
                                //     localization.cancel,
                                //     style: Theme.of(context).textTheme.bodyLarge
                                //         ?.copyWith(fontWeight: FontWeight.w600),
                                //   ),
                                // ),

                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.error,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 11.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    await context
                                        .read<UserCubit>()
                                        .deleteAccount();
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 18.sp,
                                  ),
                                  label: Text(
                                    localization.delete,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        localization.deleteAccount,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
