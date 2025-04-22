import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/core/utils/validator.dart';

void main() {
  group("isValidEmail", () {
    test('should return true when the email is valid', () {
      // Arrange
      String validEmail = "user@gmail.com";

      // Act
      bool result = Validator.isValidEmail(validEmail);

      // Assert
      expect(result, true);
    });

    test('should return false when the email is empty', () {
      // Arrange
      String invalidEmail = '';

      // Act
      bool result = Validator.isValidEmail(invalidEmail);

      // Assert
      expect(result, false);
    });

    test('should return false when the email is not valid', () {
      // Arrange
      String invalidEmail = 'user@@gmail.com';

      // Act
      bool result = Validator.isValidEmail(invalidEmail);

      // Assert
      expect(result, false);
    });
  });

  group("isValidPassword", () {
    test(
      "should return true when the password length is greater than or equal to 6",
      () {
        // Arrange
        String invalidPassword = '1abc456';

        // Act
        bool result = Validator.isValidPassword(invalidPassword);

        // Assert
        expect(result, true);
      },
    );

    test(
      "should return false when the password length is less than 6",
      () {
        // Arrange
        String invalidPassword = '56';

        // Act
        bool result = Validator.isValidPassword(invalidPassword);

        // Assert
        expect(result, false);
      },
    );
  });
}
