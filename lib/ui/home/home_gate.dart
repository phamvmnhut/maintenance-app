import 'package:flutter/material.dart';

import '../device/list_device/device.dart';
import '../device/new_care/add_new_care_ui.dart';
import '../search/care_search.dart';
import '../setting/setting.dart';
import 'bottom_bar.dart';
import 'home_page.dart';

class HomeGate extends StatefulWidget {
  const HomeGate({Key? key}) : super(key: key);

  @override
  State<HomeGate> createState() => _HomeGateState();
}

class _HomeGateState extends State<HomeGate> {
  final screens = [
    const HomePage(),
    const CareSearch(),
    const AddNewCare(),
    const DevicePage(),
    const SettingPage()
  ];

  int indexScreen = 0;

  void switchScreen(int newIndex) {
    setState(() {
      indexScreen = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indexScreen,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBarCustomize(
        indexScreen: indexScreen,
        switchScreen: switchScreen,
      ),
    );
  }
}
