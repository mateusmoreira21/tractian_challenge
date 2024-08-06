import "dart:io";

import "package:dio/dio.dart";

class CustomDioInterceptors extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err);
          case 401:
            throw UnauthorizedException(err);
          case 404:
            throw NotFoundException(err);
          case 500:
            throw InternalServerErrorException(err);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        switch (err.error.runtimeType) {
          case const (SocketException):
            throw NoServerFoundException(err.requestOptions);
          case const (TypeError):
            throw DataParsingException(err.requestOptions);
          default:
            throw NoInternetConnectionException(err.requestOptions);
        }
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioException {
  BadRequestException(DioException exception) : super(requestOptions: exception.requestOptions, response: exception.response);

  @override
  String get message => response?.data["mensagem"] ?? "Requisição inválida";
}

class DataParsingException extends DioException {
  DataParsingException(RequestOptions r) : super(requestOptions: r);

  @override
  String get message => "Erro na conversão de dados";
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(DioException exception) : super(requestOptions: exception.requestOptions, response: exception.response);

  @override
  String get message => response?.data["mensagem"] ?? "Ocorreu um erro no servidor, tente novamente.";
}

class UnauthorizedException extends DioException {
  UnauthorizedException(DioException exception) : super(requestOptions: exception.requestOptions, response: exception.response);

  @override
  String get message => response?.data["mensagem"] ?? "Acesso negado";
}

class NotFoundException extends DioException {
  NotFoundException(DioException exception) : super(requestOptions: exception.requestOptions, response: exception.response);

  @override
  String get message => response?.data is String ? "As informações solicitadas não foram encontradas" : response?.data["mensagem"];
}

class NoServerFoundException extends DioException {
  NoServerFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String get message => "Não foi possivel se conectar ao servidor";
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String get message => "Falha na conexão.";
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String get message => "A conexão expirou, tente novamente.";
}
