library matrix;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chopper/chopper.dart';
import 'package:rant/matrix/exception.dart';
import 'package:rant/matrix/requests/mx_client_register_email_request_token_request.dart';
import 'package:rant/matrix/requests/mx_client_register_session.dart';
import 'package:rant/matrix/types/mx_get_room_messages.dart';
import 'package:rant/matrix/types/mx_text.dart';
import 'package:rant/matrix/types/mx_user_kind.dart';
import 'package:rant/models/models.dart';
import 'package:rant/util/util.dart';
import 'package:scoped/scoped.dart';

import 'client.dart';
import 'requests/mx_client_get_sync_response.dart';
import 'requests/mx_client_login_response.dart';
import 'requests/mx_client_put_room_event_response.dart';
import 'requests/mx_client_register_request.dart';
import 'requests/mx_client_register_response.dart';

class Matrix {
  final Store store;
  final String baseUrl;

  String _accessToken;
  String _self;

  String get self => _self;

  Client _client;

  Client get client => _client;

  Matrix({this.store, this.baseUrl}) {
    _client = Client.create(ChopperClient(
        baseUrl: baseUrl,
        services: [
          Client.create(),
        ],
        interceptors: [_accessTokenInterceptor, _exceptionInterceptor],
        errorConverter: JsonConverter(),
        converter: JsonConverter()));
  }

  Future<Request> _accessTokenInterceptor(Request request) async {
    if (this._accessToken == null) return request;
    final headers = Map<String, String>.from(request.headers)
      ..['Authorization'] = 'Bearer $_accessToken'
      ..['Content-Type'] = 'application/json';
    return request.copyWith(headers: headers);
  }

  FutureOr<Response> _exceptionInterceptor(Response response) async {
    if (!response.isSuccessful) {
      throw MxException.fromResponse(response);
    }
    return response;
  }

  Future<MxClientLoginResponse> login({String user, String password}) async {
    final resp = await _client.postLogin(
        body: {"type": "m.login.password", "user": user, "password": password});
    final body = MxClientLoginResponse.fromJson(resp.body);
    _accessToken = body.accessToken;
    _self = body.userId;
    return body;
  }

  Future<MxClientPutRoomEventResponse> putRoomMessage({String roomId, String body}) async {
    final content = MxText(body: body);
    return await putRoomEvent(
        roomId: roomId,
        eventType: 'm.room.message',
        txnId: Id.newId(),
        body: content.toJson());
  }

  Future<MxClientPutRoomEventResponse> putRoomEvent({
    String roomId,
    String eventType,
    dynamic body,
    String txnId,
  }) async {
    try {
      final resp = await client.putRoomEvent(
          roomId: roomId, eventType: eventType, txnId: txnId, body: body);
      return MxClientPutRoomEventResponse.fromJson(resp.body);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<MxClientGetSyncResponse> sync({String since, int timeout = 30000, String filter = '0'}) async {
    final resp =
    await client.getSync(since: since, timeout: timeout, filter: filter);
    return MxClientGetSyncResponse.fromJson(resp.body);
  }

  Future<String> getProfileDisplayName({String user}) async {
    final resp = await _client.getProfileDisplayName(user);
    return resp.body['displayname'];
  }

  Future<void> putProfileDisplayName({String user, String displayName}) async {
    await _client.putProfileDisplayName(user, {"displayname": displayName});
  }

  Future<String> getProfileAvatarUrl({String user}) async {
    final resp = await _client.getProfileAvatarUrl(user);
    return resp.body['avatar_url'];
  }

  Future<void> putProfileAvatarUrl({String user, String avatarUrl}) async {
    await _client.putProfileAvatarUrl(user, {"avatar_url": avatarUrl});
  }

  Future<Profile> getProfile({String user}) async {
    final resp = await _client.getProfile(user);
    return Profile(
      alias: resp.body['displayname'],
      avatar: Matrix.mxcToUrl(resp.body['avatar_url']),
    );
  }

  Future<List<String>> getJoinedRooms() async {
    final resp = await _client.getJoinedRooms();
    final result = (resp.body['joined_rooms'] as List).cast<String>().toList();
    return result;
  }

  Future<MxGetRoomMessages> getRoomMessages({String roomId}) async =>
      await _client.getRoomMessages(roomId: roomId);

  static String mxcToUrl(String url, {int width, int height}) {
    if (url?.isNotEmpty != true) return null;

    Uri uri = Uri.tryParse(url);
    if (uri != null && uri.isScheme("mxc")) {
      var host = uri.host;
      var authority = uri.authority;
      var matrixPath = "_matrix/media/v1";
      var path =
      uri.pathSegments?.firstWhere((element) => true, orElse: () => "");

      if (width == null || height == null) {
        return "https://$host/$matrixPath/download/$authority/$path";
      } else {
        return "https://$host/$matrixPath/thumbnail/$authority/$path?width=$width&height=$height";
      }
    }

    return uri?.toString();
  }

  Future<MxClientRegisterResponse> register({String username, String password, String email}) async {
    MxClientRegisterSession session;

    email = email ?? "scors.agra@gmail.com";

    try {
      await _client.register(
          kind: mxUserKindString(MxUserKind.user),
          body: MxClientRegisterRequest(username: username, password: password)
              .toJson());
      throw Exception("POST /register should throw 401 Unauthorized");
    } on MxHttpException catch (e) {
      session = MxClientRegisterSession.fromJson(e.body);
    }

    final token = await _client.registerEmailRequestToken(
        body: MxClientRegisterEmailRequestTokenRequest(email: email, sendAttempt: 1, clientSecret: cryptoString()));

    print(token);
  }

  static String cryptoString([int length = 32]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (index) => random.nextInt(256));
    return base64Url.encode(values);
  }
}
