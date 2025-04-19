import 'package:test_three/features/payment/domain/entities/payment_request_entity.dart';

class PaymentRequestModel extends PaymentRequestEntity {
  const PaymentRequestModel({super.amount});

  factory PaymentRequestModel.fromEntity(PaymentRequestEntity entity) {
    return PaymentRequestModel(
      amount:  entity.amount,
    );
  }
}
