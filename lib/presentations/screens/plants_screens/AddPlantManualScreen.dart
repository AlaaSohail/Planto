import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/AuthTextField.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/MainButton.dart';

class AddPlantManualScreen extends StatefulWidget {
  const AddPlantManualScreen({super.key});

  @override
  State<AddPlantManualScreen> createState() =>
      _AddPlantManualScreenState();
}

class _AddPlantManualScreenState extends State<AddPlantManualScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _speciesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.transparent,
          title: AppTheme.plantCareAILogo(context),
          backgroundColor: Colors.transparent,
          elevation: 0,        titleSpacing: 0,

          leading: AppTheme.backButton(context),
        ),
        body: BlocConsumer<PlantCubit, PlantState>(
          listener: (context, state) {
            if (state is PlantError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image == null || !context.mounted) {
                            return;
                          }

                          await context
                              .read<PlantCubit>()
                              .uploadPlantImage(image);
                        },
                        child: context.read<PlantCubit>().plantImage == null
                            ? CircleAvatar(
                          backgroundColor:
                          AppColors.secondary.withOpacity(0.2),
                          radius: 50.r,
                          backgroundImage: const AssetImage(
                            "assets/images/plant.png",
                          ),
                        )
                            : CircleAvatar(
                          radius: 50.r,
                          backgroundImage: FileImage(
                            File(
                              context
                                  .read<PlantCubit>()
                                  .plantImage!
                                  .path,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      localization.plantName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    SizedBox(height: 8.h),

                    AuthTextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      hintText: localization.enterPlantName,
                      prefix: ContainerIcons(
                        icon: "assets/images/leafs.png",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localization.pleaseEnterPlantName;
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      localization.species,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    SizedBox(height: 8.h),

                    AuthTextField(
                      controller: _speciesController,
                      keyboardType: TextInputType.text,
                      hintText: localization.enterPlantSpecies,
                      prefix: ContainerIcons(
                        icon: "assets/images/species.png",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return localization.pleaseEnterPlantSpecies;
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      localization.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    SizedBox(height: 8.h),

                    AuthTextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      hintText: localization.enterPlantDescription,
                      prefix: ContainerIcons(
                        icon: "assets/images/document.png",
                      ),
                    ),

                    SizedBox(height: 16.h),

                    MainButton(
                      mainAxisSize: MainAxisSize.max,
                      onPressed: () async {
                        if (_nameController.text.trim().isEmpty ||
                            _descriptionController.text.trim().isEmpty ||
                            _speciesController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                localization.pleaseFillAllFields,
                              ),
                            ),
                          );

                          return;
                        }

                        await context.read<PlantCubit>().addPlant(
                          _nameController.text.trim(),
                          _speciesController.text.trim(),
                          context.read<PlantCubit>().plantImage,
                          _descriptionController.text.trim(),
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
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      content: localization.addPlant,
                      buttonStyle: AppButtonTheme.theme.style,
                      textStyle:
                      Theme.of(context).textTheme.headlineSmall,
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