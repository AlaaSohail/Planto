import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:plant_care/controllers/cubit/plant_cubit/plant_cubit.dart';
import 'package:plant_care/presentations/screens/plants_screens/AddPlantManualScreen.dart';
import 'package:plant_care/presentations/widgets/PlantCard.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/PlantStatistics.dart';
import '../../widgets/SearchTextField.dart';
import 'PlantDetailsScreen.dart';

class GetPlantScreen extends StatefulWidget {
  const GetPlantScreen({
    super.key,
    required this.onBackToHome,
  });

  final VoidCallback onBackToHome;

  @override
  State<GetPlantScreen> createState() => _GetPlantScreenState();
}

class _GetPlantScreenState extends State<GetPlantScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PlantCubit>().getPlant();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 55.w,
          leading: AppTheme.backButton(
            context,
            onPressed: () {
              _searchController.clear();

              context.read<PlantCubit>().clearSearch();

              widget.onBackToHome();
            },
          ),
          titleSpacing: 10.w,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${localization.yourCollection}\n",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: localization.myPlants,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 16.w),
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: ContainerIcons(
                  icon: 'assets/images/plus.png',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) =>
                      const AddPlantManualScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),

                  SearchTextField(
                    hintText: localization.searchPlants,
                    prefix: const Icon(
                      Icons.search_rounded,
                      color: Colors.grey,
                    ),
                    controller: _searchController,
                    onChange: (value) {
                      context
                          .read<PlantCubit>()
                          .searchPlants(value ?? '');
                    },
                  ),

                  SizedBox(height: 8.h),

                  BlocConsumer<PlantCubit, PlantState>(
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
                      if (state is PlantLoading) {
                        return Center(
                          child: SpinKitSpinningLines(
                            color: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .color!,
                            size: 30.sp,
                          ),
                        );
                      }

                      if (state is GetALLPlantSuccess) {
                        final plants = state.plants;

                        if (plants.isEmpty) {
                          final isSearching =
                              _searchController.text.trim().isNotEmpty;

                          return SizedBox(
                            height: 190.h,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  isSearching
                                      ? localization.noPlantsMatchSearch
                                      : localization.noPlantsFound,
                                  textAlign: TextAlign.center,
                                ),

                                if (!isSearching)
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) =>
                                          const AddPlantManualScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      localization.addPlant,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }

                        final healthyCount = plants
                            .where(
                              (plant) =>
                          plant.healthStatus == 'Healthy',
                        )
                            .length;

                        final diseasedCount = plants
                            .where(
                              (plant) =>
                          plant.disease != 'None detected',
                        )
                            .length;

                        final notAnalyzedCount = plants
                            .where(
                              (plant) =>
                          plant.confidence == 0 ||
                              plant.confidence == null ||
                              plant.healthStatus == null,
                        )
                            .length;

                        final actions = [
                          (
                          title: localization.total,
                          count: plants.length.toString(),
                          icon: 'assets/images/3d_leaf.png',
                          ),
                          (
                          title: localization.healthy,
                          count: healthyCount.toString(),
                          icon: 'assets/images/healthy_plant.png',
                          ),
                          (
                          title: localization.notAnalyzed,
                          count: notAnalyzedCount.toString(),
                          icon: 'assets/images/analyze_plant.png',
                          ),
                          (
                          title: localization.diseased,
                          count: diseasedCount.toString(),
                          icon: 'assets/images/virus.png',
                          ),
                        ];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 120.h,
                              child: Card(
                                elevation: 2,
                                color: const Color(0xffA7E39A)
                                    .withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Row(
                                    children: actions.map((action) {
                                      return Expanded(
                                        child: PlantStatistics(
                                          title: action.title,
                                          count: action.count,
                                          icon: action.icon,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 8.h),

                            SizedBox(
                              height:
                              MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: plants.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) {
                                  final plant = plants[index];

                                  return InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              PlantDetailsScreen(
                                                plant: plant,
                                              ),
                                        ),
                                      );
                                    },
                                    child: PlantCard(
                                      name: plant.name!,
                                      species: plant.species!,
                                      description: "",
                                      imageUrl: plant.imageUrl ?? '',
                                      percent: plant.healthScore,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}