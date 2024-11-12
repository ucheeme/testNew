
class Success {
  int code;
  Object response;
  Success(this.code, this.response);
}
class Failure {
  int code;
  Object? errorResponse;
  Failure(this.code, this.errorResponse);
}
class NetWorkFailure {
  int code = 500;
  String message = "Network Failure";
}
class ForbiddenAccess {
  int code = 403;
  String message = "Forbidden Access";

}
class UnExpectedError {
  int code = 0;
  String message = "An unexpected error occured";
}

class HandlingResponse {
  HandlingResponse(this.response);

  Object response;

}
class ApiResponseCodes {
  static const success = 200;
  static const create_success = 201;
  static const error = 400;
  static const internalServerError = 500;
  static const authorizationError = 401;
  static const invalidData = 404;
  static const newDevice = 180;
  static const incompleteRegistration = 190;
  static const changePassword = -60;
}