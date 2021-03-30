import 'package:flutter/material.dart';
import 'package:order_device/pages/index_page/home.dart';
import 'package:order_device/pages/index_page/index.dart';
import 'package:order_device/pages/user/user.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _children = [HomePage(), IndexPage(), UserPage()];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: '首页',
            icon: Icon(Icons.account_balance),
          ),
          BottomNavigationBarItem(
            label: '订单',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: '我的',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
