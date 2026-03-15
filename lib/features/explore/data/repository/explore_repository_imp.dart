import 'package:lms_student/core/services/remote/api_consumer.dart';
import 'package:lms_student/features/explore/domain/repositories/explore_repository.dart';

class ExploreRepositoryImp implements ExploreRepository {
  final ApiConsumer apiConsumer;
  ExploreRepositoryImp({required this.apiConsumer});
  
}
