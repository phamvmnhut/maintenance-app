import 'package:divice/business/auth.dart';
import 'package:divice/business/setting.dart';
import 'package:divice/ui/device/add_new_care_ui.dart';
import 'package:divice/ui/search/search.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: const AppM(),
    );
  }
}

class AppM extends StatelessWidget {
  const AppM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screens = [
      const Home(),
      BuildSearch(),
      const AddNewCare(),
      const Center(child: Text('Màn hình chưa code 02')),
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
              return Scaffold(
                body: screens[state.index],
                bottomNavigationBar: const buildBottomNavigationBar(),
              );
            }
            return const AuthGate();
          },
        ),
      ),
    );
  }
}
