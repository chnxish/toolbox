import 'package:dio/dio.dart';

import 'package:toolbox/src/utils/exceptions.dart';

class ErrorHandlingInterceptor extends QueuedInterceptor {
  ErrorHandlingInterceptor({required this.dio});

  final Dio dio;

  @override
  void onError(DioException? err, ErrorInterceptorHandler? handler) {
    var errType = err!.type;
    var requestOptions = err.requestOptions;
    var response = err.response;
    if (errType == DioExceptionType.connectionError ||
        errType == DioExceptionType.sendTimeout ||
        errType == DioExceptionType.receiveTimeout) {
      handler!.reject(DeadlineExceededException(requestOptions, response!));
    } else if (errType == DioExceptionType.badResponse) {
      switch (err.response?.statusCode) {
        case 400:
          handler!.reject(BadRequestException(requestOptions, response!));
        case 401:
          handler!.reject(UnauthorizedException(requestOptions, response!));
        case 404:
          handler!.reject(NotFoundException(requestOptions, response!));
        case 409:
          handler!.reject(ConflictException(requestOptions, response!));
        case 500:
          handler!
              .reject(InternalServerErrorException(requestOptions, response!));
      }
    } else if (errType == DioExceptionType.unknown) {
      handler!.reject(NoInternetConnectionException(requestOptions, response!));
    } else {
      return handler!.next(err);
    }
  }
}
