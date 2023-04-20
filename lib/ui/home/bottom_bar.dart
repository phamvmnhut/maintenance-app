import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/setting.dart';

class BottomNavigationBarCustomize extends StatefulWidget {
  const BottomNavigationBarCustomize({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarCustomize> createState() =>
      _BottomNavigationBarCustomizeState();
}

class _BottomNavigationBarCustomizeState extends State<BottomNavigationBarCustomize> {
  int selectedIndex = 0;
  final List<BottomNavigationBarItem> _bottomColor = [
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Color.fromRGBO(27, 209, 93, 1).withOpacity(0.07),
            ),
            child: Image.asset('assets/bottom_bar/color/home_page.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(27, 209, 93, 1).withOpacity(0.07)),
            child: Image.asset('assets/bottom_bar/color/search.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Color.fromRGBO(27, 209, 93, 1),
            ),
            child: Image.asset('assets/bottom_bar/no_color/add.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(27, 209, 93, 1).withOpacity(0.07)),
            child: Image.asset('assets/bottom_bar/color/list.png')),
        label: ''),
    BottomNavigationBarItem(
        icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(27, 209, 93, 1).withOpacity(0.07)),
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
              color: Color.fromRGBO(27, 209, 93, 1),
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
              color: Color.fromRGBO(27, 209, 93, 1).withOpacity(0.07),
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
              color: Color.fromRGBO(27, 209, 93, 1),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        items: _bottomList,
        onTap: (value) {
          BlocProvider.of<ThemeBloc>(context)
              .add(ChangeScreenEvent(index: value));
          setState(() {
            selectedIndex = value;
            for (int i = 0; i < _bottomList.length; i++) {
              if (i == selectedIndex) {
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
