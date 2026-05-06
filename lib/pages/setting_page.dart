import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:income_and_expense_tracker/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _isDarkMode = true;
  bool _isNotificationsEnabled = false;
  bool _isBiometricEnabled = false;


  @override
  void initState(){
    super.initState();
    _detectBiometricType();
  }

  Future<void> _detectBiometricType()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isBiometricEnabled = prefs.getBool('use biometric')?? false;
    });
  }

  Future<void> __toggleLock(bool value) async{
    final prefs =  await SharedPreferences.getInstance();
    await prefs.setBool('use biomatric', value);
    setState(() {
      _isBiometricEnabled = value;
    });
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


          const Text('PREFERENCES', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.blue),
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Reduce eye strain'),
                  value: _isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      _isDarkMode = val;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('Notifications'),
                  subtitle: const Text('Daily spending alerts'),
                  value: _isNotificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _isNotificationsEnabled = val;
                    });
                  },
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.attach_money, color: Colors.blue),
                  title: Text('Currency Format'),
                  subtitle: Text('LKR (Rs)'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),


          const Text('SECURITY', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint, color: Colors.blue),
                  title: const Text('Biometric Lock'),
                  subtitle: const Text('FaceID / TouchID'),
                  value: _isBiometricEnabled,
                  onChanged: (val) {
                    __toggleLock(val) ;

                  },
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.restore, color: Colors.blue),
                  title: Text('Change Password'),
                  subtitle: Text('Last changed 3 months ago'),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),


          const Text('ABOUT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
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
                await FirebaseAuth.instance.signOut();

                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()), (
                      route) => false,
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error -- >$e"),
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
            child: const Text('Log Out', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}