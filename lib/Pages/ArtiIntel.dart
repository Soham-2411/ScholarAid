import 'package:flutter/material.dart';

class AI extends StatefulWidget {
  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<AI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "ArtiIntel.dart",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
