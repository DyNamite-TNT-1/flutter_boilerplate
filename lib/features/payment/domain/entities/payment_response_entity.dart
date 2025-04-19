import 'package:equatable/equatable.dart';
import 'package:test_three/features/payment/data/models/payment_response_model.dart';

class PaymentResponseEntity with EquatableMixin {
  final bool isSuccess;
  final String message;
  final Map<String, dynamic> data;

  const PaymentResponseEntity({
    this.isSuccess = false,
    this.message = "",
    this.data = const {},
  });

  factory PaymentResponseEntity.fromModel(PaymentResponseModel model) {
    return PaymentResponseEntity(
      isSuccess: model.isSuccess,
      message: model.message,
      data: model.data,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isSuccess, message, data];
}
