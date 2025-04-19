import 'package:test_three/features/payment/data/models/payment_request_model.dart';
import 'package:test_three/features/payment/data/models/payment_response_model.dart';

abstract class PaypalGateway {
  Future<PaymentResponseModel> processPayment(PaymentRequestModel request);
}

class PaypalGatewayImpl implements PaypalGateway {
  @override
  Future<PaymentResponseModel> processPayment(
    PaymentRequestModel request,
  ) async {
    return PaymentResponseModel(
      isSuccess: false,
      message: "Payment was declined",
    );
  }
}
