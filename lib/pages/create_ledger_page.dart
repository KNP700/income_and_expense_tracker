import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:income_and_expense_tracker/pages/NavigationBottomPage.dart';
import 'package:income_and_expense_tracker/pages/create_ledger2_page.dart';
import '../View/createLedgerPage/create_ledger_page_bloc.dart';

class CreateLedgerPage extends StatefulWidget {
  const CreateLedgerPage({super.key});

  @override
  State<CreateLedgerPage> createState() => _CreateLedgerPageState();
}

class _CreateLedgerPageState extends State<CreateLedgerPage> {
  final TextEditingController _nameController = TextEditingController();
  int _selectedIconIndex = 0;
  bool _isShared = false;

  String _Currency = 'LKR - Rs';

  final List<Map<String, dynamic>> _icons = [
    {'icon': Icons.category, 'label': 'General'},
    {'icon': Icons.flight, 'label': 'Travel'},
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.card_giftcard, 'label': 'Gift'},
    {'icon': Icons.shopping_bag, 'label': 'Shop'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLedgerPageBloc(
        ledgerRepository: context.read<LedgerRepository>(),
      ),
      child: Builder(builder: (context) {
        return BlocListener<CreateLedgerPageBloc, CreateLedgerPageState>(
          listener: (context, state) {

            if (state is CreateLedgerPageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ledger created successfully'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=> CreateLedger2Page(ledgerId: 0, ledgerName: _nameController.text.trim()))
              );

            } else if (state is CreateLedgerPageError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Create New Ledger'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(const Navigationbottompage() as Route<Object?>);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('LEDGER NAME',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g., Summer Vacation',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('SELECT ICON',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      _icons.length,
                          (index) => Column(
                        children: [
                          IconButton(
                            icon: Icon(_icons[index]['icon']),
                            color: _selectedIconIndex == index
                                ? Colors.blue
                                : Colors.grey,
                            iconSize: 32,
                            onPressed: () {
                              setState(() {
                                _selectedIconIndex = index;
                              });
                            },
                          ),
                          Text(
                            _icons[index]['label'],
                            style: TextStyle(
                              color: _selectedIconIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('CURRENCY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _Currency,
                    decoration:
                    const InputDecoration(border: OutlineInputBorder()),
                    items: ['LKR - Rs', 'USD - \$'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          _Currency = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Card(
                    child: SwitchListTile(
                      title: const Text('Shared Ledger',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: const Text('Invite friends to track together'),
                      secondary:
                      const Icon(Icons.group_add, color: Colors.blue),
                      value: _isShared,
                      activeThumbColor: Colors.blue,
                      onChanged: (value) {
                        setState(() {
                          _isShared = value;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<CreateLedgerPageBloc, CreateLedgerPageState>(
                    builder: (context, state) {
                      bool isLoading = state is CreateLedgerPageLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                            if (_nameController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Enter Ledger Name"),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                              return;
                            }

                            context.read<CreateLedgerPageBloc>().add(
                              CreateLedgerSubmitted(
                                name: _nameController.text.trim(),
                                iconLabel: _icons[_selectedIconIndex]
                                ['label'],
                                currency: _Currency,
                                isShared: _isShared,
                              ),
                            );
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                              color: Colors.white)
                              : const Text(
                            'Create Ledger',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}