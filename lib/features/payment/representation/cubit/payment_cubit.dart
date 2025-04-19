import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/core/common_state.dart';
import 'package:test_three/features/payment/domain/entities/payment_request_entity.dart';
import 'package:test_three/features/payment/domain/usecases/payment_with_momo_usecase.dart';
import 'package:test_three/features/payment/domain/usecases/payment_with_paypal_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentWithMomoUsecase _paymentWithMomoUsecase;
  final PaymentWithPaypalUsecase _paymentWithPaypalUsecase;

  PaymentCubit({
    required PaymentWithMomoUsecase paymentWithMomoUsecase,
    required PaymentWithPaypalUsecase paymentWithPaypalUsecase,
  }) : _paymentWithMomoUsecase = paymentWithMomoUsecase,
       _paymentWithPaypalUsecase = paymentWithPaypalUsecase,
       super(PaymentState());

  Future<void> payWithMomo(PaymentRequestEntity request) async {
    emit(state.copyWith(payState: CommonStateObject.loading()));
    try {
      final response = await _paymentWithMomoUsecase(request);
      if (response.isSuccess) {
        emit((state.copyWith(payState: CommonStateObject.success())));
      } else {
        emit(
          (state.copyWith(
            payState: CommonStateObject.failed(msg: response.message),
          )),
        );
      }
    } catch (e) {
      emit(
        (state.copyWith(payState: CommonStateObject.failed(msg: e.toString()))),
      );
    }
  }

  Future<void> payWithPaypal(PaymentRequestEntity request) async {
    emit(state.copyWith(payState: CommonStateObject.loading()));
    try {
      final response = await _paymentWithPaypalUsecase(request);
      if (response.isSuccess) {
        emit((state.copyWith(payState: CommonStateObject.success())));
      } else {
        emit(
          (state.copyWith(
            payState: CommonStateObject.failed(msg: response.message),
          )),
        );
      }
    } catch (e) {
      emit(
        (state.copyWith(payState: CommonStateObject.failed(msg: e.toString()))),
      );
    }
  }
}
