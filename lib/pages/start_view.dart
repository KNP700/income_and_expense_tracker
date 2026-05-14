import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/navigationBottomPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

import '../View/startView/start_view_bloc.dart';
import '../data/repositories/auth_repository.dart';
import 'login_page.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkSecurityAndRoute();
  }

  Future<void> _checkSecurityAndRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    bool useBiometrics = prefs.getBool('use_biometrics') ?? false;

    if (!useBiometrics) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Navigationbottompage()),
      );
      return;
    }

    await _triggerBiometricUnlock();
  }

  Future<void> _triggerBiometricUnlock() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please unlock to open your app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (didAuthenticate && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Navigationbottompage()),
        );
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Required to continue")),
          );
        }
      }
    } catch (e) {
      print("error : $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.blue)
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                "App Locked",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _triggerBiometricUnlock,
                icon: const Icon(Icons.fingerprint),
                label: const Text("Tap to Unlock"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}