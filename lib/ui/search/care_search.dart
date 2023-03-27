import 'dart:async';

import 'package:divice/business/care.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/firebase/equipment_repository_firebase.dart';
import '../care/care_detail.dart';

class CareSearch extends StatefulWidget {
  const CareSearch({Key? key}) : super(key: key);

  @override
  State<CareSearch> createState() => _CareSearchState();
}

class _CareSearchState extends State<CareSearch> {
  final fieldText = TextEditingController();
  var _isTapped = false;
  Timer? _timer;
  DateTime _nowTime = DateTime.now();

  @override
  void didChangeDependencies() {
    context.read<CareBloc>().add(CareEventGetAllData());
    super.didChangeDependencies();
  }

  Future<String> getData(String id) {
    return RepositoryProvider.of<EquipmentRepositoryFirebase>(context)
        .get(id: id)
        .then((value) => value.name);
  }

  void timeText() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(seconds: 2), () {
      context.read<CareBloc>().add(CareEventGetAllData());
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CareBloc, CareState>(
        builder: (context, state) => SingleChildScrollView(
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
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xFFF8F8F6),
                      ),
                      child: TextField(
                        controller: fieldText,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Image.asset('assets/images/search.png'),
                            hintText: 'Search',
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
                        color: const Color(0xF5F8FFFF),
                      ),
                      child: Image.asset('assets/images/menu.png'),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    top: 51,
                    left: 32,
                  ),
                  child: Text(
                    'Your device care',
                    style: TextStyle(
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
                        .where((element) => element.memo_name
                            .toLowerCase()
                            .contains(fieldText.text.toLowerCase()))
                        .map(
                          (e) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                CareDetailPage.route(care_id: e.id),
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
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0xFFF8F8F6),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28),
                                    child:
                                        Image.asset('assets/images/drugs.png'),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, bottom: 3),
                                          child: Text(
                                            e.memo_name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Row(
                                            children: [
                                              Text(
                                                e.start_date
                                                            .difference(
                                                                _nowTime)
                                                            .inHours >
                                                        24
                                                    ? 'after ${e.start_date.difference(_nowTime).inDays} days'
                                                    : 'after ${e.start_date.difference(_nowTime).inHours}h${e.start_date.difference(_nowTime).inMinutes}',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        155, 155, 155, 1),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              155, 155, 155, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: 4,
                                                  width: 4,
                                                ),
                                              ),
                                              FutureBuilder(
                                                  future:
                                                      getData(e.equipment_id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.done) {
                                                      return Text(
                                                        snapshot.data!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    155,
                                                                    155,
                                                                    155,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 13),
                                                      );
                                                    }
                                                    return const Text('');
                                                  })
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                      child: Icon(Icons.keyboard_arrow_right)),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ]),
        ),
      ),
    );
  }
}
