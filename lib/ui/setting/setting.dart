import 'package:divice/config/color.dart';
import 'package:divice/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/setting.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 32, right: 32, bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 53,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.amberAccent,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Pham Nhut", style: Theme.of(context).textTheme.headline6,),
                          Text("id, media and shopping"),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: AppColors.grayColor,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 32,
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12,),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.ac_unit,
                            size: 16,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(child: Text(S.of(context).language, style: Theme.of(context).textTheme.bodyMedium,)),
                          Text("${state.local.toString()}"),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: AppColors.grayColor,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            List<Locale> listLocale =
                                S.delegate.supportedLocales;
                            return Container(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(listLocale[index].toString()),
                                    onTap: () {
                                      BlocProvider.of<ThemeBloc>(context).add(
                                          ChangeLocaleEvent(
                                              lo: listLocale[index]));
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                itemCount: listLocale.length,
                              ),
                            );
                          });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(S.of(context).dark_mode),
                        ),
                        Switch(
                          value: state.isDarkModeEnabled,
                          onChanged: (_) {
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ToggleThemeEvent());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.ac_unit,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: Text(S.of(context).notification)),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: AppColors.grayColor,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Divider(),
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.ac_unit,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: Text(S.of(context).general)),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: AppColors.grayColor,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 32,
            ),
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.ac_unit,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(child: Text(S.of(context).privacy_policy)),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: AppColors.grayColor,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
