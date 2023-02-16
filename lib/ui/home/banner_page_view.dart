import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'banner.dart';

///Banner PageView
Widget buildPageView() {
  final controller = PageController();
  return Container(
    child: Column(
      children: [
        SizedBox(
          width: 377,
          height: 292,
          child: PageView(
            controller: controller,
            children: [
              buildBannerPage(),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.green,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: SwapEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Color.fromRGBO(27, 209, 93, 1),
                dotColor: Color.fromRGBO(217, 217, 217, 1)),
          ),
        )
      ],
    ),
  );
}
