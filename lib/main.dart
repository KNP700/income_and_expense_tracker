import 'dart:async'; // Required for StreamSubscription
import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/app_theme_page.dart';
import 'package:income_and_expense_tracker/pages/start_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/ledger_firestore_repository.dart';
import 'data/repositories/ledger_repository.dart';
import 'data/repositories/local_repository.dart';


final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('is_dark_mode') ?? true;
  themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  StreamSubscription? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }


  void _initDeepLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      final String link = uri.toString();

      if (FirebaseAuth.instance.isSignInWithEmailLink(link)) {
        print('Received Auth Link: $link');
        _handleAuthLink(link);
      }
    });
  }

  void _handleAuthLink(String link) {
    // TODO: Add logic to sign in and navigate
  }

  @override
  void dispose() {
    _linkSubscription?.cancel(); // Now this works correctly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(
          create: (context) => LedgerRepository(
            localDataSource: LocalRepository(),
            remoteDataSource: LedgerFirestoreRepository(),
          ),
        ),
      ],
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Income Tracker',
            theme: AppThemePage.lightTheme,
            darkTheme: AppThemePage.darkTheme,
            themeMode: currentMode,
            home: const StartView(),
          );
        },
      ),
    );
  }
}

