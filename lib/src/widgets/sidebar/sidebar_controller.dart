import 'package:flutter/material.dart';

class SidebarController extends ChangeNotifier {
  SidebarController({
    required int selectedIndex,
  }) : _selectedIndex = selectedIndex;

  int _selectedIndex;

  int get selectedIndex => _selectedIndex;
  void selectIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}
