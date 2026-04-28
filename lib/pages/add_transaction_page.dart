import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _SimpleAddTransactionState();
}

class _SimpleAddTransactionState extends State<AddTransactionPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
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
                  const TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      prefixText: 'Rs. ',
                      prefixStyle: TextStyle(color: Colors.white, fontSize: 24),
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
                            backgroundColor: !isExpense
                                ? Colors.blue
                                : Colors.grey[800],
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
                    value: selectedCategory,
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
                  const TextField(
                    maxLines: 3,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
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
                onPressed: () {},
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
    );
  }
}
