import 'package:divice/business/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<DeviceBloc, DeviceState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 23, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 41),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Device List',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 21),
                    Column(
                      children: state.list
                          .map((e) => ListBody(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: ExpansionTile(
                                        iconColor: Colors.black,
                                        title: Text(
                                          e.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text('5 models',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                    color: Color(0xFF9B9B9B))),
                                            Divider(color: Colors.black),
                                          ],
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
                                            child: ExpansionTile(
                                              expandedCrossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              title: const Text(
                                                'Model 2021',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    '3 item',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFF9B9B9B)),
                                                  ),
                                                  Divider(color: Colors.black),
                                                ],
                                              ),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const ListTile(
                                                          title:
                                                              Text('Item 01')),
                                                      const ListTile(
                                                          title:
                                                              Text('Item 02')),
                                                      const ListTile(
                                                          title:
                                                              Text('Item 03')),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFF1BD15D)),
                                                            onPressed: () =>
                                                                print('object'),
                                                            child: const Text(
                                                                'Thêm mới')),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xFF1BD15D)),
                                                      onPressed: () =>
                                                          print('object2'),
                                                      child: const Text(
                                                          'Thêm mới')),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14)
                                ],
                              ))
                          .toList(),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFF1BD15D),
                        ),
                        child: const Text('Thêm mới',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
