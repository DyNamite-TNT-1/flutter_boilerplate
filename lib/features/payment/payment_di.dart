import 'package:get_it/get_it.dart';
import 'package:test_three/features/payment/data/datasources/momo_gateway.dart';
import 'package:test_three/features/payment/data/datasources/paypal_gateway.dart';
import 'package:test_three/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:test_three/features/payment/domain/repositories/payment_repository.dart';
import 'package:test_three/features/payment/domain/usecases/payment_with_momo_usecase.dart';
import 'package:test_three/features/payment/domain/usecases/payment_with_paypal_usecase.dart';

void initPaymentDependencies() {
  final getIt = GetIt.instance;
  // ---------------------------------------------------------------------------
  // DATA Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<MomoGateway>(() => MomoGatewayImpl());
  getIt.registerLazySingleton<PaypalGateway>(() => PaypalGatewayImpl());
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      momoGateway: getIt<MomoGateway>(),
      paypalGateway: getIt<PaypalGateway>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // DOMAIN Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton(
    () => PaymentWithMomoUsecase(getIt<PaymentRepository>()),
  );
  getIt.registerLazySingleton(
    () => PaymentWithPaypalUsecase(getIt<PaymentRepository>()),
  );
}
