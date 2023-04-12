import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController();

  /// Method daily review
  dailyReview(Text text1, Text text2, Text text3) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
      },
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            /// Notify Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 26,
                    right: 35,
                  ),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(248, 248, 246, 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: DisableGlowListViewWidget(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Banner PageView
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 377,
                              height: 292,
                              child: PageView(
                                controller: controller,
                                children: [
                                  /// Banner
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 28,
                                      top: 20,
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      'Hello,',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 28),
                                                    ),
                                                    Text(
                                                      'Kathryn',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 28),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 16),
                                                  width: 319,
                                                  height: 180,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                        243,
                                                        246,
                                                        200,
                                                        1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            24),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          width: 88,
                                                          height: 48,
                                                          child: Text(
                                                            'Your plan for today',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2),
                                                          child: Text(
                                                            '1 of 4 completed',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 11,
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                            ),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 31),
                                                          child: Text(
                                                            'Show More',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      236,
                                                                      118,
                                                                      105,
                                                                      1),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 3,
                                                          ),
                                                          width: 66,
                                                          height: 2,
                                                          color: const Color
                                                                  .fromRGBO(
                                                              236, 118, 105, 1),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                                'assets/images/home1.png'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: controller,
                              count: 3,
                              effect: const SwapEffect(
                                dotHeight: 11,
                                dotWidth: 11,
                                activeDotColor: Color.fromRGBO(27, 209, 93, 1),
                                dotColor: Color.fromRGBO(217, 217, 217, 1),
                              ),
                            )
                          ],
                        ),
                      ),

                      ///Daily review
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Daily Review',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            dailyReview(
                              const Text(
                                'Bảo hành màn hình',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
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
                              ),
                            ),
                            dailyReview(
                              const Text(
                                'Naloxone',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
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
                              ),
                            ),
                            dailyReview(
                              const Text(
                                'Oxycodone',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
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
                              ),
                            ),
                            dailyReview(
                              const Text(
                                'Oxycodone',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                ),
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        //bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }
}

class DisableGlowListViewWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
