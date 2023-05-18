import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maintenance/business/care.dart';
import 'package:maintenance/generated/l10n.dart';
import '../components/care_card.dart';

class CareSearch extends StatefulWidget {
  const CareSearch({Key? key}) : super(key: key);

  @override
  State<CareSearch> createState() => _CareSearchState();
}

class _CareSearchState extends State<CareSearch> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocBuilder<CareBloc, CareState>(
        builder: (context, state) => SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 70,
                left: 32,
                right: 32,
              ),
              child: Row(
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
                            suffixIcon: _isTapped
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fieldText.clear();
                                        _isTapped = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close))
                                : null),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 51,
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
              ],
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
                        .take(limit)
                        .map((e) => CareCard(e: e))
                        .toList(),
                  ),
          ]),
        ),
      ),
    );
  }
}
