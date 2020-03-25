import 'package:flutter/material.dart';

class BottomAppDataPage extends StatefulWidget {
  final String bottomAppText;

  const BottomAppDataPage({Key key, this.bottomAppText}) : super(key: key);

  @override
  _BottomAppDataPageState createState() => _BottomAppDataPageState();
}

class _BottomAppDataPageState extends State<BottomAppDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            widget.bottomAppText,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
