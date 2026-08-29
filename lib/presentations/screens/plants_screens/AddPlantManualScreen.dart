import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';

class AddPlantManualScreen extends StatefulWidget {
  const AddPlantManualScreen({super.key});

  @override
  State<AddPlantManualScreen> createState() => _AddPlantManualScreenState();
}

class _AddPlantManualScreenState extends State<AddPlantManualScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _speciesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.transparent,
          title: AppTheme.plantCareAILogo(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppTheme.backButton(context),
        ),
        body: BlocConsumer<PlantCubit, PlantState>(
          listener: (context, state) {
            if (state is PlantError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then(
                                (value) => context
                                    .read<PlantCubit>()
                                    .uploadPlantImage(value!),
                              );
                        },
                        child: context.read<PlantCubit>().plantImage == null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  "assets/images/plant.png",
                                ),
                              )
                            : CircleAvatar(
                                radius: 50.r,
                                backgroundImage: FileImage(
                                  File(
                                    context.read<PlantCubit>().plantImage!.path,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Plant Name",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AuthTextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,

                      hintText: "Enter plant name",
                      prefix: ContainerIcons(icon: "assets/images/leafs.png"),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Species",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AuthTextField(
                      controller: _speciesController,
                      keyboardType: TextInputType.text,
                      hintText: "Enter plant Species",
                      prefix: ContainerIcons(icon: "assets/images/species.png"),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    AuthTextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,

                      hintText: "Enter plant description",
                      prefix: ContainerIcons(
                        icon: "assets/images/document.png",
                      ),
                    ),
                    SizedBox(height: 16.h),
                    MainButton(
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () async {
                        context.read<PlantCubit>().addPlant(
                          _nameController.text,
                          _speciesController.text,
                          context.read<PlantCubit>().plantImage,
                          _descriptionController.text,

                          null,
                          0,
                          null,
                          null,
                          null,
                          null,
                          0,
                          null,
                        );

                        _nameController.clear();
                        _descriptionController.clear();
                        _speciesController.clear();
                        context.read<PlantCubit>().plantImage = null;
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                      content: "Add Plant",
                      buttonStyle: AppButtonTheme.theme.style,
                      textStyle: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _speciesController.dispose();
    super.dispose();
  }
}
