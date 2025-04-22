import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/email_password_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/services/email_api_service.dart';

void main() {
  group('EmailPasswordAuthProviderImpl with FakeEmailApiService', () {
    test('shoulde return success when API succeeds', () async {
      final fakeApi = FakeEmailApiService(shouldSucceed: true);
      final provider = EmailPasswordAuthProviderImpl(fakeApi);

      final result = await provider.signIn('user@test.com', '123456');

      expect(result.success, isTrue);
      expect(result.user?.email, 'user@test.com');
      expect(result.message, contains('Successful'));
    });

    test('shoulde return failure when API fails', () async {
      final fakeApi = FakeEmailApiService(shouldSucceed: false);
      final provider = EmailPasswordAuthProviderImpl(fakeApi);

      final result = await provider.signIn('user@test.com', 'wrongpass');

      expect(result.success, isFalse);
      expect(result.user, isNull);
      expect(result.message, equals('Invalid credentials'));
    });
  });
}
