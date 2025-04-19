import 'package:test_three/features/payment/domain/entities/payment_request_entity.dart';
import 'package:test_three/features/payment/domain/entities/payment_response_entity.dart';
import 'package:test_three/features/payment/domain/repositories/payment_repository.dart';

class PaymentWithPaypalUsecase {
  final PaymentRepository repository;

  PaymentWithPaypalUsecase(this.repository);

  Future<PaymentResponseEntity> call(PaymentRequestEntity request) {
    return repository.makePaymentWithPaypal(request);
  }
}
