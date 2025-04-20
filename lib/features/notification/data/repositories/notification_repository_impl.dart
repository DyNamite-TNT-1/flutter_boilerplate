import 'package:test_three/features/notification/data/datasources/email_service.dart';
import 'package:test_three/features/notification/data/datasources/sms_service.dart';
import 'package:test_three/features/notification/data/models/notify_request_model.dart';
import 'package:test_three/features/notification/domain/entities/notify_request_entity.dart';
import 'package:test_three/features/notification/domain/entities/notify_response_entity.dart';
import 'package:test_three/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final EmailService emailService;
  final SmsService smsService;

  NotificationRepositoryImpl({
    required this.emailService,
    required this.smsService,
  });

  @override
  Future<NotifyResponseEntity> sendNotificationByEmail(
    NotifyRequestEntity request,
  ) async {
    final reqModel = NotifyRequestModel.fromEntity(request);
    final response = await emailService.notify(reqModel);
    return response;
  }

  @override
  Future<NotifyResponseEntity> sendNotificationBySms(
    NotifyRequestEntity request,
  ) async {
    final reqModel = NotifyRequestModel.fromEntity(request);
    final response = await smsService.notify(reqModel);
    return response;
  }
}
