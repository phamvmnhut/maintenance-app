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
  List<String> memoNames = [];
  List<String> memoNamesSearch = [];
  final fieldText = TextEditingController();
  bool _isTapped = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                                      fieldText.clear();
                                    },
                                    icon: const Icon(Icons.close))
                                : null),
                        onTap: () {
                          setState(() {
                            _isTapped = true;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            memoNames =
                                state.careList.map((e) => e.memo_name).toList();
                            memoNamesSearch = memoNames
                                .where((e) => e
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _isTapped = false;
                          });
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
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: Text(
                                            e.memo_name,
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
                                                e.start_date.toString(),
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
                                                    return CircularProgressIndicator();
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
