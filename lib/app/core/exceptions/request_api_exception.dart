import 'package:tractian_challenge/app/core/exceptions/app_exceptions.dart';

extension ValidateRequestApiExtension on String {
  RequestApiException asRequestException([StackTrace? stackTrace]) {
    return RequestApiException(this, stackTrace);
  }
}

class RequestApiException extends AppException {
  RequestApiException(super.message, [super.stackTrace]);
}
