import 'package:flutter/material.dart';

class SlidableCards extends StatelessWidget {
  const SlidableCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          4,
          (index) => _buildCard(index),
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    final List<Color?> colors = [
      Colors.indigo[900],
      Colors.indigo[900],
      Colors.purple,
      Colors.indigo[900]
    ];
    final List<String> images = [
      "assets/images/glob.png",
      "assets/images/paid.png",
      "assets/images/credit.png",
      "assets/images/pay.png"
    ];
    final List<String> headers = [
      "Extend the reach of your business",
      "Get Paid",
      "Add a card to shop the world",
      "Pay someone"
    ];
    final List<String> captions = [
      "Upgrade your account to get paid by customers globally",
      "Get paid for selling something or for work you did",
      "Buy with confidence with your card info secure",
      "Pay for things that you bought or a service you received"
    ];
    final List<String> buttonText = [
      "Upgrade to Get paid",
      "Request Money",
      "Add to Your Wallet",
      "Send Money"
    ];
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colors[index],
        boxShadow: [
          BoxShadow(offset: Offset(0, 0.3), color: Colors.grey, blurRadius: 3)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(images[index], height: 200),
            const SizedBox(height: 15),
            Text(
              headers[index],
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'boldPoppins',
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              captions[index],
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'medPoppins',
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                print('item number $index is tapped');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  buttonText[index],
                  style: TextStyle(
                    fontFamily: 'medPoppins',
                    color: Colors.indigo[900]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
