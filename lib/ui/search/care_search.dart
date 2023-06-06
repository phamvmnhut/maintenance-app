import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:maintenance/business/care.dart';
import 'package:maintenance/domain/services/admod.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:maintenance/ui/components/disable_glow_listview_widget.dart';
import '../components/care_card.dart';

class CareSearch extends StatefulWidget {
  const CareSearch({Key? key}) : super(key: key);

  @override
  State<CareSearch> createState() => _CareSearchState();
}

class _CareSearchState extends State<CareSearch> {
  bool isShowSearchText = true;
  BannerAd? bannerAd;
  final fieldText = TextEditingController();
  bool _isTapped = false;
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  int limit = 10;

  void timeText() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 2), () {
      context.read<CareBloc>().add(CareEventSearch(name: fieldText.text));
    });
  }

  void checkEmpty() {
    if (fieldText.text.isNotEmpty) {
      _isTapped = true;
    } else {
      _isTapped = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          limit += 10;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isShowSearchText = false;
        });
      } else {
        setState(() {
          isShowSearchText = true;
        });
      }
    });
    _createBannerAd();
  }

  _createBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdModService.bannerAdUnitId!,
      listener: AdModService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bannerAd == null
          ? Container()
          : Container(
              height: 50,
              margin: const EdgeInsets.all(5),
              child: AdWidget(ad: bannerAd!),
            ),
      backgroundColor: Theme.of(context).canvasColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show refresh indicator programmatically on button tap.
          _refreshIndicatorKey.currentState?.show();
        },
        child: const Icon(Icons.refresh),
      ),
      body: BlocBuilder<CareBloc, CareState>(
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut, // Curve của animation
              child: Visibility(
                visible: isShowSearchText,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 32,
                  ),
                  child: Text(
                    S.of(context).your_device_care,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: isShowSearchText ? 10 : 50,
                left: 32,
                right: 32,
                bottom: 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Theme.of(context).cardColor,
                      ),
                      child: TextField(
                        controller: fieldText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Image.asset('assets/images/search.png'),
                            hintText: S.of(context).search_hint,
                            suffixIcon: Visibility(
                              visible: _isTapped,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      fieldText.clear();
                                      _isTapped = false;
                                    });
                                  },
                                  icon: const Icon(Icons.close)),
                            )),
                        onTap: () {
                          setState(() {
                            checkEmpty();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            checkEmpty();
                            timeText();
                          });
                        },
                        onSubmitted: (value) {
                          setState(
                            () {
                              _isTapped = false;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Image.asset('assets/images/menu.png'),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !state.isLoading,
              child: Expanded(
                child: ScrollConfiguration(
                  behavior: DisableGlowListViewWidget(),
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      context
                          .read<CareBloc>()
                          .add(CareEventSearch(name: fieldText.text));
                    },
                    child: ListView(
                        controller: _scrollController,
                        children: state.careList
                            .take(limit)
                            .map((e) => CareCard(e: e))
                            .toList()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
