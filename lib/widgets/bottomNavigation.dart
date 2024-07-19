import 'package:flutter/material.dart';
import 'package:uroutines/constants.dart';

import '../screens/addSessionScreen.dart';
import '../screens/classesScreen.dart';
import '../screens/homeScreen.dart';
import '../screens/registeredCourses.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selected = 0;
  Widget? _currentPage;
  HomeScreen _homeScreen = HomeScreen();
  ClassesScreen _classesScreen = ClassesScreen();
  AddSession _addModuleScreen = AddSession();
  RegisteredCourses registeredCourses = RegisteredCourses();
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _homeScreen = const HomeScreen();
    _classesScreen = const ClassesScreen();
    _addModuleScreen = const AddSession();
    registeredCourses = const RegisteredCourses();
    _pages = [_homeScreen, _classesScreen, _addModuleScreen, registeredCourses];
    _currentPage = _homeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          _currentPage!,
          _bottomNavigator(),
        ],
      ),
    );
  }

  _bottomNavigator() {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      left: 0.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.background,
            currentIndex: _selected,
            onTap: (int tab) {
              setState(() {
                _selected = tab;
                if (tab == 0 || tab == 1 || tab == 2 || tab == 3) {
                  _currentPage = _pages[tab];
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.home,
                  size: 30.0,
                  color: _selected == 0
                      ? Theme.of(context).colorScheme.secondary
                      : kTextColor,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.book,
                  size: 30.0,
                  color: _selected == 1
                      ? Theme.of(context).colorScheme.secondary
                      : kTextColor,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.read_more,
                  size: 30.0,
                  color: _selected == 2
                      ? Theme.of(context).colorScheme.secondary
                      : kTextColor,
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: Icon(
                  Icons.comment,
                  size: 30.0,
                  color: _selected == 3
                      ? Theme.of(context).colorScheme.secondary
                      : kTextColor,
                ),
              ),
            ]),
      ),
    );
  }
}
