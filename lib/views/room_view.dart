import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rant/account.dart';
import 'package:rant/matrix/matrix.dart';
import 'package:rant/matrix/matrix_room.dart';
import 'package:rant/matrix/types/mx_event.dart';
import 'package:rant/room/message_presenter.dart';
import 'package:rant/ux/backdrop.dart';
import 'package:rant/ux/message_composer.dart';
import 'package:rant/ux/picture_frame.dart';
import 'package:rant/ux/screen.dart';

import 'package:scoped/scoped.dart';

class RoomView extends StatefulWidget {
  final MatrixRoom room;

  RoomView({this.room});

  @override
  _RoomViewState createState() => _RoomViewState();
}

class EventPresenter extends StatelessWidget {
  final MatrixRoom room;
  final MxEvent event;
  final String sender;

  EventPresenter(this.room, this.event) : sender = event.sender;

  Widget build(BuildContext context) {
    final mxc = Matrix.mxcToUrl(room.members[sender]?.avatarUrl);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, top: 2, bottom: 2, right: 4),
          child: PictureFrame.circular(
              child: Picture(mxc),
              size: 36,
              radius: 8),
        ),
        Expanded(child: MessagePresenter(event))
      ],
    );
  }
}

class _RoomViewState extends State<RoomView> {
  final ScrollController _scroll = ScrollController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onScroll());
  }

  void onScroll() async {
    if (widget.room.canLoadMore && _scroll.position.extentAfter < 50) {
      await widget.room.loadMore();
      this.setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) => onScroll());
    }
  }

  _RoomViewState() {
    _scroll.addListener(onScroll);
  }

  dispose() {
    super.dispose();
    _scroll.removeListener(onScroll);
  }

  Widget buildTimeline(BuildContext context, MatrixRoom room) {
    return room.timeline.bind((context, timeline) => ListView.builder(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          controller: _scroll,
          itemBuilder: (context, index) =>
              EventPresenter(room, timeline[index]),
          itemCount: timeline.length,
          reverse: true,
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.room.displayName
              .bindValue((context, value) => Text(value)),
          actions: <Widget>[
            widget.room.workers.bindValue(
                (_, v) => Center(child: Text(v > 0 ? 'loading...' : 'idle'))),
            context
                .get<Account>()
                .workers
                .bindValue((_, v) => Center(child: Text('(${v.toString()})'))),
          ]),
      body: Column(
        children: [
          Expanded(
            child: buildTimeline(context, widget.room),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Color(0x33000000),
                  offset: Offset.zero,
                  spreadRadius: 0,
                  blurRadius: 6)
            ]),
            child: MessageComposer(
                onMessage: (message) =>
                    widget.room.sendMessage(body: message.body)),
          )
        ],
      ),
    );
  }
}
