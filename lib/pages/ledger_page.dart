import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/model/ledger_model/ledger_model.dart';
import 'package:income_and_expense_tracker/data/model/transaction_model/transaction_model.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/add_transaction_page.dart';

enum DateFilter { today, weekly, custom }

class LedgerPage extends StatefulWidget {
  const LedgerPage({super.key});

  @override
  State<LedgerPage> createState() => _LedgerPageState();
}

class _LedgerPageState extends State<LedgerPage> {
  DateFilter _selectedFilter = DateFilter.weekly;
  DateTimeRange? _customDataRange;
  final List<String> _selectedLedgers = [];

  IconData _getLedgerIcon(String label) {
    switch (label.toLowerCase()) {
      case 'travel':
        return Icons.flight;
      case 'home':
        return Icons.home;
      case 'gift':
        return Icons.card_giftcard;
      case 'shop':
        return Icons.shopping_bag;
      default:
        return Icons.category;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toUpperCase()) {
      case 'TRANSPORT':
        return Icons.train;
      case 'FOOD':
        return Icons.restaurant;
      case 'GIFT':
        return Icons.card_giftcard;
      case 'SHOP':
        return Icons.shopping_bag;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'TRANSPORT':
        return Colors.blueAccent;
      case 'HOME':
        return Colors.orange;
      case 'STAY':
        return Colors.purple;
      case 'GIFT':
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }

  bool _isWithFilter(DateTime transactionDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_selectedFilter) {
      case DateFilter.today:
        return transactionDate.isAfter(today) ||
            transactionDate.isAtSameMomentAs(today);

      case DateFilter.weekly:
        final weekAgo = today.subtract(const Duration(days: 7));
        return transactionDate.isAfter(weekAgo);

      case DateFilter.custom:
        if (_customDataRange == null) return true;

        final start = _customDataRange!.start;
        final end = _customDataRange!.end.add(const Duration(days: 1));
        return transactionDate.isAfter(start) && transactionDate.isBefore(end);
    }
  }

  Future<Map<String, dynamic>> _getStatsAndTransactions(
      List<LedgerModel> allLedgers) async {
    double income = 0;
    double expense = 0;
    List<TransactionModel> filteredTransactions = [];
    final repo = context.read<LedgerRepository>();

    for (var ledger in allLedgers) {
      if (_selectedLedgers.isEmpty || _selectedLedgers.contains(ledger.name)) {
        final transactions = await repo.getTransactions(ledger.id);

        for (var t in transactions) {
          if (_isWithFilter(t.date)) {
            filteredTransactions.add(t);
            if (t.isExpense) {
              expense += t.amount;
            } else {
              income += t.amount;
            }
          }
        }
      }
    }

    return {
      'income': income,
      'expense': expense,
      'transactions': filteredTransactions
    };
  }

