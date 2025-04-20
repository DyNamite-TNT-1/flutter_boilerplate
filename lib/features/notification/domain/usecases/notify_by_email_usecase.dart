import 'package:test_three/features/notification/domain/entities/notify_request_entity.dart';
import 'package:test_three/features/notification/domain/entities/notify_response_entity.dart';
import 'package:test_three/features/notification/domain/repositories/notification_repository.dart';

class NotifyByEmailUsecase {
  final NotificationRepository repository;
  NotifyByEmailUsecase(this.repository);

  Future<NotifyResponseEntity> call(NotifyRequestEntity request) async {
    return repository.sendNotificationByEmail(request);
  }
}
