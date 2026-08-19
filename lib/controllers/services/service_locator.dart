import 'package:get_it/get_it.dart';
import 'package:plant_care/controllers/cubit/user_cubit/user_cubit.dart';

import '../cache/cache_helper.dart';

final getIt=GetIt.instance;

void setupServiceLocator(){
  getIt.registerSingleton<CacheHelper>(CacheHelper());

}
