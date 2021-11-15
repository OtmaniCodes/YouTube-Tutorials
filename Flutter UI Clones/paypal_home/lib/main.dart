import 'package:flutter/material.dart';
import 'package:paypal_home/screens/nav_screen.dart';
import 'package:paypal_home/state/state_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StateProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "regPoppins",
          scaffoldBackgroundColor: const Color(0xFFF0FFF0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent
          )
        ),
        home: NavScreen()
      ),
    );
  }
}