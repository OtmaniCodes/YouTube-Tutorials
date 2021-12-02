import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "tesla landing page app",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<CarTab> carTabs = [
    CarTab("assets/images/car1.jpg", "Model 1"),
    CarTab("assets/images/car2.jpg", "Model 2"),
    CarTab("assets/images/car3.jpg", "Model 3"),
    CarTab("assets/images/car4.jpg", "Model 4"),
  ];
  int currentPageIndex = 0;
  double _opacity = 1;
  double _position = 0;

  resetOpacity() async {
    await Future.delayed(Duration(microseconds: 200), () {
      setState(() => _opacity = 1);
    });
  }

  returnPosition() async {
    setState(() {
      _position = 10;
    });
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() => _position = 0);
    });
  }

  startIconAnimation() async {
    while (true) {
      returnPosition();
      await Future.delayed(Duration(milliseconds: 600));
    }
  }

  @override
  void initState() {
    super.initState();
    startIconAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "tesla".toUpperCase(),
          style:
              TextStyle(color: Colors.white, letterSpacing: 8.0, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[400]!.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.0)
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            onPageChanged: (val) {
              setState(() {
                currentPageIndex = val;
                _opacity = 0;
                resetOpacity();
              });
            },
            itemCount: carTabs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(carTabs[index].image!),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: _opacity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        carTabs[currentPageIndex].title!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 5.0),
                      ),
                      Text(
                        "Order Online for Touchless Delivery",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.0),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "custom order".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "existing inventory".toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  currentPageIndex == 0
                      ? Container(
                          width: 50.0,
                          height: 50.0,
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                top: _position,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                                curve: Curves.bounceOut,
                                duration: Duration(milliseconds: 400),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: 60.0),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CarTab {
  final String? image;
  final String? title;

  CarTab(this.image, this.title);
}
