import 'package:flutter/material.dart';

Widget buildDailyReview() {
  return Padding(
    padding: const EdgeInsets.only(left: 28, right: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Daily Review',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        dailyReview(
            const Text(
              'Bảo hành màn hình',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            const Text(
              '10:00 AM',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            ),
            const Text(
              'Before Eating',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            )),
        dailyReview(
            const Text(
              'Naloxone',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            const Text(
              '10:00 AM',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            ),
            const Text(
              'Before Eating',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            )),
        dailyReview(
            const Text(
              'Oxycodone',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            const Text(
              '10:00 AM',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            ),
            const Text(
              'Before Eating',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            )),
        dailyReview(
            const Text(
              'Oxycodone',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            const Text(
              '10:00 AM',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            ),
            const Text(
              'Before Eating',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: Color.fromRGBO(155, 155, 155, 1),
              ),
            )),
      ],
    ),
  );
}

Widget dailyReview(Text text1, Text text2, Text text3) {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color.fromARGB(255, 248, 248, 246)),
    width: 319,
    height: 72,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28, right: 16),
          child: Image.asset('assets/images/drugs.png'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 14), child: text1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text2,
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromRGBO(155, 155, 155, 1),
                  ),
                  width: 4,
                  height: 4,
                ),
                text3
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 31),
          child: Icon(Icons.keyboard_arrow_right),
        )
      ],
    ),
  );
}
