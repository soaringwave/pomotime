import 'package:flutter/material.dart';
import 'package:pomotimer/functions/get_time_format.dart';
import 'dart:async';

import 'package:pomotimer/screens/total_time_screen.dart';
import 'package:pomotimer/widgets/icon_button_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int workTime = 10;
  int restTime = 13;
  int leftTime = 10;
  int totalTime = 0;
  late Timer timer;
  late SharedPreferences prefs;
  bool isTick = false;
  bool isWorking = true;
  Color workTimeShadowColor = const Color.fromARGB(156, 255, 183, 144);
  Color restTimeShadowColor = const Color.fromARGB(156, 144, 209, 255);

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('totalTime') != null) {
      setState(() {
        totalTime = prefs.getInt('totalTime')!;
      });
    } else {
      await prefs.setInt('totalTime', 0);
      setState(() {
        totalTime = 0;
      });
    }
  }

  void addTotalTime(int addTime) async {
    prefs = await SharedPreferences.getInstance();
    totalTime = prefs.getInt('totalTime')!;
    setState(() {
      totalTime += addTime;
    });
    await prefs.setInt('totalTime', totalTime);
  }

  void onStartPressed() {
    setState(() {
      isTick = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isTick = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isTick = false;
      isWorking = !isWorking;
      leftTime = isWorking ? workTime : restTime;
    });
  }

  void onTick(Timer timer) {
    if (leftTime == 0) {
      if (isWorking == true) {
        addTotalTime(workTime);
      }
      timer.cancel();
      isWorking = !isWorking;
      setState(() {
        leftTime = isWorking ? workTime : restTime;
        isTick = false;
      });
    } else {
      setState(() {
        leftTime -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                isWorking ? 'Working' : 'Resting',
                style: const TextStyle(
                  fontSize: 45,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(150),
                        boxShadow: [
                          BoxShadow(
                            color: isWorking
                                ? workTimeShadowColor
                                : restTimeShadowColor,
                            offset: const Offset(
                              0,
                              5,
                            ),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        getTimeFormat(leftTime).substring(2),
                        style: const TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButtonContainer(
                      childWidget: IconButton(
                        onPressed: onResetPressed,
                        icon: const Icon(
                          Icons.square_rounded,
                          size: 17,
                        ),
                      ),
                      shadowColor:
                          isWorking ? workTimeShadowColor : restTimeShadowColor,
                    ),
                    IconButtonContainer(
                      childWidget: IconButton(
                        onPressed: isTick ? onPausePressed : onStartPressed,
                        icon: Icon(
                          isTick
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 30,
                        ),
                      ),
                      shadowColor:
                          isWorking ? workTimeShadowColor : restTimeShadowColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TotalTimeScreen(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          isWorking ? workTimeShadowColor : restTimeShadowColor,
                      offset: const Offset(0, -1),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(top: 30),
                  child: Text(
                    "Total Time",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
