import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rant/account.dart';
import 'package:rant/matrix/matrix.dart';
import 'package:rant/matrix/matrix_room.dart';
import 'package:rant/matrix/types/mx_event.dart';
import 'package:rant/room/message_presenter.dart';
import 'package:rant/ux/message_composer.dart';
import 'package:rant/ux/page.dart';

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
        mxc == null
            ? Container(
                width: 48,
                height: 48,
                color: Colors.grey,
              )
            : CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    Matrix.mxcToUrl(room.members[sender]?.avatarUrl),
                    width: 48,
                    height: 48,
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
          padding: EdgeInsets.only(top: 96),
          itemBuilder: (context, index) =>
              EventPresenter(room, timeline[index]),
          itemCount: timeline.length,
          reverse: true,
        ));
  }

  Widget build(BuildContext context) {
    return Page(
      top: AppBar(
        title:
            widget.room.displayName.bindValue((context, value) => Text(value)),
        actions: <Widget>[
          widget.room.workers.bindValue(
              (_, v) => Center(child: Text(v > 0 ? 'loading...' : 'idle'))),
          context
              .get<Account>()
              .workers
              .bindValue((_, v) => Center(child: Text('(${v.toString()})'))),
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: buildTimeline(context, widget.room),
            ),
          ),
        ],
      ),
      bottom: MessageComposer(
          onMessage: (message) => widget.room.sendMessage(body: message.body)),
    );
  }
}
