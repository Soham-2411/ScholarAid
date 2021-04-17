import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'One_on_One_Chat/ChatRoom.dart';

class TutorsList extends StatefulWidget {
  @override
  TutorsListState createState() => TutorsListState();
}

final _firestore = FirebaseFirestore.instance;
List<TutorCards> tutorCards=[];
class TutorsListState extends State<TutorsList> {
  @override
  void initState() {
    // TODO: implement initState
     tutorCards = [new TutorCards(name: 'Dr. P.Madhavan',subject: 'Computer Communication',email: 'pmadhavan@srmist.edu.in',hourlyrate: 'Rs 500/hr',phoneno: '95166816548',),new TutorCards(name: 'Dr. C.Madhavan',subject: 'Chemistry',email: 'cmadhavan@srmist.edu.in',hourlyrate: 'Rs 500/hr',phoneno: '951668165488'),new TutorCards(name: 'Dr. L.Madhavan',subject: 'Lingustics',email: 'lmadhavan@srmist.edu.in',hourlyrate: 'Rs 500/hr',phoneno: '95166816546')];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width - 150,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "List of Tutors",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatRoom()));
                  },
                  icon: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => IndexPage()));
                //   },
                //   icon: Icon(
                //     Icons.video_call_rounded,
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
            SizedBox(height: 40),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final cards = snapshot.data.docs.reversed;


                // for (var card in cards) {
                //   String name = card.data()['Email'];
                //   //String select = card.data()['select'];
                //   //if (select == 'Tutor') {
                //     final tutorCard = TutorCards(name: name);
                //     tutorCards.add(tutorCard);
                //
                // }
                print(tutorCards);
                return Container(
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          children: tutorCards,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TutorCards extends StatefulWidget {
  String name,email,phoneno,subject,hourlyrate;
  TutorCards({this.name,this.hourlyrate,this.subject,this.phoneno,this.email});
  @override
  TutorCardsState createState() => TutorCardsState();
}

class TutorCardsState extends State<TutorCards> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 8,
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width-20,
          padding: EdgeInsets.only(left: 5, top: 5),

            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Name :'+widget.name,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email :'+widget.email,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('PhoneNo : '+widget.phoneno,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Subject :'+widget.subject,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hourly Rate :'+widget.hourlyrate,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  TextButton(onPressed: (){}, child: Text('Pay'))

                ],
              ),
            ),

        ));
  }
}
