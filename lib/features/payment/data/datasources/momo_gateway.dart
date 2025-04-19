import 'package:test_three/features/payment/data/models/payment_request_model.dart';
import 'package:test_three/features/payment/data/models/payment_response_model.dart';

abstract class MomoGateway {
  Future<PaymentResponseModel> processPayment(PaymentRequestModel request);
}

class MomoGatewayImpl implements MomoGateway {
  @override
  Future<PaymentResponseModel> processPayment(PaymentRequestModel request) async {
    return PaymentResponseModel(isSuccess: true, message: "Payment is successful");
  }
}
