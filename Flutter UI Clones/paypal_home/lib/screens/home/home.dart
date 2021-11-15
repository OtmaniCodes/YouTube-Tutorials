// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:paypal_home/screens/home/widgets/slidable_cards.dart';

enum PaypalSection { payments, recentActivity }

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Hi there!\nHere\'s what\'s new',
                style: TextStyle(color: Colors.black, fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SlidableCards(),
            const SizedBox(height: 10),
            _getBalanceCard(context),
            const SizedBox(height: 10),
            _getPaypalSection(context, PaypalSection.payments),
            const SizedBox(height: 10),
            _getPaypalSection(context, PaypalSection.recentActivity),
            const SizedBox(height: 10),
            _getTourCard(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _getTourCard() {
    return Container(
      height: 180,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange[400],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/paint.png')
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0.3),
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Find what you\'re lloking for\nin the new PayPal app",
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            Text(
              "Take the tour",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontFamily: 'boldPoppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPaypalSection(BuildContext context, PaypalSection section) {
    String title;
    String header;
    String caption;
    String icon;
    String buttonText;
    switch (section) {
      case PaypalSection.payments:
        title = "Send Payments";
        icon = "assets/images/send.png";
        header = "Pay From Your Phone";
        caption = "For the things you love";
        buttonText = "Send now";
        break;
      case PaypalSection.recentActivity:
        title = "Recent activity";
        icon = "assets/images/card.png";
        header = "Keep track easily";
        caption = "New transactions will pop up here";
        buttonText = "Show all";
        break;
    }
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'medPoppins',
                fontSize: 20,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFFCCCCCC),
              backgroundImage: AssetImage(icon),
            ),
            title: Text(
              header,
              style: TextStyle(
                fontFamily: 'boldPoppins',
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              caption,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.blueAccent,
                fontFamily: 'medPoppins',
                fontSize: 19,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _getBalanceCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(-0.05, -0.1), color: Colors.grey, blurRadius: 2),
            BoxShadow(
                offset: Offset(0.05, 0.2), color: Colors.grey, blurRadius: 3)
          ]),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFCCCCCC),
          backgroundImage: AssetImage('assets/images/paypal.png'),
        ),
        title: Text(
          "0.00 USD",
          style: TextStyle(
            fontFamily: 'boldPoppins',
            fontSize: 26,
          ),
        ),
        subtitle:
            Text("Paypal balance", style: Theme.of(context).textTheme.caption),
      ),
    );
  }
}
