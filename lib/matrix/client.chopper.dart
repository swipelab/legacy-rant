// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$Client extends Client {
  _$Client([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Client;

  @override
  Future<Response<Map<String, dynamic>>> postLogin({dynamic body}) {
    final $url = '_matrix/client/r0/login';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getSync(
      {String filter,
      String since,
      bool fullState,
      String setPresence,
      int timeout = 0}) {
    final $url = '_matrix/client/r0/sync';
    final $params = <String, dynamic>{
      'filter': filter,
      'since': since,
      'full_state': fullState,
      'set_presence': setPresence,
      'timeout': timeout
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getProfileDisplayName(String userId) {
    final $url = '_matrix/client/r0/profile/$userId/displayname';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> putProfileDisplayName(String userId, dynamic body) {
    final $url = '_matrix/client/r0/profile/$userId/displayname';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getProfileAvatarUrl(String userId) {
    final $url = '_matrix/client/r0/profile/$userId/avatar_url';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> putProfileAvatarUrl(String userId, dynamic body) {
    final $url = '_matrix/client/r0/profile/$userId/avatar_url';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getProfile(String userId) {
    final $url = '_matrix/client/r0/profile/$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getRoomEvent({String roomId, String eventId}) {
    final $url = '_matrix/client/r0/rooms/$roomId/event/$eventId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomStateEvent(
      {String roomId, String eventType, String stateKey}) {
    final $url = '_matrix/client/r0/rooms/$roomId/state/$eventType/$stateKey';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<Map<String, dynamic>>>> _getRoomState({String roomId}) {
    final $url = '_matrix/client/r0/rooms/$roomId/state';
    final $request = Request('GET', $url, client.baseUrl);
    return client
        .send<List<Map<String, dynamic>>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> getRoomMembers({String roomId}) {
    final $url = '_matrix/client/r0/rooms/$roomId/members';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomJoinedMember({String roomId}) {
    final $url = '_matrix/client/r0/rooms/$roomId/joined_members';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> _getRoomMessages(
      {String roomId,
      String from,
      String to,
      String dir,
      int limit,
      String filter}) {
    final $url = '_matrix/client/r0/rooms/$roomId/messages';
    final $params = <String, dynamic>{
      'from': from,
      'to': to,
      'dir': dir,
      'limit': limit,
      'filter': filter
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> putRoomStateEvent(
      {String roomId, String eventType, String stateKey, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/state/$eventType/$stateKey';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> putRoomEvent(
      {String roomId, dynamic eventType, String txnId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/send/$eventType/$txnId';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> putRoomRedact(
      {String roomId, String eventId, String txnId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/redact/$eventId/$txnId';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createRoom({dynamic body}) {
    final $url = '_matrix/client/r0/createRoom';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putRoomAlias({String roomAlias, dynamic body}) {
    final $url = '_matrix/client/r0/directory/room/$roomAlias';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRoomAlias({String roomAlias}) {
    final $url = '_matrix/client/r0/directory/room/$roomAlias';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteRoomAlias({String roomAlias}) {
    final $url = '_matrix/client/r0/directory/room/$roomAlias';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getJoinedRooms() {
    final $url = '_matrix/client/r0/joined_rooms';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> roomInvite({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/invite';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomJoin({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/join';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> join({String roomIdOrAlias, dynamic body}) {
    final $url = '_matrix/client/r0/join/$roomIdOrAlias';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomLeave({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/leave';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomForget({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/forget';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomKick({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/kick';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomBan({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/ban';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> roomUnban({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/rooms/$roomId/unban';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDirectoryRoom({String roomId}) {
    final $url = '_matrix/client/r0/directory/list/room/$roomId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putDirectoryRoom({String roomId, dynamic body}) {
    final $url = '_matrix/client/r0/directory/list/room/$roomId';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPublicRooms(
      {int limit, String since, String query}) {
    final $url = '_matrix/client/r0/publicRooms';
    final $params = <String, dynamic>{
      'limit': limit,
      'since': since,
      'query': query
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putPresenceStatus({String userId, dynamic body}) {
    final $url = '_matrix/client/r0/presence/$userId/status';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPresenceStatus({String userId}) {
    final $url = '_matrix/client/r0/presence/$userId/status';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> _getDevices() {
    final $url = '_matrix/client/r0/devices';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> _getDevice({String deviceId}) {
    final $url = '_matrix/client/r0/devices/$deviceId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<dynamic>> _putDevice({String deviceId, dynamic body}) {
    final $url = '_matrix/client/r0/devices/$deviceId';
    final $body = body;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<dynamic> deleteDevice({String deviceId, dynamic body}) {
    final $url = '_matrix/client/r0/devices/$deviceId';
    final $body = body;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send($request);
  }

  @override
  Future<Response<dynamic>> _deleteDevices({dynamic body}) {
    final $url = '_matrix/client/r0/delete_devices';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> register({String kind, dynamic body}) {
    final $url = '_matrix/client/r0/register';
    final $params = <String, dynamic>{'kind': kind};
    final $body = body;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> registerEmailRequestToken({dynamic body}) {
    final $url = '_matrix/client/r0/register/email/requestToken';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
