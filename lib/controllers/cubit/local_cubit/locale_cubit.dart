import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cache/cache_helper.dart';
import '../../services/service_locator.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  static const String languageKey = 'languageCode';

  Future<void> loadLanguage() async {
    final savedLanguage =
    getIt<CacheHelper>().getData(
      key: languageKey,
    );

    if (savedLanguage != null) {
      emit(
        Locale(
          savedLanguage.toString(),
        ),
      );

      return;
    }

    final deviceLocale =
        WidgetsBinding.instance.platformDispatcher.locale;

    const supportedLanguages = [
      'en',
      'ar',
      'he',
    ];

    if (supportedLanguages.contains(
      deviceLocale.languageCode,
    )) {
      emit(
        Locale(
          deviceLocale.languageCode,
        ),
      );
    } else {
      emit(
        const Locale('en'),
      );
    }
  }

  Future<void> changeLanguage(
      String languageCode,
      ) async {
    await getIt<CacheHelper>().saveData(
      key: languageKey,
      value: languageCode,
    );

    emit(
      Locale(languageCode),
    );
  }
}