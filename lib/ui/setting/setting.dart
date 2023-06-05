// ignore_for_file: deprecated_member_use

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maintenance/business/auth.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:maintenance/ui/auth/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/setting.dart';
import '../../domain/services/admod.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  BannerAd? bannerAd;

  _createBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdModService.bannerAdUnitId!,
      listener: AdModService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bannerAd == null
            ? Container()
            : Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                child: AdWidget(ad: bannerAd!),
              ),
        backgroundColor: Theme.of(context).canvasColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 32, right: 32, bottom: 8),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) => Row(
                      children: [
                        SizedBox(
                          width: 53,
                          height: 53,
                          child: CircleAvatar(
                            maxRadius: 60,
                            backgroundImage: NetworkImage(
                              state.user?.photoURL ?? placeholderImage,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.userName,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(S.of(context).user_intro),
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
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfilePage()));
                },
              ),
              const SizedBox(
                height: 32,
              ),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.ac_unit,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                                child: Text(
                              S.of(context).language,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                            Text(state.local.toString()),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: AppColors.grayColor,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            List<Locale> listLocale =
                                S.delegate.supportedLocales;
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Container(
                                color: Theme.of(context).canvasColor,
                                alignment: Alignment.topCenter,
                                height: 160,
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
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
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
              const SizedBox(
                height: 32,
              ),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ac_unit,
                        size: 16,
                      ),
                      const SizedBox(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Divider(),
              ),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ac_unit,
                        size: 16,
                      ),
                      const SizedBox(
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
              const SizedBox(
                height: 32,
              ),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ac_unit,
                        size: 16,
                      ),
                      const SizedBox(
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
      ),
    );
  }
}
