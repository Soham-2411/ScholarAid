import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scholar_aid/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.1),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)))),
                  child: Container(
                    width: width * 0.27,
                    height: width * 0.27,
                    decoration: BoxDecoration(
                        color: HexColor('#261D32'),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  email.substring(0, email.lastIndexOf('@')),
                  style: TextStyle(
                      fontSize: width * 0.06,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('sa_email');
              main();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Authentication()));
            },
            style: ElevatedButton.styleFrom(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                elevation: 10,
                primary: HexColor('#1A1125')),
            child: Text("Logout"),
          ),
        )
      ],
    );
  }
}
