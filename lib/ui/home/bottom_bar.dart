// ignore_for_file: deprecated_member_use

import 'package:maintenance/config/color.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarCustomize extends StatefulWidget {
  const BottomNavigationBarCustomize(
      {Key? key, required this.indexScreen, required this.switchScreen})
      : super(key: key);
  final int indexScreen;
  final Function switchScreen;
  @override
  State<BottomNavigationBarCustomize> createState() =>
      _BottomNavigationBarCustomizeState();
}

class _BottomNavigationBarCustomizeState
    extends State<BottomNavigationBarCustomize> {
  final List<BottomNavigationBarItem> _bottomColor = [
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.greenColor.withOpacity(0.07),
            ),
            child: Image.asset('assets/bottom_bar/color/home_page.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.greenColor.withOpacity(0.07)),
            child: Image.asset('assets/bottom_bar/color/search.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.greenColor,
            ),
            child: Image.asset('assets/bottom_bar/no_color/add.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.greenColor.withOpacity(0.07)),
            child: Image.asset('assets/bottom_bar/color/list.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.greenColor.withOpacity(0.07)),
            child: Image.asset('assets/bottom_bar/color/setting.png')),
        label: ''),
  ];
  final List<BottomNavigationBarItem> _bottomNoColor = [
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/home_page.png'),
        label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/search.png'), label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.greenColor,
            ),
            child: Image.asset('assets/bottom_bar/no_color/add.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/list.png'), label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/setting.png'), label: ''),
  ];
  final List<BottomNavigationBarItem> _bottomList = [
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.greenColor.withOpacity(0.07),
            ),
            child: Image.asset('assets/bottom_bar/color/home_page.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/search.png'), label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: AppColors.greenColor,
            ),
            child: Image.asset('assets/bottom_bar/no_color/add.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/list.png'), label: ''),
    BottomNavigationBarItem(
        icon: Image.asset('assets/bottom_bar/no_color/setting.png'), label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent, highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        type: BottomNavigationBarType.fixed,
        items: _bottomList,
        onTap: (value) {
          widget.switchScreen(value);
          setState(() {
            for (int i = 0; i < _bottomList.length; i++) {
              if (i == value) {
                _bottomList[i] = _bottomColor[i];
              } else {
                _bottomList[i] = _bottomNoColor[i];
              }
            }
          });
        },
      ),
    );
  }
}
