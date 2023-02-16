import 'package:flutter/material.dart';

///Banner
Widget buildBannerPage() {
  return Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 28),
            child: SizedBox(
              width: 108,
              height: 76,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                  Text(
                    'Kathryn',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28, top: 16, right: 28),
            child: Container(
              width: 319,
              height: 180,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 246, 200, 1),
                  borderRadius: BorderRadius.circular(28)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 24),
                    child: SizedBox(
                      width: 88,
                      height: 48,
                      child: Text(
                        'Your plan for today',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 24),
                    child: SizedBox(
                      width: 90,
                      height: 24,
                      child: Text(
                        '1 of 4 completed',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 31, left: 24),
                    child: SizedBox(
                      width: 73,
                      height: 24,
                      child: Text(
                        'Show More',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color.fromRGBO(236, 118, 105, 1)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Container(
                        width: 65,
                        height: 1.5,
                        color: Color.fromRGBO(236, 118, 105, 1)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 157, top: 20),
        child: SizedBox(
            width: 251,
            height: 248,
            child: Positioned(child: Image.asset('assest/home1.png'))),
      )
    ],
  );
}
