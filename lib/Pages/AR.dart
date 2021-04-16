import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ARModelDetails {
  final String image;
  final String link;
  final String title;

  ARModelDetails(this.image, this.link, this.title);
}

List<ARModelDetails> _arModelDetails = [
  ARModelDetails('Imagelink', 'AR Link', 'Title'),
  ARModelDetails('Imagelink1', 'AR Link1', 'Title1'),
  ARModelDetails('Imagelink2', 'AR Link2', 'Title2'),
];

class ARModels extends StatefulWidget {
  @override
  _ARModelsState createState() => _ARModelsState();
}

class _ARModelsState extends State<ARModels> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "AR Models",
              style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            for (int index = 0; index < _arModelDetails.length; index++)
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: HexColor("#261D32"),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    child: Container(
                        height: 150,
                        width: width - 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: HexColor('#5B04BC'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _arModelDetails[index].title,
                              style: TextStyle(
                                fontSize: width * 0.05,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white.withAlpha(50),
                                ),
                              ),
                            ),
                          ],
                        )),
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
