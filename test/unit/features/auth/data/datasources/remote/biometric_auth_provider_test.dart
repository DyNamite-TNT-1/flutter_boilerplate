import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/biometric_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/services/biometric_api_service.dart';

void main() {
  group('BiometricAuthProviderImpl with FakeBiometricApiService', () {
    test('should return success when biometric API succeeds', () async {
      final fakeApi = FakeBiometricApiService(shouldSucceed: true);
      final provider = BiometricAuthProviderImpl(fakeApi);

      final result = await provider.signIn();

      expect(result.success, isTrue);
      expect(result.user?.email, 'user@gmail.com');
      expect(result.message, contains('Successful'));
    });

    test('should return failure when biometric API fails', () async {
      final fakeApi = FakeBiometricApiService(shouldSucceed: false);
      final provider = BiometricAuthProviderImpl(fakeApi);

      final result = await provider.signIn();

      expect(result.success, isFalse);
      expect(result.user, isNull);
      expect(result.message, equals('Biometric authentication failed'));
    });
  });
}
