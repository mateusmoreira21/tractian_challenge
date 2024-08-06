import 'dart:developer';

abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  AppException(this.message, this.stackTrace) {
    log("\nmessage: $message", stackTrace: stackTrace);
    // debugPrintStack(label: "\nmessage: $message", stackTrace: stackTrace);
  }

  @override
  String toString() {
    return "$runtimeType: $message${stackTrace == null ? '' : '\n$stackTrace'}";
  }
}
