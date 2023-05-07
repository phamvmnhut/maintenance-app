import 'package:divice/business/auth.dart';
import 'package:divice/business/care.dart';
import 'package:divice/business/device.dart';
import 'package:divice/business/setting.dart';
import 'package:divice/domain/repositories/firebase/care_history_repository_firebase.dart';
import 'package:divice/domain/repositories/firebase/care_repository_firebase.dart';
import 'package:divice/domain/repositories/firebase/device_repository_firebase.dart';
import 'package:divice/domain/repositories/firebase/equipment_repository_firebase.dart';
import 'package:divice/domain/repositories/firebase/model_repository_firebase.dart';
import 'package:divice/ui/device/new_care/add_new_care_ui.dart';
import 'package:divice/ui/device/list_device/device.dart';
import 'package:divice/ui/search/care_search.dart';
import 'package:divice/ui/setting/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/theme.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'ui/auth/auth.dart';
import 'ui/home/bottom_bar.dart';
import 'ui/home/home_page.dart';

bool shouldUseFirebaseEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (shouldUseFirebaseEmulator) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DeviceRepositoryFireBase(),
        ),
        RepositoryProvider(
          create: (context) => CareHistoryRepositoryFireBase(),
        ),
        RepositoryProvider(create: (context) => ModelRepositoryFirebase()),
        RepositoryProvider(create: (context) => EquipmentRepositoryFirebase()),
        RepositoryProvider(
          create: (context) => CareRepositoryFireBase(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (BuildContext context) => ThemeBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => DeviceBloc(
                RepositoryProvider.of<DeviceRepositoryFireBase>(context),
                RepositoryProvider.of<ModelRepositoryFirebase>(context),
                RepositoryProvider.of<EquipmentRepositoryFirebase>(context)),
          ),
          BlocProvider(
            create: (context) => CareBloc(
              RepositoryProvider.of<CareRepositoryFireBase>(context),
              careRepository: CareRepositoryFireBase(),
              careId: '',
            ),
          ),
        ],
        child: const AppM(),
      ),
    );
  }
}

class AppM extends StatelessWidget {
  const AppM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const CareSearch(),
      const AddNewCare(),
      const DevicePage(),
      const SettingPage()
    ];

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: state.isDarkModeEnabled ? darkTheme : lightTheme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: state.local,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              BlocProvider.of<AuthBloc>(context, listen: false)
                  .add(LoginAuthEvent(user: snapshot.data!));
              return Scaffold(
                body: IndexedStack(
                  index: state.index,
                  children: screens,
                ),
                bottomNavigationBar: const BottomNavigationBarCustomize(),
              );
            }
            BlocProvider.of<AuthBloc>(context, listen: false)
                .add(LogoutAuthEvent());
            return const AuthGate();
          },
        ),
      ),
    );
  }
}
