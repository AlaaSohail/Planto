import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/cubit/plant_cubit/plant_cubit.dart';
import 'package:plant_care/presentations/screens/plants_screens/AddPlantManualScreen.dart';
import 'package:plant_care/presentations/widgets/PlantCard.dart';
import 'package:plant_care/presentations/widgets/QuickActionsCard.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/SearchTextField.dart';
import 'PlantDetailsScreen.dart';

class GetPlantScreen extends StatefulWidget {
  const GetPlantScreen({super.key, required this.onBackToHome});

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff7fbf5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 55.w,
          leading: AppTheme.backButton(context, onPressed: widget.onBackToHome),
          titleSpacing: 10.w,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Your Collection\n",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: "My Plants",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,

                child: ContainerIcons(icon: 'assets/images/plus.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => AddPlantManualScreen()),
                  );
                },
              ),
            ),
          ],
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
            if (state is PlantLoading) {
              return Center(
                child: SpinKitSpinningLines(
                  color: Theme.of(context).primaryColor,
                  size: 30.sp,
                ),
              );
            } else if (state is GetALLPlantSuccess) {
              final plants = state.plants;
              if (plants.isEmpty) {
                return SizedBox(
                  height: 190.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Plants Found"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => AddPlantManualScreen(),
                            ),
                          );
                        },
                        child: Text("Add Plant"),
                      ),
                    ],
                  ),
                );
              }
              final actions = [
                (title: 'Total', count: plants.length.toString()),
                (title: 'Healthy', count: '...'),
                (title: 'Diseased', count: '...'),
                (title: 'Recent', count: '...'),
              ];
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SearchTextField(
                        hintText: "Search plants ...",
                        prefix: Icon(Icons.search_rounded, color: Colors.grey),
                        controller: _searchController,
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: actions.length,
                          itemBuilder: (context, index) {
                            final action = actions[index];
                            return QuickActionsCard(
                              title: action.title,
                              count: action.count,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 1,
                        child: GridView.builder(
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
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,

                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        PlantDetailsScreen(plant: plant),
                                  ),
                                );
                              },
                              child: PlantCard(
                                name: plant.name!,
                                species: plant.species!,
                                description: "",
                                imageUrl: plant.imageUrl ?? '',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
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
