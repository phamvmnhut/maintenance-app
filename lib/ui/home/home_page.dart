import 'package:divice/ui/components/care_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../business/auth.dart';
import '../../business/care.dart';
import '../components/disable_glow_listview_widget.dart';
import 'package:divice/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    context.read<CareBloc>().add(CareEventSetup());
    super.didChangeDependencies();
  }

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Notify Icon
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
                    color: Theme.of(context).cardColor,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner PageView
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
                                              children: [
                                                Text(
                                                  S.of(context).hello,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 28),
                                                ),
                                                BlocBuilder<AuthBloc,
                                                    AuthState>(
                                                  builder: (context, state) =>
                                                      Text(
                                                    state.userName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 28),
                                                  ),
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
                                                      CrossAxisAlignment.start,
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
                                                      padding: EdgeInsets.only(
                                                          top: 2),
                                                      child: Text(
                                                        '1 of 4 completed',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11,
                                                          color: Color.fromRGBO(
                                                              0, 0, 0, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 31),
                                                      child: Text(
                                                        'Show More',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13,
                                                          color: Color.fromRGBO(
                                                              236, 118, 105, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 3,
                                                      ),
                                                      width: 66,
                                                      height: 2,
                                                      color:
                                                          const Color.fromRGBO(
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/images/home1.png'),
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
                    // Daily review
                    Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: Text(
                        S.of(context).care_as_soon,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    BlocBuilder<CareBloc, CareState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: state.careSoonList
                              .take(4)
                              .map((e) => CareCard(e: e))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
      //bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}
