import 'package:test_three/features/notification/data/models/notify_request_model.dart';
import 'package:test_three/features/notification/data/models/notify_response_model.dart';

abstract class SmsService {
  Future<NotifyResponseModel> notify(NotifyRequestModel request);
}

class SmsServiceImpl implements SmsService {
  @override
  Future<NotifyResponseModel> notify(NotifyRequestModel request) async {
    return NotifyResponseModel(isSuccess: true);
  }
}
