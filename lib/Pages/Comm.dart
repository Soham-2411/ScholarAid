import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:all_sensors/all_sensors.dart';

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
                  ringColor: Colors.black,

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
                      fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    _button(
                        title: "Start Session",
                        onPressed: () {
                          Timer(Duration(seconds: 1),(){
                            if(proximityValues==true) {
                              Timer.periodic(Duration(milliseconds: 1), (timer) {
                                if(proximityValues==false) {
                                  _controller.pause();
                                  flag = true;
                                }
                                else if(flag == true && proximityValues==true)
                                {
                                  _controller.resume();
                                  flag = false;
                                }
                              });
                              _controller.start();
                            }
                          },);
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    _button(
                        title: "End Session",
                        onPressed: () => _controller.restart(duration: _duration))
                  ],
                ),
              ],
            )),
    );
  }

  _button({String title, VoidCallback onPressed}) {
    return Expanded(
        child: ElevatedButton(
          child: Container(
            height: 50,
            child: Center(
              child: Text(
                title,
                style: TextStyle(color: Colors.white , fontSize: 17),
              ),
            ),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
        ));
  }
}
