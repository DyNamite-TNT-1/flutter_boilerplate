import 'package:test_three/features/payment/domain/entities/payment_request_entity.dart';
import 'package:test_three/features/payment/domain/entities/payment_response_entity.dart';

abstract class PaymentRepository {
  Future<PaymentResponseEntity> makePaymentWithPaypal(
    PaymentRequestEntity request,
  );
  Future<PaymentResponseEntity> makePaymentWithMomo(
    PaymentRequestEntity request,
  );
}
