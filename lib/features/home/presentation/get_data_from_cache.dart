import 'package:lms_student/core/services/local/cache_helper.dart';

extension CacheExtension on String {
  String? get getDataFromCache => CacheHelper.getDataString(key: this);
}

String? getDataFromCache(String key) {
  return CacheHelper.getDataString(key: key);
}
