import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';

extension ValidateExceptionExtension on String {
  ValidateException asException() {
    return ValidateException(this);
  }
}

class ValidateException extends AppException {
  ValidateException(super.message, [super.stackTrace]);
}
