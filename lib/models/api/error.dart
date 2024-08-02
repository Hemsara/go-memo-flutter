enum ErrorStatus {
  ok, // 200
  badRequest, // 400
  unauthorized, // 401
  forbidden, // 403
  notFound, // 404
  internalServerError, // 500
  socketError, // 403

  timeout, // 403

  serviceUnavailable, // 503
  unknown
}

ErrorStatus fromCode(int code) {
  switch (code) {
    case 200:
      return ErrorStatus.ok;
    case 400:
      return ErrorStatus.badRequest;
    case 401:
      return ErrorStatus.unauthorized;
    case 403:
      return ErrorStatus.forbidden;
    case 404:
      return ErrorStatus.notFound;
    case 500:
      return ErrorStatus.internalServerError;
    case 503:
      return ErrorStatus.serviceUnavailable;
    default:
      return ErrorStatus.unknown;
  }
}

String description(ErrorStatus status) {
  switch (status) {
    case ErrorStatus.ok:
      return 'OK';
    case ErrorStatus.badRequest:
      return 'Bad Request';
    case ErrorStatus.unauthorized:
      return 'Unauthorized';
    case ErrorStatus.forbidden:
      return 'Forbidden';
    case ErrorStatus.notFound:
      return 'Not Found';
    case ErrorStatus.internalServerError:
      return 'Internal Server Error';
    case ErrorStatus.serviceUnavailable:
      return 'Service Unavailable';
    default:
      return 'Unknown Status';
  }
}

class ApiError {
  final String message;
  final ErrorStatus status;

  ApiError({
    this.status = ErrorStatus.unknown,
    required this.message,
  });

  @override
  String toString() {
    return 'ApiError(status: $status, message: $message)';
  }
}
