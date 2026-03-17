import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiConsumer apiConsumer;

  HomeRepositoryImpl({required this.apiConsumer});

}
