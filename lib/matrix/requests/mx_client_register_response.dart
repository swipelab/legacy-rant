class MxClientRegisterResponse {
  final String userId;
  final String accessToken;
  final String homeServer;
  final String deviceId;

  MxClientRegisterResponse({this.userId, this.accessToken, this.homeServer, this.deviceId});

  static MxClientRegisterResponse fromJson(Map<String, dynamic> json) => MxClientRegisterResponse(
        userId: json["user_id"],
        accessToken: json["access_token"],
        homeServer: json["home_server"],
        deviceId: json["device_id"],
      );
}
