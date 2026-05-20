import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_student/core/di/service_locator.dart';
import 'package:lms_student/core/services/local/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  static const String _localeKey = 'app_locale';

  void _loadSavedLocale() {
    final dynamic savedLocale = sl<CacheHelper>().getData(key: _localeKey);
    if (savedLocale != null && savedLocale is String) {
      emit(Locale(savedLocale));
    }
  }

  void changeLocale(String languageCode) {
    sl<CacheHelper>().saveData(key: _localeKey, value: languageCode);
    emit(Locale(languageCode));
  }
}
