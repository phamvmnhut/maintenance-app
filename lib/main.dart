import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maintenance/business/auth.dart';
import 'package:maintenance/business/care.dart';
import 'package:maintenance/business/device.dart';
import 'package:maintenance/business/setting.dart';
import 'package:maintenance/domain/repositories/firebase/care_history_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/care_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/device_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/equipment_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/model_repository_firebase.dart';
import 'package:maintenance/ui/home/home_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/theme.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'ui/auth/auth.dart';

bool shouldUseFirebaseEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
        child: const AppTheme(),
      ),
    );
  }
}

class AppTheme extends StatefulWidget {
  const AppTheme({Key? key}) : super(key: key);

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  @override
  void initState() {
    context.read<ThemeBloc>().add(ThemeEventSetup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeState.isDarkModeEnabled ? darkTheme : lightTheme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: themeState.local,
        home: const AppAuth(),
      ),
    );
  }
}

class AppAuth extends StatefulWidget {
  const AppAuth({Key? key}) : super(key: key);

  @override
  State<AppAuth> createState() => _AppAuthState();
}

class _AppAuthState extends State<AppAuth> {
  @override
  void didChangeDependencies() {
    context.read<AuthBloc>().add(AuthEventSetup());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (pre, cur) => pre.isAuth != cur.isAuth,
      builder: (context, authState) {
        if (authState.isAuth) {
          return const HomeGate();
        } else {
          return const AuthGate();
        }
      },
    );
  }
}
