import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_assist/Pages/loginPage.dart';

void main() {

  test('Empy email returns error', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'Email can\'t be empty');
  });
  test('Non-empy email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('Empy password returns error', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password can\'t be empty');
  });
  test('Non-empy password returns null', () {
    var result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

}