import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rant/account.dart';
import 'package:rant/matrix/matrix_room.dart';
import 'package:rant/ux/picture_frame.dart';
import 'package:rant/views/room_view.dart';
import 'package:rant/ux/sliver_page.dart';
import 'package:rant/ux/paper.dart';
import 'package:rant/ux/tile.dart';
import 'package:scoped/scoped.dart';
import 'package:rant/util/util.dart';

class ChatView extends StatelessWidget {
  Widget buildRoom(BuildContext context, MatrixRoom room) {
    return ListTile(
        title: room.displayName.bindValue((_, v) => Text(v.ellipsis(20))),
        //subtitle: room.lastMessage.bindValue((_, v) => Text('subtitle')),
        trailing: Text('July 10 \'20'),
        leading: PictureFrame.circular(
            child: room.avatarUrl.bindValue((context, url) => Picture(url))),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => RoomView(room: room))));
//      Tile(
//        leading: room.avatarUrl.bindValue((_, v) =>
//            v == null ? Container(color: Colors.blue) : Image.network(v)),
//        stamp: room.lastSeen.bindValue((_, v) => TileStampText(v)),
//        onTap: () => Navigator.of(context)
//            .push(MaterialPageRoute(builder: (_) => RoomView(room: room))));
  }

  Widget buildRooms(BuildContext context) {
    return context
        .get<Account>()
        .rooms
        .bindValue((context, rooms) => ListView.separated(
              separatorBuilder: (context, index) => Divider(
                height: 1,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) => buildRoom(context, rooms[index]),
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHATS'),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: buildRooms(context),
    );
  }
}
