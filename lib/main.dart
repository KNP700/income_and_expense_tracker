import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/start_view.dart';
import 'data/repositories/auth_repository.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Income Tracker',
        home: StartView(),
      ),
    );
  }
}


// await
// Firebase.initializeApp
// (
// options: DefaultFirebaseOptions.currentPlatform,
// );
//
// runApp(
// const MaterialApp(
// home: LoginPage(),
// debugShowCheckedModeBanner: false
// ,
// )
// );
// }