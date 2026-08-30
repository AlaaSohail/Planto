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

import '../../../controllers/cubit/ai_cubit/ai_cubit.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/ModalBottomSheet.dart';
import '../plants_screens/ScannerNewPlant.dart';

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
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        title: AppTheme.plantCareAILogo(),
        leadingWidth: 32.w,
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
                    color: Theme.of(context).primaryColor,
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

                                      Navigator.pop(context);
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

                                      Navigator.pop(context);
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
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
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
                            'FULL NAME',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 8.h),

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
                          SizedBox(height: 12.h),

                          Text(
                            'EMAIL ADDRESS',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 8.h),
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
                          SizedBox(height: 12.h),

                          Text(
                            'PHONE NUMBER',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          AuthTextField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.phone,

                            prefix: ContainerIcons(
                              icon: "assets/images/calling.png",
                            ),
                            obscureText: false,
                            hintText: "phone number",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    MainButton(
                      mainAxisSize: MainAxisSize.max,
                      content: "Save Changes",
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
}
