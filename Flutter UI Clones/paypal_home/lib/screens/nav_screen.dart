import 'package:flutter/material.dart';
import 'package:paypal_home/screens/home/home.dart';
import 'package:paypal_home/state/state_provider.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatelessWidget {
  NavScreen({Key? key}) : super(key: key);
  final _screens = [
    const HomeScreen(),
    Container(color: Colors.red, height: double.infinity, width: double.infinity),
    Container(color: Colors.amber, height: double.infinity, width: double.infinity)
  ];

  @override
  Widget build(BuildContext context) {
    final _stateProv = Provider.of<StateProvider>(context);
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: _screens[_stateProv.getScreenIndex],
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _stateProv = Provider.of<StateProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -0.2),
            color: Colors.grey,
            blurRadius: 2
          )
        ]
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) => _buildNavItem(index, _stateProv)),
      ),
    );
  }

  Widget _buildNavItem(int index, StateProvider stateProv) {
    final List<IconData> icons = [Icons.home, Icons.money, Icons.credit_card];
    final isSelected = stateProv.getScreenIndex == index;
    return GestureDetector(
      onTap: () {
        stateProv.setScreenIndex = index;
      },
      child: Icon(icons[index],
          color: isSelected ? Colors.blue[600] : Colors.indigo[900]),
    );
  }
}
