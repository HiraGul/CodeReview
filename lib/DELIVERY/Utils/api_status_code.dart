import '../Data/Models/my_error_model.dart';

class ApiStatusCode {
  static int ok = 200;
  static int created = 201;
  static int accepted = 201;
  static int badRequest = 400;
  static int unAuthorized = 401;
  static int forbidden = 403;
  static int notFound = 404;
  static int unprocessableContent = 422;
  static int requestTimeOut = 408;
  static int tooManyRequest = 429;
  static int internalServerError = 500;
  static int socketException = 503;
  static String sessionExpireMessage = 'Session Expire Please Login again';
  static String weakInternetMessage = "Weak or no Internet Connection";

  static MyErrorModel getErrorMessage({required int statusCode}) {
    if (statusCode == unAuthorized) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'UnAuthorized operation perform',
        description: 'Session Expire Please login again',
      );
    } else if (statusCode == forbidden) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Request forbidden',
        description: '',
      );
    } else if (statusCode == notFound) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: "Not found",
        description: 'No data found for the requested url',
      );
    } else if (statusCode == requestTimeOut) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Request Time out',
        description: 'Time out for the request Please try again later',
      );
    } else if (statusCode == tooManyRequest) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Too Many Request',
        description: 'You exceed your request limit please try again later',
      );
    } else if (statusCode == badRequest) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Bad Request',
        description: 'Unexpected error occur',
      );
    } else if (statusCode == internalServerError) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Server not responding',
        description: '',
      );
    } else if (statusCode == unprocessableContent) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Un-processable Content',
        description: 'Can not perform any action on the provided data',
      );
    } else if (statusCode == socketException) {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: 'Weak or not internet Connection',
        description: 'Please check your internet connection and try again',
      );
    } else {
      return MyErrorModel(
        statusCode: statusCode.toString(),
        message: "Something went wrong",
        description: '',
      );
    }
  }
}
