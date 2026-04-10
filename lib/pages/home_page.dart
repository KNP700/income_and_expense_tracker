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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 30),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF58b0aa), Color(0xFF1b3d3a)],
                                stops: [0.1, 1.0],
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
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 55),
                                const Text(
                                  "Personal Wallet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Current Balance",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF58b0aa), Color(0xFF1b3d3a)],
                                stops: [0.1, 1.0],
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
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 55),
                                const Text(
                                  "Personal Wallet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 27,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "Current Balance",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 350),
                        ],
                      ),
                    ),
                  ),

                  // const SizedBox(height: 350),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create new Ledger ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0XFF0a1625),
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Ledger',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart), label: 'Report'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          )),
    );
  }
}
