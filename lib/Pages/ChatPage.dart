import 'package:flutter/material.dart';

class Chatpage extends StatefulWidget {
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'ChatPage.dart',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
