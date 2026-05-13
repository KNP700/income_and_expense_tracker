import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/model/transaction_model/transaction_model.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/add_transaction_page.dart';

import '../View/createLedger2Page/create_ledger2_page_bloc.dart';

class CreateLedger2Page extends StatefulWidget {
  final int ledgerId;
  final String ledgerName;

  const CreateLedger2Page({
    super.key,
    required this.ledgerId,
    required this.ledgerName,
  });

  @override
  State<CreateLedger2Page> createState() => _SimpleLedgerPageState();
}

class _SimpleLedgerPageState extends State<CreateLedger2Page> {
  int _selectedTab = 1;

  IconData _getCategoryIcon(String category) {
    switch (category.toUpperCase()) {
      case 'Transport':
        return Icons.train;
      case 'Food':
        return Icons.restaurant;
      case 'Stay':
        return Icons.bed;
      case 'Gift':
        return Icons.card_giftcard;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'Transport':
        return Colors.orange;
      case 'Food ':
        return Colors.cyan;
      case 'Stay':
        return Colors.purple;
      case 'Gift':
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLedger2PageBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.ledgerName,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          actions: const [
            Icon(Icons.nightlight_round, color: Colors.white54),
            SizedBox(width: 12),
            CircleAvatar(backgroundColor: Colors.orange, radius: 16),
            SizedBox(width: 16),
          ],
        ),
        body: FutureBuilder<List<TransactionModel>>(
          future:
              context.read<LedgerRepository>().getTransactions(widget.ledgerId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final transactions = snapshot.data ?? [];

            double totalIncome = 0;
            double totalExpense = 0;

            for (var t in transactions) {
              if (t.isExpense) {
                totalExpense += t.amount;
              } else {
                totalIncome += t.amount;
              }
            }

            double remainingBalance = totalIncome - totalExpense;

            bool showExpenses = _selectedTab == 1;
            final displayList =
                transactions.where((t) => t.isExpense == showExpenses).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _selectedTab = 0),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 0
                                ? Colors.blue
                                : Colors.grey[800],
                          ),
                          child: Text('Income',
                              style: TextStyle(
                                  color: _selectedTab == 0
                                      ? Colors.black
                                      : Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => _selectedTab = 1),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 1
                                ? Colors.red
                                : Colors.grey[800],
                          ),
                          child: Text('Expenses',
                              style: TextStyle(
                                  color: _selectedTab == 1
                                      ? Colors.black
                                      : Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _selectedTab == 0 ? 'Total Income' : 'Total Spent',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedTab == 0
                        ? 'Rs.${totalIncome.toStringAsFixed(2)}'
                        : 'Rs.${totalExpense.toStringAsFixed(1)}',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: const Text('REMAINING BALANCE',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'Rs.${remainingBalance.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        trailing: const Icon(Icons.account_balance_wallet,
                            color: Colors.black, size: 36),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    // children: [
                    //   Text('COLLABORATORS',
                    //       style: TextStyle(
                    //           color: Colors.blue,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold)),
                    //   Spacer(),
                    //   CircleAvatar(backgroundColor: Colors.green, radius: 15),
                    //   SizedBox(width: 5),
                    //   CircleAvatar(backgroundColor: Colors.grey, radius: 15),
                    //   SizedBox(width: 5),
                    //   CircleAvatar(backgroundColor: Colors.white, radius: 15),
                    //   SizedBox(width: 5),
                    //   CircleAvatar(
                    //       backgroundColor: Colors.black,
                    //       child:
                    //           Icon(Icons.add, color: Colors.white, size: 18)),
                    // ],
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('TRANSACTIONS',
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  if (displayList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text("No Transactions yet",
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          )),
                    )
                  else
                    ...displayList.map((transaction) {
                      return Card(
                        color: const Color(0xFF15202B),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Icon(
                            _getCategoryIcon(transaction.category),
                            color: _getCategoryColor(transaction.category),
                          ),
                          title: Text(transaction.category,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              transaction.notes?.isNotEmpty == true
                                  ? transaction.notes!
                                  : transaction.paidBy,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10)),
                          trailing: Text(
                            'Rs ${transaction.amount.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: transaction.isExpense
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }),
                  //
                  //
                  // const Card(
                  //   color: Color(0xFF15202B),
                  //   child: ListTile(
                  //     leading: Icon(Icons.train, color: Colors.orange),
                  //     title: Text('Transport',
                  //         style: TextStyle(
                  //             color: Colors.white, fontWeight: FontWeight
                  //             .bold)),
                  //     subtitle: Text('EXPENSE',
                  //         style: TextStyle(color: Colors.grey,
                  //             fontSize: 10)),
                  //     trailing: Text('Rs 2,000',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                  // ),
                  // const Card(
                  //   color: Color(0xFF15202B),
                  //   child: ListTile(
                  //     leading: Icon(Icons.restaurant, color: Colors.cyan),
                  //     title: Text('Food',
                  //         style: TextStyle(
                  //             color: Colors.white, fontWeight: FontWeight
                  //             .bold)),
                  //     subtitle: Text('EXPENSE',
                  //         style: TextStyle(color: Colors.grey,
                  //             fontSize: 10)),
                  //     trailing: Text('Rs 500',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                  // ),
                  // const Card(
                  //   color: Color(0xFF15202B),
                  //   child: ListTile(
                  //     leading: Icon(Icons.bed, color: Colors.purple),
                  //     title: Text('Stay',
                  //         style: TextStyle(
                  //             color: Colors.white, fontWeight: FontWeight
                  //             .bold)),
                  //     subtitle: Text('EXPENSE',
                  //         style: TextStyle(color: Colors.grey,
                  //             fontSize: 10)),
                  //     trailing: Text('Rs 5,000',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold)),
                  //   ),
                  // ),
                  // const SizedBox(height: 30),
                  // // BlocConsumer<CreateLedger2PageBloc, CreateLedger2PageState>(
                  // //   listener: (context, state) {
                  // //     if (state is createLegerToAddTransactionState) {
                  // //       Navigator.of(context).push(
                  // //         MaterialPageRoute(
                  // //           builder: (context) => const AddTransactionPage(),
                  // //         ),
                  // //       );
                  // //     }
                  // //   },n
                  // //   builder: (context, state) {
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AddTransactionPage(ledgerId: widget.ledgerId),
                        ),
                      )
                          .then((_) {
                        setState(() {});
                      });
                    },
                    icon: const Icon(Icons.add_circle, color: Colors.black),
                    label: const Text('Add Transaction',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
