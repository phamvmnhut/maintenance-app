import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../business/care.dart';
import '../../domain/repositories/firebase/equipment_repository_firebase.dart';
import '../care/care_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController();

  Future<String> getData(String id) {
    return RepositoryProvider.of<EquipmentRepositoryFirebase>(context)
        .get(id: id)
        .then((value) => value.name);
  }

  @override
  Widget build(BuildContext context) {
    DateTime _nowTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CareBloc, CareState>(
          builder: (context, state) => Column(
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
                    child: Column(children: [
                      /// Banner PageView
                      Column(
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
                                                    color: const Color.fromRGBO(
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
                                                      const EdgeInsets.all(24),
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
                                                                FontWeight.w600,
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
                                                                FontWeight.w400,
                                                            fontSize: 11,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
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
                                                                FontWeight.w600,
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromRGBO(
                                                                    236,
                                                                    118,
                                                                    105,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
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

                      ///Daily review
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 28),
                            child: Text(
                              'Daily Review',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          state.isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: state.careList
                                      .take(3)
                                      .map(
                                        (e) => InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              CareDetailPage.route(
                                                  care_id: e.id),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                              top: 12,
                                              right: 28,
                                              left: 28,
                                            ),
                                            height: 72,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              color: const Color(0xFFF8F8F6),
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 28),
                                                  child: Image.asset(
                                                      'assets/images/drugs.png'),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16,
                                                                bottom: 3),
                                                        child: Text(
                                                          e.memo_name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 16),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              e.start_date
                                                                          .difference(
                                                                              _nowTime)
                                                                          .inHours >
                                                                      24
                                                                  ? 'after ${e.start_date.difference(_nowTime).inDays} days'
                                                                  : 'after ${e.start_date.difference(_nowTime).inHours}h${e.start_date.difference(_nowTime).inMinutes}m',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          155,
                                                                          155,
                                                                          155,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 13),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 5,
                                                                right: 5,
                                                              ),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        155,
                                                                        155,
                                                                        155,
                                                                        1),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                height: 4,
                                                                width: 4,
                                                              ),
                                                            ),
                                                            FutureBuilder(
                                                                future: getData(e
                                                                    .equipment_id),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .done) {
                                                                    return Text(
                                                                      snapshot
                                                                          .data!,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              155,
                                                                              155,
                                                                              155,
                                                                              1),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              13),
                                                                    );
                                                                  }
                                                                  return const Text(
                                                                      '');
                                                                })
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Expanded(
                                                    child: Icon(Icons
                                                        .keyboard_arrow_right)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                        ],
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
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
