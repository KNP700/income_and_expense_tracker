import 'dart:async'; // Required for StreamSubscription
import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/start_view.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/ledger_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// 1. Change this to StatefulWidget
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
        RepositoryProvider(create: (context) => LedgerRepository()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Income Tracker',
        home: StartView(),
      ),
    );
  }
}
