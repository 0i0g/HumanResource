import 'package:Mobile/src/ui/components/existable.dart';

import 'package:Mobile/src/ui/main/home_page/home_page.dart';
import 'package:Mobile/src/ui/main/profile_page/profile_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'check_in_out_page.dart/checkinout_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final _pages = [HomePage(), Checkin(), ProfilePage()];
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Exitable.onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            children: _pages,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
              ),
              label: "Checkin",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(_currentIndex,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            });
          },
        ),
      ),
    );
  }
}
