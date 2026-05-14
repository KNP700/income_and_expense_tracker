import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isDarkMode = true;
  bool _isNotificationsEnabled = false;
  bool _isBiometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricEnabled = prefs.getBool('use_biometrics') ?? false;
      _isDarkMode = prefs.getBool('is_dark_mode') ?? true;
      _isNotificationsEnabled =
          prefs.getBool('is_notifications_enabled') ?? false;
    });
  }

  Future<void> _toggleLock(bool value) async {
    if (value == true) {
      try {
        bool didAuthenticate = await _localAuth.authenticate(
          localizedReason: "please vertify to enable biometric lock",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ),
        );

        if (didAuthenticate) {
          setState(() {
            _isBiometricEnabled = true;
          });

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('use_biometrics', true);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed. Try again')),
            );
          }
        }
      } catch (e) {
        print('Biometric error $e');
      }
    } else {
      setState(() {
        _isBiometricEnabled = false;
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('use_biometrics', false);
    }
  }

  Future<void> _toggleTheme(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', value);
    themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _isNotificationsEnabled = value;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_notifications_enabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Kaveen Nimsara',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 32),
          const Text('PREFERENCES',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.blue),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Reduce eye strain'),
                  value: _isDarkMode,
                  onChanged: _toggleTheme,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary:
                      const Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('Notifications'),
                  subtitle: const Text('Daily spending alerts'),
                  value: _isNotificationsEnabled,
                  onChanged: _toggleNotifications,
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.attach_money, color: Colors.blue),
                  title: Text('Currency Format'),
                  subtitle: Text('LKR (Rs)'),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('SECURITY',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint, color: Colors.blue),
                  title: const Text('Biometric Lock'),
                  subtitle: const Text('FaceID / TouchID'),
                  value: _isBiometricEnabled,
                  onChanged: _toggleLock,
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.restore, color: Colors.blue),
                  title: Text('Change Password'),
                  subtitle: Text('Last changed 3 months ago'),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('ABOUT',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          const Card(
            child: ListTile(
              leading: Icon(Icons.help_outline, color: Colors.blue),
              title: Text('Help & Support'),
              trailing: Icon(Icons.open_in_new, size: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () async {
              try {
                await context.read<LedgerRepository>().clearAllData();
                await FirebaseAuth.instance.signOut();

                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error -- >$e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Log Out',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
