class MxClientRegisterEmailRequestTokenResponse {
  final bool success;
  final String sid;

  MxClientRegisterEmailRequestTokenResponse({this.success, this.sid});

  static MxClientRegisterEmailRequestTokenResponse fromJson(
          Map<String, dynamic> json) =>
      MxClientRegisterEmailRequestTokenResponse(
        success: json["success"],
        sid: json["sid"],
      );
}
