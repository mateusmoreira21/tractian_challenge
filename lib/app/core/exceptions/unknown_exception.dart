import "app_exceptions.dart";

class UnknownException extends AppException {
  UnknownException(StackTrace? stackTrace) : super("Erro não tratado", stackTrace);
}

extension ValidateExceptionExtension on StackTrace {
  UnknownException asUnknownException() {
    return UnknownException(this);
  }
}
