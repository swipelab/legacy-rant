class MxClientRegisterEmailRequestTokenRequest {
  final String clientSecret;
  final String email;
  final int sendAttempt;
  final String nextLink;
  final String idServer;
  final String idServerToken;

  MxClientRegisterEmailRequestTokenRequest({
    this.clientSecret,
    this.email,
    this.sendAttempt,
    this.nextLink,
    this.idServer,
    this.idServerToken,
  });

  Map<String, dynamic> toJson() => {
        "client_secret": clientSecret,
        "email": email,
        "send_attempt": sendAttempt,
        "next_link": nextLink,
        "id_server": idServer,
        "id_server_token": idServerToken,
      };
}
