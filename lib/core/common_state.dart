import 'package:equatable/equatable.dart';

enum CommonState { init, loading, refresh, failed, success }

class CommonStateObject extends Equatable {
  final CommonState state;
  final String message;

  const CommonStateObject({this.state = CommonState.init, this.message = ""});

  CommonStateObject copyWith({CommonState? state, String? message}) {
    return CommonStateObject(
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  const CommonStateObject.success({String? message})
    : state = CommonState.success,
      message = message ?? "";

  const CommonStateObject.failed({required String msg})
    : state = CommonState.failed,
      message = msg;

  const CommonStateObject.loading({CommonState? state})
    : state = state ?? CommonState.loading,
      message = "";

  @override
  List<Object?> get props => [state, message];
}
