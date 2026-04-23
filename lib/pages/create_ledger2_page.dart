import 'package:flutter/material.dart';

class CreateLedger2Page extends StatefulWidget {
  const CreateLedger2Page({super.key});

  @override
  State<CreateLedger2Page> createState() => _LedgerDashboardPageState();
}

class _LedgerDashboardPageState extends State<CreateLedger2Page> {
  int _selectedTab = 1;
  int _selectedPeriod = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0B141A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildIncomeExpenseToggle(),
              const SizedBox(height: 40),
              _buildDonutChart(),
              const SizedBox(height: 40),
              _buildRemainingBalanceCard(),
              const SizedBox(height: 24),
              _buildPeriodFilters(),
              const SizedBox(height: 32),
              _buildCollaboratorsSection(),
              const SizedBox(height: 32),
              const Text(
                'CATEGORIES',
                style: TextStyle(
                  color: Color(0xFF7A8D9C),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              _buildCategoriesGrid(),
              const SizedBox(height: 30),
              _buildAddTransactionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'April 10 - April 19, 2026',
              style: TextStyle(
                color: Color(0xFF7A8D9C),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF15202B),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.nightlight_round,
                  color: Colors.white54, size: 20),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE5A985),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildIncomeExpenseToggle() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF15202B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTab == 0
                      ?  Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Income',
                  style: TextStyle(
                    color: _selectedTab == 0
                        ? Colors.black
                        : const Color(0xFF7A8D9C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedTab == 1
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _selectedTab == 1
                      ? [
                          BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.3),
                              blurRadius: 8)
                        ]
                      : [],
                ),
                child: Text(
                  'Expenses',
                  style: TextStyle(
                    color: _selectedTab == 1
                        ? Colors.black
                        : const Color(0xFF7A8D9C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonutChart() {
    return const Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 12,
              color: Color(0xFF15202B),
            ),
          ),

          // SizedBox(
          //   width: 200,
          //   height: 200,
          //   child: CircularProgressIndicator(
          //     value: 0.35,
          //     strokeWidth: 12,
          //     color: Color(0xFFFF52A2),
          //     backgroundColor: Colors.transparent,
          //   ),
          // ),

          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: 0.8,
              strokeWidth: 12,
              color: Colors.blue,
              backgroundColor: Colors.transparent,
            ),
          ),
          // Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TOTAL SPENT',
                style: TextStyle(
                  color: Color(0xFF7A8D9C),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Rs.20,000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRemainingBalanceCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REMAINING BALANCE',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Rs.15,000',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance_wallet,
                color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodFilters() {
    final filters = ['Today', 'Monthly', 'Custom Period'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(filters.length, (index) {
        bool isSelected = _selectedPeriod == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedPeriod = index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ?  Colors.blue
                  : const Color(0xFF15202B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              filters[index],
              style: TextStyle(
                color: isSelected
                    ? Colors.black
                    : const Color(0xFF7A8D9C),
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCollaboratorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'COLLABORATORS',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              '4 Total',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 130, // Space for overlapping avatars
              height: 40,
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    child: CircleAvatar(
                        radius: 20, backgroundColor: Color(0xFF7A9B8D)),
                  ),
                  Positioned(
                    left: 25,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 18, backgroundColor: Colors.grey[200]),
                    ),
                  ),
                  const Positioned(
                    left: 50,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 18, backgroundColor: Color(0xFFE5DECC)),
                    ),
                  ),
                  Positioned(
                    left: 75,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B141A),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF2A3948), width: 2),
                      ),
                      child: const Icon(Icons.add,
                          color: Color(0xFF7A8D9C), size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,

      children: [
        _buildCategoryCard(
          title: 'Transport',
          subtitle: 'EXPENSE',
          amount: 'Rs 2,000',
          icon: Icons.train,
          iconBgColor: const Color(0xFF3D271D),
          iconColor: const Color(0xFFFF8A65),
        ),
        _buildCategoryCard(
          title: 'Food',
          subtitle: 'EXPENSE',
          amount: 'Rs 500',
          icon: Icons.restaurant,
          iconBgColor: const Color(0xFF103036),
          iconColor: const Color(0xFF00E5FF),
        ),
        _buildCategoryCard(
          title: 'Stay',
          subtitle: 'EXPENSE',
          amount: 'Rs 5,000',
          icon: Icons.bed,
          iconBgColor: const Color(0xFF2D1B36),
          iconColor: const Color(0xFFB388FF),
        ),
        _buildCategoryCard(
          title: 'Income',
          subtitle: 'BUDGET',
          amount: 'Rs 8,000',
          icon: Icons.payments,
          iconBgColor: const Color(0xFF1B362A),
          iconColor: const Color(0xFF69F0AE),
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String amount,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF15202B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF7A8D9C),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddTransactionButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color:  Colors.blue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, color: Colors.black, size: 20),
            SizedBox(width: 8),
            Text(
              'Add Transaction',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
