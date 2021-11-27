// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

enum Time { SEC, HOUR, MIN }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black54,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double secAngle = 0;
  double minAngle = 0;
  double harAngle = 0;
  late Timer _seTimer;
  late Timer _miTimer;
  late Timer _haTimer;

  addTime(Duration dur, Time time) {
    if (time == Time.SEC) {
      _seTimer = Timer.periodic(dur, (timer) {
        setState(() {
          secAngle += ((math.pi / 6) / 5);
        });
      });
    } else if (time == Time.MIN) {
      _miTimer = Timer.periodic(dur, (timer) {
        setState(() {
          minAngle += ((math.pi / 6) / 5);
        });
      });
    } else {
      _haTimer = Timer.periodic(dur, (timer) {
        setState(() {
          harAngle += (math.pi / 6);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    addTime(Duration(seconds: 1), Time.SEC);
    addTime(Duration(minutes: 1), Time.MIN);
    addTime(Duration(hours: 1), Time.HOUR);
  }

  @override
  void dispose() {
    _seTimer.cancel();
    _miTimer.cancel();
    _haTimer.cancel();
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
                getSecAxisBox(Time.SEC),
                getMinAxisBox(Time.MIN),
                getHaAxisBox(Time.HOUR),
                centerDot(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getSecAxisBox(Time time) {
    return Transform.rotate(
      angle: secAngle,
      child: Container(
        height: 400,
        width: 5,
        child: Column(
          children: [
            Expanded(
              child: Container(
                //          height: 300,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget getMinAxisBox(Time time) {
    return Transform.rotate(
      angle: minAngle,
      child: SizedBox(
        height: 350,
        width: 10,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget getHaAxisBox(Time time) {
    return Transform.rotate(
      angle: harAngle,
      child: SizedBox(
        height: 200,
        width: 20,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.black),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget centerDot() {
    return   Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );
  }
}

class ClockNumberedBackground extends StatelessWidget {
  const ClockNumberedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 500,
      width: 500,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.white,
          shape: BoxShape.circle),
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
                getOtherNumber(((((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ],...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(((math.pi / 6) + (((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ],...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(((math.pi / 3) + (((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ], ...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-((((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ],...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-((math.pi / 6) + (((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ],...[
              for (int i = 1; i < 5; i++)
                getOtherNumber(-((math.pi / 3) + (((math.pi / 6) / 5) * i))  , 
                thickness: 2, ht: 10 ,clr: Colors.grey)
            ]
          ],
        ),
      ),
    );
  }

  Widget getOtherNumber(double angle, {double? thickness,double? ht, Color? clr}) {
    final Widget _line =
        Container(height: ht ?? 20, width: thickness ?? 10, color: clr ?? Colors.black87);
    return Transform.rotate(
      angle: angle,
      child: Container(
          alignment: Alignment.center,
          child: Column(children: [_line, Spacer(), _line])),
    );
  }

  Widget getNumberLine({vertical = true}) {
    final TextStyle _style =
        TextStyle(fontSize: 34, fontWeight: FontWeight.bold);
    return vertical
        ? Column(children: [
            Text("12", style: _style),
            Spacer(),
            Text("06", style: _style)
          ])
        : Row(children: [
            Text("09", style: _style),
            Spacer(),
            Text("03", style: _style)
          ]);
  }
}