  void _showLedgerSection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF15202B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Ledger",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<List<LedgerModel>>(
                  future: context.read<LedgerRepository>().getLedgers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: CircularProgressIndicator(
                                color: Colors.blueAccent)),
                      );
                    }

                    final ledgers = snapshot.data ?? [];

                    if (ledgers.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                            child: Text("No ledger Found",
                                style: TextStyle(color: Colors.grey))),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: ledgers.length,
                      itemBuilder: (context, index) {
                        final ledger = ledgers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                            Colors.blueAccent.withOpacity(0.2),
                            child: Icon(
                              _getLedgerIcon(ledger.iconLabel),
                              color: Colors.blueAccent,
                            ),
                          ),
                          title: Text(ledger.name,
                              style: const TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTransactionPage(
                                    ledgerId: ledger.id),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
      .of (context)
      .scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Ledger Analysis',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode, color: Colors.amber),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<LedgerModel>>(
        future: context.read<LedgerRepository>().getLedgers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent));
          }
          final dbLedgers = snapshot.data ?? [];
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text('Today'),
                    selected: _selectedFilter == DateFilter.today,
                    selectedColor: Colors.blueAccent,
                    onSelected: (_) =>
                        setState(() => _selectedFilter = DateFilter.today),
                  ),
                  ChoiceChip(
                    label: const Text('Weekly'),
                    selected: _selectedFilter == DateFilter.weekly,
                    selectedColor: Colors.blueAccent,
                    onSelected: (_) =>
                        setState(() => _selectedFilter = DateFilter.weekly),
                  ),
                  ChoiceChip(
                    label: Text(_selectedFilter == DateFilter.custom &&
                        _customDataRange != null
                        ? '${_customDataRange!.start.day}/${_customDataRange!.start.month} - ${_customDataRange!.end.day}/${_customDataRange!.end.month}'
                        : 'Custom'),
                    selected: _selectedFilter == DateFilter.custom,
                    selectedColor: Colors.blueAccent,
                    onSelected: (selected) async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: const ColorScheme.dark(
                                  primary: Colors.blueAccent),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _customDataRange = picked;
                          _selectedFilter = DateFilter.custom;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('SELECT LEDGERS',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (dbLedgers.isEmpty)
                const Text('No ledger created yet,',
                    style: TextStyle(color: Colors.grey))
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: dbLedgers.map((ledger) {
                    final isSelected = _selectedLedgers.contains(ledger.name);
                    return FilterChip(
                      label: Text(ledger.name),
                      avatar: Icon(
                        _getLedgerIcon(ledger.iconLabel),
                        color: isSelected ? Colors.white : Colors.blueAccent,
                        size: 18,
                      ),
                      selected: isSelected,
                      selectedColor: Colors.blueAccent,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedLedgers.add(ledger.name);
                          } else {
                            _selectedLedgers.remove(ledger.name);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 40),
              FutureBuilder<Map<String, dynamic>>(
                future: _getStatsAndTransactions(dbLedgers),
                builder: (context, statsSnapshot) {
                  if (statsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SizedBox(
                      height: 250,
                      child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.blueAccent)),
                    );
                  }

                  final stats = statsSnapshot.data ??
                      {
                        'income': 0.0,
                        'expense': 0.0,
                        'transactions': <TransactionModel>[]
                      };

                  final totalIncome = stats['income'] as double;
                  final totalExpense = stats['expense'] as double;
                  final transactionList =
                  stats['transactions'] as List<TransactionModel>;
                  final remainingBalance = totalIncome - totalExpense;

                  double incomeValue = 0.0;
                  double expenseValue = 0.0;

                  if (totalIncome > 0 || totalExpense > 0) {
                    if (totalIncome >= totalExpense) {
                      incomeValue = 1.0;
                      expenseValue = totalExpense / totalIncome;
                    } else {
                      expenseValue = 1.0;
                      incomeValue = totalIncome / totalExpense;
                    }
                  }

                  return Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: CircularProgressIndicator(
                                  value: 1.0,
                                  strokeWidth: 16,
                                  color: Colors.grey[900]),
                            ),
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: CircularProgressIndicator(
                                  value: incomeValue,
                                  strokeWidth: 16,
                                  color: Colors.blueAccent),
                            ),
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: CircularProgressIndicator(
                                  value: expenseValue,
                                  strokeWidth: 16,
                                  color: Colors.redAccent),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('TOTAL BALANCE',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(
                                  'Rs.${remainingBalance.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: remainingBalance >= 0
                                        ? Colors.white
                                        : Colors.redAccent,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('INCOME',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('Rs.${totalIncome.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(width: 1, height: 40, color: Colors.grey),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('EXPENSES',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text('Rs.${totalExpense.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recent Transactions',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (transactionList.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("No transaction found",
                              style: TextStyle(color: Colors.grey)),
                        )
                      else
                        ...transactionList.map((transaction) {
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
                                    color: Colors.grey, fontSize: 10),
                              ),
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
                    ],
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLedgerSection(context);
        },
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color color;
  final double progress;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              width: 60,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[800],
                color: color,
                minHeight: 4,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}