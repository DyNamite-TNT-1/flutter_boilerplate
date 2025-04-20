import 'package:get_it/get_it.dart';
import 'package:test_three/features/notification/data/datasources/email_service.dart';
import 'package:test_three/features/notification/data/datasources/sms_service.dart';
import 'package:test_three/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:test_three/features/notification/domain/repositories/notification_repository.dart';
import 'package:test_three/features/notification/domain/usecases/notify_by_email_usecase.dart';
import 'package:test_three/features/notification/domain/usecases/notify_by_sms_usecase.dart';

void initNotificationDependencies() {
  final getIt = GetIt.instance;
  // ---------------------------------------------------------------------------
  // DATA Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<EmailService>(() => EmailServiceImpl());
  getIt.registerLazySingleton<SmsService>(() => SmsServiceImpl());
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      emailService: getIt<EmailService>(),
      smsService: getIt<SmsService>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // DOMAIN Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton(
    () => NotifyByEmailUsecase(getIt<NotificationRepository>()),
  );
  getIt.registerLazySingleton(
    () => NotifyBySmsUsecase(getIt<NotificationRepository>()),
  );
}
