import 'package:rant/matrix/types/mx_authentication_data.dart';
import 'package:rant/util/json_extension.dart';

class MxClientRegisterRequest {
  final MxAuthenticationData auth;
  final String username;
  final String password;
  final String deviceId;
  final String initialDeviceDisplayName;
  final bool inhibitLogin;

  MxClientRegisterRequest({
    this.auth,
    this.username,
    this.password,
    this.deviceId,
    this.initialDeviceDisplayName,
    this.inhibitLogin,
  });

  Map<String, dynamic> toJson() => {
        "auth": auth?.toJson(),
        "username": username,
        "password": password,
        "device_id": deviceId,
        "initial_device_display_name": initialDeviceDisplayName,
        "inhibit_login": inhibitLogin
      }..denull();
}
