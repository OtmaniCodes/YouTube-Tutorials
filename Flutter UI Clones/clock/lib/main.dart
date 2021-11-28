// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(ClockApp());
}

class ClockApp extends StatelessWidget {
  const ClockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black54),
      home: ClockBody(),
    );
  }
}

class ClockBody extends StatefulWidget {
  const ClockBody({Key? key}) : super(key: key);

  @override
  _ClockBodyState createState() => _ClockBodyState();
}

enum Time { SEC, MIN, HOUR }

class _ClockBodyState extends State<ClockBody> {
  double secAngle = 0;
  double minAngle = 0;
  double hourAngle = 0;
  late Timer _secTimer;
  late Timer _minTimer;
  late Timer _hourTimer;

  void addTime(Time time, Duration dur) {
    switch (time) {
      case Time.SEC:
        _secTimer = Timer.periodic(dur, (timer) {
          setState.call(() => secAngle += (math.pi / 6) / 5);
        });
        break;
      case Time.MIN:
        _minTimer = Timer.periodic(dur, (timer) {
          setState.call(() => minAngle += (math.pi / 6) / 5);
        });
        break;
      case Time.HOUR:
        _hourTimer = Timer.periodic(dur, (timer) {
          setState.call(() => hourAngle += math.pi / 6);
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    addTime(Time.SEC, Duration(seconds: 1));
    addTime(Time.MIN, Duration(minutes: 1));
    addTime(Time.HOUR, Duration(hours: 1));
  }

  @override
  void dispose() {
    _secTimer.cancel();
    _minTimer.cancel();
    _hourTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClockNumberedBackground(),
                getClockAxis(Time.SEC, 400, 5),
                getClockAxis(Time.MIN, 350, 10),
                getClockAxis(Time.HOUR, 200, 20),
                getCenterCircle()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getCenterCircle() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget getClockAxis(Time time, double height, double thickness) {
    double _angle = time == Time.SEC
        ? secAngle
        : time == Time.MIN
            ? minAngle
            : hourAngle;
    return Transform.rotate(
      angle: _angle,
      child: SizedBox(
        height: height,
        width: thickness,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class ClockNumberedBackground extends StatelessWidget {
  const ClockNumberedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 500,
      width: 500,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2)),
      alignment: Alignment.center,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            getNumberLine(),
            getNumberLine(vertical: false),
            getOtherNumber(math.pi / 6),
            getOtherNumber(math.pi / 3),
            getOtherNumber(math.pi - (math.pi / 6)),
            getOtherNumber(math.pi - (math.pi / 3)),
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(((math.pi / 6) / 5) * i,
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber((math.pi / 6) + (((math.pi / 6) / 5) * i),
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber((math.pi / 3) + (((math.pi / 6) / 5) * i),
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-(((math.pi / 6) / 5) * i),
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-((math.pi / 6) + (((math.pi / 6) / 5) * i)),
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
            ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-((math.pi / 3) + (((math.pi / 6) / 5) * i)),
                    thickness: 2, height: 10, clr: Colors.grey)
            ],
          ],
        ),
      ),
    );
  }

  Widget getOtherNumber(double angle,
      {double? thickness, double? height, Color? clr}) {
    final Widget _line = Container(
        height: height ?? 20,
        width: thickness ?? 10,
        color: clr ?? Colors.black87);
    return Transform.rotate(
      angle: angle,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [_line, Spacer(), _line],
        ),
      ),
    );
  }

  Widget getNumberLine({bool vertical = true}) {
    final TextStyle _style =
        TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
    return vertical
        ? Column(
            children: [
              Text('12', style: _style),
              Spacer(),
              Text('06', style: _style),
            ],
          )
        : Row(
            children: [
              Text('09', style: _style),
              Spacer(),
              Text('03', style: _style),
            ],
          );
  }
}
