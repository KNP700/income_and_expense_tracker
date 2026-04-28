import 'package:flutter/material.dart';
import 'package:income_and_expense_tracker/pages/add_transaction_page.dart';


class CreateLedger2Page extends StatefulWidget {

  final int ledgerId;
  final String ledgerName;

  CreateLedger2Page({
    super.key,
  required this.ledgerId,
  required this.ledgerName,
  });


  @override
  State<CreateLedger2Page> createState() => _SimpleLedgerPageState();
}

class _SimpleLedgerPageState extends State<CreateLedger2Page> {
  int _selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.ledgerName,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            const Text('April 10 - April 19, 2026',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: const [
          Icon(Icons.nightlight_round, color: Colors.white54),
          SizedBox(width: 12),
          CircleAvatar(backgroundColor: Colors.orange, radius: 16),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _selectedTab = 0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _selectedTab == 0 ? Colors.blue : Colors.grey[800],
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
                      backgroundColor:
                          _selectedTab == 1 ? Colors.red : Colors.grey[800],
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
            const Text(
              'TOTAL SPENT',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rs. 20,000',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Card(
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text('REMAINING BALANCE',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text('Rs. 15,000',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.account_balance_wallet,
                      color: Colors.black, size: 36),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Text('COLLABORATORS',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                Spacer(),
                CircleAvatar(backgroundColor: Colors.green, radius: 15),
                SizedBox(width: 5),
                CircleAvatar(backgroundColor: Colors.grey, radius: 15),
                SizedBox(width: 5),
                CircleAvatar(backgroundColor: Colors.white, radius: 15),
                SizedBox(width: 5),
                CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add, color: Colors.white, size: 18)),
              ],
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('CATEGORIES',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            const Card(
              color: Color(0xFF15202B),
              child: ListTile(
                leading: Icon(Icons.train, color: Colors.orange),
                title: Text('Transport',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('EXPENSE',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: Text('Rs 2,000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Card(
              color: Color(0xFF15202B),
              child: ListTile(
                leading: Icon(Icons.restaurant, color: Colors.cyan),
                title: Text('Food',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('EXPENSE',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: Text('Rs 500',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Card(
              color: Color(0xFF15202B),
              child: ListTile(
                leading: Icon(Icons.bed, color: Colors.purple),
                title: Text('Stay',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('EXPENSE',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: Text('Rs 5,000',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            // BlocConsumer<CreateLedger2PageBloc, CreateLedger2PageState>(
            //   listener: (context, state) {
            //     if (state is createLegerToAddTransactionState) {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => const AddTransactionPage(),
            //         ),
            //       );
            //     }
            //   },n
            //   builder: (context, state) {
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTransactionPage(ledgerId: widget.ledgerId),
                  ),
                );
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
      ),
    );
  }
}
