import 'package:flutter/material.dart';
import 'package:rant/matrix/matrix.dart';
import "package:scoped/scoped.dart";

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  register(BuildContext context) async {
    final mx = context.get<Matrix>();
    try {
      final resp =
          await mx.register(username: "balaur2020", password: "balaur2020");
      print(resp.accessToken);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              FlatButton(
                  onPressed: () => register(context), child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }
}
