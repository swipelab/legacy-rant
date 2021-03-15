import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

abstract class MxException implements Exception {
  final String _type;
  final String _message;

  MxException(this._type, this._message);

  String toString() => "$_type: $_message";

  static MxException fromResponse(Response response) {
    String code;
    String message;
    try {
      code = response.body["errcode"];
      message = response.body["error"];
    } catch (_) {
      return MxHttpException(response: response);
    }

    switch (code) {
      case "M_UNKNOWN":
        return MxUnknownException(message: message);
      case "M_FORBIDDEN":
        if (message?.contains("Federation denied with") == true) {
          return MxFederationDeniedException(message: message);
        }
        return MxForbiddenException(message: message);
      case "M_UNKNOWN_TOKEN":
      case "M_UNAUTHORIZED":
        return MxUnauthorizedException(message: message);
      case "M_USER_IN_USE":
        return MxUsernameInUseException(message: message);
      case "M_THREEPID_IN_USE":
        return MxEmailInUseException(message: message);
      case "M_INVALID_USERNAME":
        return MxInvalidUsernameException(message: message);
      case "M_EXCLUSIVE":
        return MxExclusiveException(message: message);
      case "M_CONSENT_NOT_GIVEN":
        return MxConsentNotGivenException(message: message, consentUri: response.body["conset_uri"]);
      case "M_LIMIT_EXCEEDED":
        return MxLimitExceededException(message: message, retryAfterMs: response.body["retry_after_ms"]);
    }
    return MxHttpException(response: response);
  }
}

class MxUnknownException extends MxException {
  MxUnknownException({String message}) : super("MxUnknownException", message);
}

class MxForbiddenException extends MxException {
  MxForbiddenException({String message}) : super("MxForbiddenException", message);
}

class MxFederationDeniedException extends MxException {
  MxFederationDeniedException({String message}) : super("MxFederationDeniedException", message);
}

class MxUnauthorizedException extends MxException {
  MxUnauthorizedException({String message}) : super("MxUnauthorizedException", message);
}

class MxUsernameInUseException extends MxException {
  MxUsernameInUseException({String message}) : super("MxUsernameInUseException", message);
}

class MxEmailInUseException extends MxException {
  MxEmailInUseException({String message}) : super("MxEmailInUseException", message);
}

class MxInvalidUsernameException extends MxException {
  MxInvalidUsernameException({String message}) : super("MxInvalidUsernameException", message);
}

class MxExclusiveException extends MxException {
  MxExclusiveException({String message}) : super("MxExclusiveException", message);
}

class MxConsentNotGivenException extends MxException {
  final String consentUri;

  MxConsentNotGivenException({String message, this.consentUri}) : super("MxConsentNotGivenException", message);
}

class MxLimitExceededException extends MxException {
  final int retryAfterMs;

  MxLimitExceededException({String message, this.retryAfterMs}) : super("MxRateLimitExceeded", message);
}

class MxHttpException extends MxException {
  final Response<dynamic> response;

  MxHttpException({this.response}) : super("MxHttpException", httpResponseString(response.base));

  get statusCode => response.statusCode;
  get body => response.error;
}

String httpResponseString(http.Response response, {bool headers = false}) {
  final buffer = StringBuffer("");
  buffer.write("${response.statusCode} ${response.reasonPhrase}");
  buffer.write("\n");
  if (headers) {
    for (MapEntry<String, String> entry in response.headers.entries) {
      buffer.write("${entry.key}: ${entry.value}");
    }
    buffer.write("\n");
  }
  buffer.write("${response.body}");
  buffer.write("\n");
  return buffer.toString();
}
