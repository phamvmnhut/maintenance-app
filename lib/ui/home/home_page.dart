import 'package:flutter/material.dart';
import 'banner_page_view.dart';
import 'daily_review.dart';
import 'bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            buildNotifyIconButton(),
            Expanded(
              child: ScrollConfiguration(
                behavior: DisableGlowListViewWidget(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildPageView(),
                      buildDailyReview(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //bottomNavigationBar: buildBottomNavigationBar(),
      )),
    );
  }
}

Widget buildNotifyIconButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 26, right: 35),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(248, 248, 246, 1),
            borderRadius: BorderRadius.circular(14)),
        child: const Icon(
          Icons.notifications_active_outlined,
        ),
      ),
    ],
  );
}

class DisableGlowListViewWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
