import 'package:flutter/material.dart';
// 1. Add the Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:income_and_expense_tracker/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MaterialApp(
        home: LoginPage(),
        debugShowCheckedModeBanner: false,
      )
  );
}