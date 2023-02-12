import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 26, right: 35),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey[100],
                      ),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.notification_add)),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 28, top: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 38,
                          child: Text(
                            'Hello,',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 28),
                          ),
                        ),
                        SizedBox(
                          height: 38,
                          child: Text(
                            'Kathryn',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 28),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Container(
                            width: 319,
                            height: 180,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 246, 200, 1),
                                borderRadius: BorderRadius.circular(28)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 24, left: 24),
                                    child: SizedBox(
                                      width: 88,
                                      height: 48,
                                      child: Text(
                                        'Your plan for today',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  height: 24,
                                  child: Text(
                                    '1 of 4 completed',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Image.asset('assest/home1.png'),
                      right: 0,
                      top: 0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
