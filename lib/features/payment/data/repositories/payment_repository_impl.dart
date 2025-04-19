import 'package:test_three/features/payment/data/datasources/momo_gateway.dart';
import 'package:test_three/features/payment/data/datasources/paypal_gateway.dart';
import 'package:test_three/features/payment/data/models/payment_request_model.dart';
import 'package:test_three/features/payment/domain/entities/payment_request_entity.dart';
import 'package:test_three/features/payment/domain/entities/payment_response_entity.dart';
import 'package:test_three/features/payment/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final MomoGateway momoGateway;
  final PaypalGateway paypalGateway;

  PaymentRepositoryImpl({
    required this.momoGateway,
    required this.paypalGateway,
  });

  @override
  Future<PaymentResponseEntity> makePaymentWithMomo(
    PaymentRequestEntity request,
  ) async {
    final requestModel = PaymentRequestModel.fromEntity(request);
    final response = await momoGateway.processPayment(requestModel);
    return response;
  }

  @override
  Future<PaymentResponseEntity> makePaymentWithPaypal(
    PaymentRequestEntity request,
  ) async {
   final requestModel = PaymentRequestModel.fromEntity(request);
    final response = await paypalGateway.processPayment(requestModel);
    return response;
  }
}
