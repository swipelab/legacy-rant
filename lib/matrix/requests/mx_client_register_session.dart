class MxClientRegisterSession {
  final String session;
  final dynamic flows;
  final dynamic completed;
  final dynamic params;

  MxClientRegisterSession({this.session, this.flows, this.completed, this.params});

  static MxClientRegisterSession fromJson(Map<String, dynamic> json) => MxClientRegisterSession(
        session: json["session"],
        flows: json["flows"],
        params: json["params"],
        completed: json["completed"],
      );
}
