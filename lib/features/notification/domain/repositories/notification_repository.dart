import 'package:test_three/features/notification/domain/entities/notify_request_entity.dart';
import 'package:test_three/features/notification/domain/entities/notify_response_entity.dart';

abstract class NotificationRepository {
  Future<NotifyResponseEntity> sendNotificationByEmail(NotifyRequestEntity request);
  Future<NotifyResponseEntity> sendNotificationBySms(NotifyRequestEntity request);
}
