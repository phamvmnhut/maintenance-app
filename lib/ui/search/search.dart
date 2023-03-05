import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final fieldText = TextEditingController();
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
                      color: Color(0xFFF8F8F6),
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
                                  icon: Icon(Icons.close))
                              : null),
                      onTap: () {
                        setState(() {
                          _isTapped = true;
                        });
                      },
                      onSubmitted: (value) {
                        _isTapped = false;
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
                      color: Color(0xF5F8FFFF),
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
                  'Your device care',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              right: 28,
              left: 28,
            ),
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFFF8F8F6),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Image.asset('assets/images/drugs.png'),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Oxycodone',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Text(
                              '${DateFormat('hh:mm a').format(DateTime.now())}',
                              style: const TextStyle(
                                  color: Color.fromARGB(155, 155, 155, 1),
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
                                        const Color.fromARGB(155, 155, 155, 1),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 4,
                                width: 4,
                              ),
                            ),
                            const Text(
                              'Completed',
                              style: TextStyle(
                                  color: Color.fromARGB(155, 155, 155, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(child: Icon(Icons.keyboard_arrow_right)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              margin: const EdgeInsets.only(
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
                    child: Image.asset('assets/images/drugs.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'Naloxone',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Text(
                                '${DateFormat('hh:mm a').format(DateTime.now())}',
                                style: TextStyle(
                                    color: Color.fromARGB(155, 155, 155, 1),
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
                                      color: const Color.fromARGB(
                                          155, 155, 155, 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 4,
                                  width: 4,
                                ),
                              ),
                              const Text(
                                'Skipped',
                                style: TextStyle(
                                    color: Color.fromARGB(155, 155, 155, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              margin: const EdgeInsets.only(
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
                    child: Image.asset('assets/images/drugs.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            'Oxycodone',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(DateTime.now()),
                                style: const TextStyle(
                                    color: Color.fromARGB(155, 155, 155, 1),
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
                                      color: const Color.fromARGB(
                                          155, 155, 155, 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 4,
                                  width: 4,
                                ),
                              ),
                              const Text(
                                'Before Eating',
                                style: TextStyle(
                                    color: Color.fromARGB(155, 155, 155, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: Icon(Icons.keyboard_arrow_right)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
