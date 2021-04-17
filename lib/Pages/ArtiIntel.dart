import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart';

class AI extends StatefulWidget {
  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<AI> {

  var status = 'para';
  var summary = '';
  var para = '';
  var questions = [];
  var correct = [];
  var answers = [];

  generateSummary(String doc) async {
    var url = 'http://localhost:7000/?' + 'passage=' + doc;

    try {
      print('calling');
      Response response = await http.get(url);
      print('called');
      dom.Document document = parser.parse(response.body);
      setState(() {
        summary = document.getElementsByTagName('h1')[0].innerHtml;
      });
      print(summary);
    } catch (e) {}
  }

  generateQuestions(String doc) async {
    var url = 'http://localhost:5000/?' + 'text=' + doc;

    try {
      print('calling');
      Response response = await http.get(url);
      print('called');
      dom.Document document = parser.parse(response.body);
      setState(() {
        for(var q in document.getElementsByTagName('h1')) {
          questions.add(q.innerHtml);
        }
        for(var q in document.getElementsByTagName('h2')) {
          correct.add(q.innerHtml);
          answers.add('');
        }
      });
      print(questions);
      print(correct);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'ParaQueries',
              style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff261D32),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: status == 'para' ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '    Powered by AI',
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 12,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                width: 4,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                  'Provide Us With Some Docs...',
                                style: TextStyle(
                                    color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize:18
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 8,
                            maxLines: 16,
                            style: TextStyle(
                                color: Colors.grey
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter ~ Here',
                              hintStyle: TextStyle(
                                  color: Color(0xffdbddfa)
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              para = value;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5B04BC)) ),
                                child: Text(
                                  'Generate Summary',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    generateSummary(para);
                                    status = 'sum';
                                  });
                                },
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5B04BC)) ),
                                child: Text(
                                  'Take a Test',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2
                                  ),
                                ),
                                onPressed: () {
                                  generateQuestions(para);
                                  setState(() {
                                    status = 'test';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ) : status == 'sum' ? Container(
                      //height: height/1.5,
                      width: width/1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '    Powered by AI',
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 12,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                                'Summary',
                              style: TextStyle(
                                  fontSize: width * 0.08,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: SingleChildScrollView(
                              child: Text(
                                summary,
                                style: TextStyle(
                                    color: Color(0xffdbddfa)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5B04BC)) ),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  status = 'para';
                                  summary = '';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ) : status == 'test' ? Container(
                      //height: height/1.5,
                      width: width/1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '    Powered by AI',
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 12,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: Text(
                              'Test',
                              style: TextStyle(
                                  fontSize: width * 0.08,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.all(24.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for(int i = 0;i < questions.length; i++)
                                    ListTile(
                                      title: Text(
                                          questions[i],
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: EdgeInsets.only(bottom: 12, left: 8),
                                        child: TextField(
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Your Answer..',
                                            hintStyle: TextStyle(
                                                color: Color(0xffdbddfa)
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            answers[i] = value;
                                          },
                                        ),
                                      ),
                                    )
                                ],
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xff5B04BC)) ),
                              child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  status = 'para';
                                  questions = [];
                                  correct = [];
                                  answers = [];
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ) : Container(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
