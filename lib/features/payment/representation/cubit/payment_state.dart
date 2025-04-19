part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final CommonStateObject payState;

  const PaymentState({this.payState = const CommonStateObject()});

  PaymentState copyWith({CommonStateObject? payState}) {
    return PaymentState(payState: payState ?? this.payState);
  }

  @override
  List<Object?> get props => [payState];
}
