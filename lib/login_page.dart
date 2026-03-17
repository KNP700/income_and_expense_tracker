import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF0d1d39),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'Assets/Images/wallet logo for loging page.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Please Sign to Track your expenses',
                style: TextStyle(color: Colors.blueGrey, fontSize: 22),
              ),

              const SizedBox(height: 40),

              const Text(
                'Email Address',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10),

              const TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'name@example.com',
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Password',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 10),

              const TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '***********',
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
