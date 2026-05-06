import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/pages/create_ledger2_page.dart';
import 'package:income_and_expense_tracker/pages/create_ledger_page.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import '../View/home/home_bloc.dart';
import '../data/model/ledger_model/ledger_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<Color>> _cardGradients = [
    [const Color(0xFF58b0aa), const Color(0xFF1b3d3a)],
    [const Color(0xFFa1684d), const Color(0xFF9d3f13)],
    [const Color(0xFFed9791), const Color(0xFFeb4034)],
  ];

  void _deleteLedger(BuildContext context, int ledgerId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Delete Ledger"),
          content: const Text("Are you sure you want to delete this ledger"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                await context.read<LedgerRepository>().deleteLedger(ledgerId);

                setState(() {});

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ledger Deleted"),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const Text("Delete",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Select Ledger",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.color,
                fontSize: 35,
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
                Text(
                  "Your Workspaces",
                  style: TextStyle(
                    color: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.color,
                    fontSize: 30,
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

                Expanded(
                  child: FutureBuilder<List<LedgerModel>>(
                    future: context.read<LedgerRepository>().getLedgers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No ledgers found. Create one below!",
                            style:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
                          ),
                        );
                      }

                      final ledgers = snapshot.data!;
                      return ListView.builder(
                        itemCount: ledgers.length,
                        itemBuilder: (context, index) {
                          final LedgerModel ledger = ledgers[index];
                          final gradientColors =
                          _cardGradients[index % _cardGradients.length];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) =>
                                    CreateLedger2Page(ledgerId: ledger.id,
                                      ledgerName: ledger.name ??
                                          'Unnamed Ledger',
                                    ),
                              ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: gradientColors,
                                  stops: const [0.1, 1.0],
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
                                      Text(
                                        ledger.iconLabel ?? 'General',
                                        style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.white),
                                        onPressed: () {
                                          _deleteLedger(context, ledger.id);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Text(
                                    ledger.name ?? 'Unnamed Ledger',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Currency: ${ledger.currency}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // const SizedBox(height: 350),

                BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is HomeNavigationToCreateNewLedgerState) {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => const CreateLedgerPage(),
                        ),
                      )
                          .then((_) {
                        setState(() {});
                      });
                    }
                  },
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context.read<HomeBloc>().add(
                          HomeNavigationToCreateNewLedgerEvent(),
                        );
                      },
                      child: Container(
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: const Color(0XFF0a1625),
        //   unselectedItemColor: Colors.blueGrey,
        //   selectedItemColor: Colors.white,
        //   showSelectedLabels: true,
        //   type: BottomNavigationBarType.fixed,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.account_balance_wallet),
        //       label: 'Ledger',
        //     ),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.pie_chart), label: 'Report'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.settings), label: 'Settings')
        //   ],
        // )
      ),
    );
  }
}