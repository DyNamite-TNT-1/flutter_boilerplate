import 'package:test_three/features/notification/domain/entities/notify_request_entity.dart';

class NotifyRequestModel extends NotifyRequestEntity {
  NotifyRequestModel({super.to, super.subject, super.message});

  factory NotifyRequestModel.fromEntity(NotifyRequestEntity entity) {
    return NotifyRequestModel(
      to: entity.to,
      subject: entity.subject,
      message: entity.message,
    );
  }
}
