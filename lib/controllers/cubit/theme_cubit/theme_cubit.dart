import 'package:bloc/bloc.dart';

import '../../cache/cache_helper.dart';
import '../../services/service_locator.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
    const ThemeState(
      isDarkMode: false,
    ),
  );

  static const String themeKey = 'isDarkMode';

  void loadTheme() {
    final savedTheme = getIt<CacheHelper>().getData(
      key: themeKey,
    );

    if (savedTheme is bool) {
      emit(
        ThemeState(
          isDarkMode: savedTheme,
        ),
      );
    }
  }

  Future<void> changeTheme(bool isDark) async {
    await getIt<CacheHelper>().saveData(
      key: themeKey,
      value: isDark,
    );

    emit(
      ThemeState(
        isDarkMode: isDark,
      ),
    );
  }

  Future<void> toggleTheme() async {
    final newTheme = !state.isDarkMode;

    await getIt<CacheHelper>().saveData(
      key: themeKey,
      value: newTheme,
    );

    emit(
      ThemeState(
        isDarkMode: newTheme,
      ),
    );
  }
}