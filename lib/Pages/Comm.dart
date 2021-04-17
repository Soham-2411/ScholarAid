import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:all_sensors/all_sensors.dart';
import 'package:hexcolor/hexcolor.dart';

class Communication extends StatefulWidget {
  @override
  _CommunicationState createState() => _CommunicationState();
}

bool proximityValues = false;

class _CommunicationState extends State<Communication> {
  CountDownController _controller = CountDownController();
  int _duration = 3600;
  bool proximityValues = false;
  bool flag = true;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(proximityEvents.listen((ProximityEvent event) {
      setState(() {
        proximityValues = event.getValue();
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
          child: Column(
        children: [
          CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,

            // Ring Color for Countdown Widget.
            ringColor: HexColor('#1A1125'),

            // Ring Gradient for Countdown Widget.
            ringGradient: null,

            // Filling Color for Countdown Widget.
            fillColor: Colors.purple,

            // Filling Gradient for Countdown Widget.
            fillGradient: null,

            // Background Color for Countdown Widget.
            backgroundColor: Colors.transparent,

            // Background Gradient for Countdown Widget.
            backgroundGradient: null,

            // Border Thickness of the Countdown Ring.
            strokeWidth: 20.0,

            // Begin and end contours with a flat edge and no extension.
            strokeCap: StrokeCap.round,

            // Text Style for Countdown Text.
            textStyle: TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),

            // Format for the Countdown Text.
            textFormat: CountdownTextFormat.S,

            // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
            isReverse: false,

            // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
            isReverseAnimation: false,

            // Handles visibility of the Countdown Text.
            isTimerTextShown: true,

            // Handles the timer start.
            autoStart: false,

            // This Callback will execute when the Countdown Starts.
            onStart: () {
              // Here, do whatever you want
              print('Countdown Started');
            },

            // This Callback will execute when the Countdown Ends.
            onComplete: () {
              // Here, do whatever you want
              print('Countdown Ended');
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('#6F01EC'),
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    child: Container(
                        width: width / 3 + 20,
                        height: 60,
                        child: Center(
                            child: Text(
                          "Start Session",
                          style: TextStyle(fontSize: width * 0.045),
                        ))),
                    onPressed: () {
                      Timer(
                        Duration(seconds: 1),
                        () {
                          if (proximityValues == true) {
                            Timer.periodic(Duration(milliseconds: 1), (timer) {
                              if (proximityValues == false) {
                                _controller.pause();
                                flag = true;
                              } else if (flag == true &&
                                  proximityValues == true) {
                                _controller.resume();
                                flag = false;
                              }
                            });
                            _controller.start();
                          }
                        },
                      );
                    }),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    child: Container(
                        width: width / 3 + 20,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: HexColor('5B04BC'))),
                        child: Center(
                            child: Text(
                          "End Session",
                          style: TextStyle(fontSize: width * 0.045),
                        ))),
                    onPressed: () => _controller.restart(duration: _duration))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
