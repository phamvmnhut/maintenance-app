import 'package:flutter/material.dart';

///Banner
Widget buildBannerPage() {
  return Padding(
    padding: const EdgeInsets.only(left: 28, top: 20),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                    ),
                    Text(
                      'Kathryn',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 28),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 319,
                  height: 180,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 246, 200, 1),
                      borderRadius: BorderRadius.circular(28)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 88,
                          height: 48,
                          child: Text(
                            'Your plan for today',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '1 of 4 completed',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 31),
                          child: Text(
                            'Show More',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color.fromRGBO(236, 118, 105, 1)),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 3),
                            width: 66,
                            height: 2,
                            color: Color.fromRGBO(236, 118, 105, 1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assest/home1.png'),
          ],
        ),
      ],
    ),
  );
}
