import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/NavigationBottomPage.dart';
import 'package:income_and_expense_tracker/pages/create_ledger2_page.dart';
import 'package:income_and_expense_tracker/pages/home_page.dart';

import '../View/addTransactionPage/add_transaction_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  final int ledgerId;

  const AddTransactionPage({super.key, required this.ledgerId});

  @override
  State<AddTransactionPage> createState() => _SimpleAddTransactionState();
}

class _SimpleAddTransactionState extends State<AddTransactionPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  bool isExpense = true;
  String selectedPayer = 'Me';
  String selectedCategory = 'FOOD';
  String paymentMethod = 'CASH';

  final List<String> payers = ['Me', 'Nimsara', 'Perera'];
  final List<String> categories = [
    'TRANSPORT',
    'FOOD',
    'STAY',
    'GIFT',
    'OTHER'
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveTransaction() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Enter Valid Amount "), backgroundColor: Colors.red),
      );
      return;
    }

    await context.read<LedgerRepository>().addTransaction(
      ledgerId: widget.ledgerId,
      amount: amount,
      isExpense: isExpense,
      paidBy: selectedPayer,
      category: selectedCategory,
      paymentMethod: paymentMethod,
      notes: _notesController.text.trim(),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("saved"), backgroundColor: Colors.green),
      );

      Navigator.of(context).pop(
        // MaterialPageRoute(builder: (context) => const Navigationbottompage()),
        // (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTransactionBloc(),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('New Transaction'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.history, color: Colors.blue),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      'AMOUNT (Rs)',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: '0',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        prefixText: 'Rs. ',
                        prefixStyle: TextStyle(
                            color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              isExpense ? Colors.red : Colors.grey[800],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () => setState(() => isExpense = true),
                            child: const Text('EXPENSE',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              !isExpense ? Colors.blue : Colors.grey[800],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () => setState(() => isExpense = false),
                            child: Text('INCOME',
                                style: TextStyle(
                                    color: !isExpense
                                        ? Colors.black
                                        : Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('PAID BY',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: payers.map((payer) {
                        return ChoiceChip(
                          label: Text(payer),
                          selected: selectedPayer == payer,
                          selectedColor: Colors.blue,
                          onSelected: (selected) {
                            setState(() => selectedPayer = payer);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    const Text('CATEGORY',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedCategory,
                      dropdownColor: Colors.grey[900],
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.black45,
                      ),
                      items: categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedCategory = value!),
                    ),
                    const SizedBox(height: 24),
                    const Text('PAYMENT METHOD',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(child: Text('CASH')),
                            selected: paymentMethod == 'CASH',
                            selectedColor: Colors.blue,
                            onSelected: (_) =>
                                setState(() => paymentMethod = 'CASH'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(child: Text('CARD')),
                            selected: paymentMethod == 'CARD',
                            selectedColor: Colors.blue,
                            onSelected: (_) =>
                                setState(() => paymentMethod = 'CARD'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Add Receipt Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('NOTES',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Add details about this transaction...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Save Transaction',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
