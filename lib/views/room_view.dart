import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rant/account.dart';
import 'package:rant/matrix/matrix.dart';
import 'package:rant/matrix/matrix_room.dart';
import 'package:rant/matrix/types/mx_event.dart';
import 'package:rant/room/message_presenter.dart';
import 'package:rant/ux/backdrop.dart';
import 'package:rant/ux/message_composer.dart';

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
    final mxc = room.members[sender]?.avatarUrl;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFBBBBBB),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF777777), width: 1.5),
          ),
          child: mxc == null
              ? null
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    Matrix.mxcToUrl(room.members[sender]?.avatarUrl),
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
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
          controller: _scroll,
          padding: EdgeInsets.only(top: 96, bottom: 64),
          itemBuilder: (context, index) =>
              EventPresenter(room, timeline[index]),
          itemCount: timeline.length,
          reverse: true,
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: buildTimeline(context, widget.room)),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Backdrop(
                  child: AppBar(
                      backgroundColor: Colors.white12,
                      title: widget.room.displayName
                          .bindValue((context, value) => Text(value)),
                      actions: <Widget>[
                    widget.room.workers.bindValue((_, v) =>
                        Center(child: Text(v > 0 ? 'loading...' : 'idle'))),
                    context.get<Account>().workers.bindValue(
                        (_, v) => Center(child: Text('(${v.toString()})'))),
                  ]))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Backdrop(
              child: Container(
                color: Color(0xAAFFFFFF),
                child: MessageComposer(
                    onMessage: (message) =>
                        widget.room.sendMessage(body: message.body)),
              ),
            ),
          ),
        ],
      ),
    );

//    child: Column(
//    children: <Widget>[
//    Expanded(
//    child: Padding(
//    padding: const EdgeInsets.only(bottom: 48),
//    child: buildTimeline(context, widget.room),
//    ),
//    ),
//    ],
//    ),
//    child: MessageComposer(
//    onMessage: (message) => widget.room.sendMessage(body: message.body)),
//    );
  }
}
