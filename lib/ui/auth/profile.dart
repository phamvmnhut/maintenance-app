import 'package:divice/business/auth.dart';
import 'package:divice/config/color.dart';
import 'package:divice/generated/l10n.dart';
import 'package:divice/ui/auth/widgets/profile_update_username_bottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'auth.dart';

const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        User userState = authState.user!;
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 52),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 32),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.arrow_back_sharp,
                        size: 16.0,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Stack(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: NetworkImage(
                              userState.photoURL ?? placeholderImage,
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 0,
                            bottom: 0,
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(40),
                              child: InkWell(
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (file != null) {
                                    BlocProvider.of<AuthBloc>(context,
                                            listen: false)
                                        .add(
                                      AuthEventUpdateUser(imagePath: file.path),
                                    );
                                  }
                                },
                                radius: 50,
                                child: const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Icon(Icons.edit, size: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(authState.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            "Username",
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(height: 5),
                          Text(userState.email ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                color: AppColors.grayColor,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  unselectedLabelColor: AppColors.grayColor,
                  labelColor: AppColors.greenColor,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.person),
                    ),
                    Tab(
                      icon: Icon(Icons.shop),
                    ),
                    Tab(
                      icon: Icon(Icons.podcasts),
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            profileUpdateUsernameBottomSheet(
                                context, authState.userName);
                          },
                          child: Text(S.of(context).update_username),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthEventSentEmailVerify());
                          },
                          child: Text(S.of(context).verify_email),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context, listen: false)
                                .add(AuthEventLogout());
                            if (mounted) {
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => const AuthGate()),
                              //     (Route<dynamic> route) => false);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(S.of(context).logout),
                        ),
                      ],
                    ),
                    const Center(
                      child: Text("Coming soon"),
                    ),
                    const Center(
                      child: Text("Coming soon"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        // }
      }),
    );
  }
}
