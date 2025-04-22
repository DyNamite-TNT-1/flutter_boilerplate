import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/google_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/services/google_api_service.dart';

void main() {
  group('GoogleAuthProviderImpl with FakeGoogleApiService', () {
    test('should return success when API succeeds', () async {
      final fakeApi = FakeGoogleApiService(shouldSucceed: true);
      final provider = GoogleAuthProviderImpl(fakeApi);

      final result = await provider.signIn();

      expect(result.success, isTrue);
      expect(result.user?.email, 'user@gmail.com');
      expect(result.message, contains('Successful'));
    });

    test('should return failure when API fails', () async {
      final fakeApi = FakeGoogleApiService(shouldSucceed: false);
      final provider = GoogleAuthProviderImpl(fakeApi);

      final result = await provider.signIn();

      expect(result.success, isFalse);
      expect(result.user, isNull);
      expect(result.message, equals('Google sign-in failed'));
    });
  });
}
