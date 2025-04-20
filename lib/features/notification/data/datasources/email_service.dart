import 'package:test_three/features/notification/data/models/notify_request_model.dart';
import 'package:test_three/features/notification/data/models/notify_response_model.dart';

abstract class EmailService {
  Future<NotifyResponseModel> notify(NotifyRequestModel request);
}

class EmailServiceImpl implements EmailService {
  @override
  Future<NotifyResponseModel> notify(NotifyRequestModel request) async {
    return NotifyResponseModel(isSuccess: true);
  }
}
