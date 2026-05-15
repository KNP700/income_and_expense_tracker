import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/model/ledger_model/ledger_model.dart';
import '../data/model/transaction_model/transaction_model.dart';

// 1. Added the enum here so the DateFilter works properly
enum DateFilter { today, weekly, custom }

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateFilter _selectedFilter = DateFilter.weekly;
  DateTimeRange? _customDataRange;

  String selectedLedger = 'All Ledgers';
  String selectedReportType = 'Ledger Summary';
  bool _isDownloading = false;
  bool _isLoadingLedgers = true;
  List<String> _dynamicLedgerNames = ['All Ledgers'];

  List<LedgerModel> _dbLedgers = [];

  final Color cyanAccent = const Color(0xFF00E5FF);

  @override
  void initState() {
    super.initState();
    _fetchLedgerFromDatabase();
  }

  String get timeFrameString {
    switch (_selectedFilter) {
      case DateFilter.today:
        return 'Today';
      case DateFilter.weekly:
        return 'Weekly';
      case DateFilter.custom:
        if (_customDataRange != null) {
          return '${_customDataRange!.start.day}/${_customDataRange!.start.month} - ${_customDataRange!.end.day}/${_customDataRange!.end.month}';
        }
        return 'Custom';
    }
  }

  Future<void> _genaratedPdf(List<TransactionModel> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Income and Expenses Transactions',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Ledger: $selectedLedger'),
              pw.Text('TimeFrame: $timeFrameString'),
              pw.Text('Report Type : $selectedReportType'),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Category', 'Note', 'Amount'],
                data: transactions.map((tx) {
                  return [
                    '${tx.date.year}-${tx.date.month}-${tx.date.day}',
                    tx.category,
                    tx.notes ?? '-',
                    tx.isExpense ? 'Expense' : 'Income',
                    'Rs ${tx.amount.toStringAsFixed(2)}',
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration:
                const pw.BoxDecoration(color: PdfColors.blueGrey800),
                cellAlignment: pw.Alignment.centerLeft,
              ),
            ],
          );
        },
      ),
    );
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'Expense_Report_${selectedLedger.replaceAll(' ', '_')}.pdf',
    );
  }

  Future<void> _fetchLedgerFromDatabase() async {
    try {
      final repo = context.read<LedgerRepository>();
      final ledgers = await repo.getLedgers();

      if (mounted) {
        if (_dbLedgers.length != ledgers.length) {
          setState(() {
            _dbLedgers = ledgers;
            _dynamicLedgerNames = ['All Ledgers', ...ledgers.map((l) => l.name)];
            _isLoadingLedgers = false;

            if (!_dynamicLedgerNames.contains(selectedLedger)) {
              selectedLedger = 'All Ledgers';
            }
          });
        } else if (_isLoadingLedgers) {
          setState(() {
            _isLoadingLedgers = false;
          });
        }
      }
    } catch (e) {
      if (mounted && _isLoadingLedgers) {
        setState(() => _isLoadingLedgers = false);
      }
    }
  }
  bool _isWithinTime(DateTime transactionDate) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          'Report Configuration',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              setState(() => _isLoadingLedgers = true);
              _fetchLedgerFromDatabase();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.settings,
                        color: Colors.blueAccent, size: 30),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Configure & Download your report',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('TIMEFRAME'),
            const SizedBox(height: 10),


            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
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
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('SELECT LEDGERS'),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _isLoadingLedgers
                  ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.teal),
              )
                  : Row(
                children: _dynamicLedgerNames.map((ledgerName) {
                  return _buildLedgerChip(ledgerName);
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: _isDownloading
                  ? null
                  : () async {
                setState(() {
                  _isDownloading = true;
                });

                try {
                  final repo = context.read<LedgerRepository>();
                  final freshLedgers = await repo.getLedgers();
                  List<TransactionModel> finalTransactionsToReport = [];

                  for (var ledger in freshLedgers) {
                    if (selectedLedger == 'All Ledgers' ||
                        selectedLedger == ledger.name) {
                      final transactions =
                      await repo.getTransactions(ledger.id);
                      for (var t in transactions) {
                        if (_isWithinTime(t.date)) {
                          finalTransactionsToReport.add(t);
                        }
                      }
                    }
                  }

                  await _genaratedPdf(finalTransactionsToReport);

                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Report downloaded successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error $e"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isDownloading = false;
                    });
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isDownloading ? Colors.grey : cyanAccent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (!_isDownloading)
                      BoxShadow(
                        color: cyanAccent.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isDownloading)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3,
                        ),
                      )
                    else ...const [
                      Icon(Icons.download, color: Colors.black),
                      SizedBox(width: 10),
                      Text(
                        'DOWNLOAD REPORT',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.blueAccent,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildLedgerChip(String title) {
    bool isSelected = selectedLedger == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLedger = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.teal.withOpacity(0.1)
              : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? cyanAccent : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? cyanAccent : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}