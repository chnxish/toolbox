import 'package:dio/dio.dart';

import 'package:toolbox/src/utils/exceptions.dart';

class ErrorHandlingInterceptor extends QueuedInterceptor {
  ErrorHandlingInterceptor({required this.dio});

  final Dio dio;

  @override
  void onError(DioException? err, ErrorInterceptorHandler? handler) {
    var errType = err!.type;
    if (errType == DioExceptionType.connectionError ||
        errType == DioExceptionType.sendTimeout ||
        errType == DioExceptionType.receiveTimeout) {
      handler!.reject(DeadlineExceededException(err.requestOptions));
    } else if (errType == DioExceptionType.badResponse) {
      switch (err.response?.statusCode) {
        case 400:
          handler!.reject(BadRequestException(err.requestOptions));
        case 401:
          handler!.reject(UnauthorizedException(err.requestOptions));
        case 404:
          handler!.reject(NotFoundException(err.requestOptions));
        case 409:
          handler!.reject(ConflictException(err.requestOptions));
        case 500:
          handler!.reject(InternalServerErrorException(err.requestOptions));
      }
    } else if (errType == DioExceptionType.unknown) {
      handler!.reject(NoInternetConnectionException(err.requestOptions));
    } else {
      return handler!.next(err);
    }
  }
}
