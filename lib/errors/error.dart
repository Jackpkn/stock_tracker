abstract class Exception {
  String message;
  Exception(this.message);
}

class NetworkException extends Exception {
  NetworkException(super.message);
}

class ApiException extends Exception {
  ApiException(super.message);
}

class InvalidApiResponseException extends Exception {
  InvalidApiResponseException(super.message);
}

class UnauthorizedApiException extends Exception {
  UnauthorizedApiException(super.message);
}

class BadRequestApiException extends Exception {
  BadRequestApiException(super.message);
}

class TooManyRequestsApiException extends Exception {
  TooManyRequestsApiException(super.message);
}
