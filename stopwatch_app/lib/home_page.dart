import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: StopwatchApp(),
  ));
}

class StopwatchApp extends StatefulWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  State<StopwatchApp> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  int seconds = 0, minutes = 0, hours = 0;
  String formattedSeconds = "00", formattedMinutes = "00", formattedHours = "00";
  Timer? timer;
  bool isRunning = false;
  List<String> laps = [];

  void stopTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      formattedSeconds = "00";
      formattedMinutes = "00";
      formattedHours = "00";
      isRunning = false;
      laps.clear();
    });
  }

  void addLap() {
    String lapTime = "$formattedHours:$formattedMinutes:$formattedSeconds";
    setState(() {
      laps.add(lapTime);
    });
  }

  void startTimer() {
    isRunning = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }

      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        formattedSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        formattedHours = (hours >= 10) ? "$hours" : "0$hours";
        formattedMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Fancy Stopwatch",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "$formattedHours:$formattedMinutes:$formattedSeconds",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 82.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap ${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        (!isRunning) ? startTimer() : stopTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        (!isRunning) ? "Start" : "Stop",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  if (isRunning)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          stopTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      addLap();
                    },
                    icon: Icon(Icons.flag),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        resetTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
