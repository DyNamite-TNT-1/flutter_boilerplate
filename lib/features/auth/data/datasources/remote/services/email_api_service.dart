class FakeEmailApiService {
  final bool shouldSucceed;

  FakeEmailApiService({this.shouldSucceed = true});

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (shouldSucceed) {
      return {
        'success': true,
        'message': 'Successful sign in!',
        'user': {'id': 'user-id', 'email': email, 'name': 'User Jr'},
      };
    } else {
      return {'success': false, 'message': 'Invalid credentials', 'user': null};
    }
  }
}
