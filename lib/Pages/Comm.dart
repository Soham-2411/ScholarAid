import 'package:flutter/material.dart';

class Communication extends StatefulWidget {
  @override
  _CommunicationState createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Comm.dart",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
