import 'package:flutter/material.dart';
import 'banner_page_view.dart';
import 'buildBottomNavigationBar.dart';
import 'daily_review.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              )
            ],
          ),
          bottomNavigationBar: buildBottomNavigationBar(),
        ),
      ),
    );
  }
}

///Icon thông báo
Widget buildNotifyIconButton() {
  return Padding(
    padding: const EdgeInsets.only(top: 26, left: 292),
    child: Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(248, 248, 246, 1),
          borderRadius: BorderRadius.circular(14)),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_active_outlined,
        ),
        color: Colors.black,
      ),
    ),
  );
}

class DisableGlowListViewWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
