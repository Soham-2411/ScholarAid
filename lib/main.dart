import 'dart:async';
import 'package:page_transition/page_transition.dart';
import 'Pages/Navbar.dart';
import 'authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  email = prefs.getString('sa_email');
  if (email == null) email = '';
  runApp(ScholarAid());
}

class ScholarAid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    Timer(Duration(seconds: 3), () {
      if (email == '') {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: Authentication(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 625)));
      } else {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: NavBar(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 625)));
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ScholarAid',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: w / 10,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h / 4,
            ),
            Image.asset('assets/loading.gif'),
            Text(
              '~  Ctrl  ~  Alt  ~  Elite  ~',
              style: TextStyle(
                  color: Color(0xffdbddfa),
                  fontSize: w / 32.7272,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Presents',
              style: TextStyle(
                  color: Color(0xffdbddfa),
                  fontSize: w / 32.7272,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
