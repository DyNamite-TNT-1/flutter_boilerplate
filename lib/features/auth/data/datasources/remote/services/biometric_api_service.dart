class FakeBiometricApiService {
  final bool shouldSucceed;

  FakeBiometricApiService({this.shouldSucceed = true});

  Future<Map<String, dynamic>> signIn() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (shouldSucceed) {
      return {
        'success': true,
        'message': 'Successful sign in!',
        'user': {
          'id': 'user-id',
          'email': 'user@gmail.com',
          'name': 'User Jr',
        },
      };
    } else {
      return {
        'success': false,
        'message': 'Biometric authentication failed',
        'user': null,
      };
    }
  }
}
