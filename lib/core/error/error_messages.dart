import 'failures.dart';

const String INVALID_INPUT_ERROR_MESSAGE = "Invalid input detected!";
const String DEVICE_OFFLINE_ERROR_MESSAGE = "No internet detected!";
const String UNKNOWN_ERROR_MESSAGE = "Unknown error!";
const String NOT_FOUND_ERROR_MESSAGE = "Word entry not found!";
const String INVALID_FILTER_ERROR_MESSAGE = "Invalid filter used!";
const String TOO_LONG_URL_ERROR_MESSAGE = "The URL is too long!";
const String SERVER_FAILURE_ERROR_MESSAGE = "Server failure has occured!";
const String UNAUTHORIZED_ERROR_MESSAGE = "Unauthorized access!";

String getErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case DeviceOfflineFailure:
      return DEVICE_OFFLINE_ERROR_MESSAGE;
    case NotFoundFailure:
      return NOT_FOUND_ERROR_MESSAGE;
    case InvalidFilterFailure:
      return INVALID_FILTER_ERROR_MESSAGE;
    case TooLongURLFailure:
      return TOO_LONG_URL_ERROR_MESSAGE;
    case ServerFailure:
      return SERVER_FAILURE_ERROR_MESSAGE;
    case UnauthorizedFailure:
      return UNAUTHORIZED_ERROR_MESSAGE;
    default:
      return UNKNOWN_ERROR_MESSAGE;
  }
}
