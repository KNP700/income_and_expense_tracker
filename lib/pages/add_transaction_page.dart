import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool isExpense = true;
  String selectedPayer = 'Me';
  String selectedCategory = 'FOOD';
  String paymentMethod = 'CASH';

  final Color bgColor = const Color(0xFF0D171C);
  final Color cardColor = const Color(0xFF15202B);
  final Color cyanAccent = const Color(0xFF00E5FF);
  final Color redAccent = const Color(0xFFFF5252);
  final Color textGrey = const Color(0xFF7A8D9C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'New Transaction',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: cyanAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAmountSection(),
                    const SizedBox(height: 32),
                    _buildSectionLabel('TRANSACTION TYPE'),
                    const SizedBox(height: 12),
                    _buildTransactionTypeToggle(),
                    const SizedBox(height: 32),
                    _buildSectionLabel('PAID BY'),
                    const SizedBox(height: 12),
                    _buildPaidBySection(),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionLabel('CATEGORY'),
                        Text(
                          'See All',
                          style: TextStyle(
                            color: cyanAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCategorySection(),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(child: _buildSectionLabel('PAYMENT METHOD')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildSectionLabel('RECEIPT')),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildPaymentMethodToggle()),
                        const SizedBox(width: 16),
                        Expanded(child: _buildReceiptButton()),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildSectionLabel('NOTES'),
                    const SizedBox(height: 12),
                    _buildNotesField(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: textGrey,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      children: [
        Text(
          'AMOUNT (JPY)',
          style: TextStyle(
            color: cyanAccent,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '¥',
              style: TextStyle(
                color: textGrey,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '12,500',
              style: TextStyle(
                color: Colors.white,
                fontSize: 56,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionTypeToggle() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isExpense = true),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isExpense ? redAccent.withOpacity(0.1) : cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isExpense ? redAccent : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_outward,
                      color: isExpense ? redAccent : textGrey, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'EXPENSE',
                    style: TextStyle(
                      color: isExpense ? redAccent : textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => isExpense = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: !isExpense ? cyanAccent.withOpacity(0.1) : cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: !isExpense ? cyanAccent : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.south_west,
                      color: !isExpense ? cyanAccent : textGrey, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'INCOME',
                    style: TextStyle(
                      color: !isExpense ? cyanAccent : textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaidBySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildPayerChip('Me', const Color(0xFFE5A985)),
          const SizedBox(width: 12),
          _buildPayerChip('Yuki', Colors.grey[400]!),
          const SizedBox(width: 12),
          _buildPayerChip('Kenji', Colors.white),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: textGrey, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPayerChip(String name, Color avatarColor) {
    bool isSelected = selectedPayer == name;
    return GestureDetector(
      onTap: () => setState(() => selectedPayer = name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? cyanAccent : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 12, backgroundColor: avatarColor),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? cyanAccent : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    final categories = [
      {'name': 'TRANSPORT', 'icon': Icons.directions_transit, 'color': const Color(0xFFFF8A65)},
      {'name': 'FOOD', 'icon': Icons.restaurant, 'color': cyanAccent},
      {'name': 'STAY', 'icon': Icons.bed, 'color': const Color(0xFFB388FF)},
      {'name': 'GIFT', 'icon': Icons.card_giftcard, 'color': const Color(0xFF69F0AE)},
      {'name': 'OTHER', 'icon': Icons.more_horiz, 'color': textGrey},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((cat) {
          bool isSelected = selectedCategory == cat['name'];
          Color catColor = cat['color'] as Color;

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = cat['name'] as String),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: isSelected ? catColor : cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isSelected
                          ? [BoxShadow(color: catColor.withOpacity(0.4), blurRadius: 12, spreadRadius: 2)]
                          : [],
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: isSelected ? Colors.black : catColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['name'] as String,
                    style: TextStyle(
                      color: isSelected ? catColor : textGrey,
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentMethodToggle() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => paymentMethod = 'CASH'),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: paymentMethod == 'CASH' ? cyanAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'CASH',
                  style: TextStyle(
                    color: paymentMethod == 'CASH' ? Colors.black : textGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => paymentMethod = 'CARD'),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: paymentMethod == 'CARD' ? cyanAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'CARD',
                  style: TextStyle(
                    color: paymentMethod == 'CARD' ? Colors.black : textGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: textGrey.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt, color: textGrey, size: 18),
          const SizedBox(width: 8),
          Text(
            'PHOTO',
            style: TextStyle(
              color: textGrey,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        maxLines: 4,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Add details about this expense...',
          hintStyle: TextStyle(color: textGrey.withOpacity(0.6), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            bgColor,
            bgColor.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: cyanAccent,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Save Transaction',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}