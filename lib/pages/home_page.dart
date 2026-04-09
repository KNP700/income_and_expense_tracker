import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View/home/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: const Color(0XFF0a1625),
        appBar: AppBar(
          backgroundColor: const Color(0XFF0a1625),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Image.asset(
                  'assets/icon/back_icon.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              "Select Ledger",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15.0, top: 8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xFF223143),
                backgroundImage: AssetImage('assets/icon/my_image.png'),
                child: Text(
                  'K',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Your Workspaces",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Select a ledger to manage your finance",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Color(0xFF074f4a)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/wallet logo for loging page.png',
                              width: 50,
                              height: 50,
                            ),
                            const Spacer(),
                            const Text(
                              "Default",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 55),
                        const Text(
                          "Personal Wallet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
