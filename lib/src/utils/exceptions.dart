import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'Invalid request: ${response!.data['message']}';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'Unknown error, please try again...';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'Conflict occurred: ${response!.data['message']}';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'Access denied: ${response!.data['message']}';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'The requested info could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(
      RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'No internet connection found, please try again...';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions requestOptions, Response response)
      : super(requestOptions: requestOptions, response: response);
  @override
  String toString() {
    return 'The connection has timed out, please try again...';
  }
}
