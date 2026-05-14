import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expense_tracker/data/repositories/ledger_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../data/model/ledger_model/ledger_model.dart';
import '../data/model/transaction_model/transaction_model.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedTimeframe = 'Monthly';
  String selectedLedger = 'All Ledgers';
  String selectedReportType = 'Ledger Summary';
  bool _isDownloading = false;
  bool _isLoadingLedgers = true;
  List<String> _dynamicLedgerNames = ['All Ledgers'];

  List<LedgerModel> _dbLedgers = [];

  final Color bgColor = const Color(0xFF0D131A);
  final Color cardColor = const Color(0xFF1A222D);
  final Color cyanAccent = const Color(0xFF00E5FF);

  @override
  void initState() {
    super.initState();
    _fetchLedgerFromDatabase();
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
              pw.Text('TimeFrame: $selectedTimeframe'),
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
      print("Error fetching ledgers: $e");
      if (mounted && _isLoadingLedgers) {
        setState(() => _isLoadingLedgers = false);
      }
    }
  }

  bool _isWithinTime(DateTime transactionDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (selectedTimeframe) {
      case 'Daily':
        return transactionDate.isAfter(today) ||
            transactionDate.isAtSameMomentAs(today);
      case 'Weekly':
        final weekAgo = today.subtract(const Duration(days: 7));
        return transactionDate.isAfter(weekAgo);
      case 'Monthly':
        final monthAgo = DateTime(now.year, now.month - 1, now.day);
        return transactionDate.isAfter(monthAgo);
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchLedgerFromDatabase();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Report Configuration',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.orange.withOpacity(0.2),
              child: const Icon(Icons.receipt_long,
                  color: Colors.orange, size: 20),
            ),
          )
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
                      color: Colors.teal.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.settings, color: cyanAccent, size: 30),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Configure & Download your report',
                    style: TextStyle(
                      color: Colors.white,
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
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTimeframeOption('Daily'),
                  _buildTimeframeOption('Weekly'),
                  _buildTimeframeOption('Monthly'),
                  _buildTimeframeOption('Custom'),
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
            // _buildSectionTitle('REPORT TYPE'),
            const SizedBox(height: 10),
            // Row(
            //   children: [
            //     Expanded(
            //         child: _buildReportTypeCard(
            //             'Ledger Summary', Icons.account_balance_wallet)),
            //     const SizedBox(width: 15),
            //     Expanded(
            //         child: _buildReportTypeCard(
            //             'Transaction List', Icons.list_alt)),
            //   ],
            // ),
            const SizedBox(height: 30),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: cardColor,
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 60,
            //         width: 50,
            //         decoration: BoxDecoration(
            //           color: Colors.white.withOpacity(0.05),
            //           borderRadius: BorderRadius.circular(8),
            //           border: Border.all(color: Colors.white12),
            //         ),
            //         child: const Icon(Icons.text_snippet,
            //             color: Colors.white24, size: 30),
            //       ),
            //       const SizedBox(width: 20),
            //       // const Expanded(
            //       //   child: Column(
            //       //     children: [
            //       //       Row(
            //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       //         children: [
            //       //           Text('PERIOD',
            //       //               style: TextStyle(
            //       //                   color: Colors.grey, fontSize: 12)),
            //       //           Text('Oct 1 - Oct 18',
            //       //               style: TextStyle(
            //       //                   color: Colors.white,
            //       //                   fontWeight: FontWeight.bold)),
            //       //         ],
            //       //       ),
            //       //       SizedBox(height: 10),
            //       //       Row(
            //       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       //         children: [
            //       //           Text('FORMAT',
            //       //               style: TextStyle(
            //       //                   color: Colors.grey, fontSize: 12)),
            //       //           Text('PDF',
            //       //               style: TextStyle(
            //       //                   color: Colors.white,
            //       //                   fontWeight: FontWeight.bold)),
            //       //         ],
            //       //       ),
            //       //     ],
            //       //   ),
            //       // )
            //     ],
            //   ),
            // ),
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
                  List<TransactionModel> finalTransactionsToReport = [];

                  for (var ledger in _dbLedgers) {
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
      style: TextStyle(
        color: cyanAccent,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTimeframeOption(String title) {
    bool isSelected = selectedTimeframe == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTimeframe = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? cyanAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
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
          color: isSelected ? Colors.teal.withOpacity(0.1) : cardColor,
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

  Widget _buildReportTypeCard(String title, IconData icon) {
    bool isSelected = selectedReportType == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedReportType = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? cyanAccent : cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}