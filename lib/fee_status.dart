import 'package:flutter/material.dart';

class FeeStatusScreen extends StatefulWidget {
  const FeeStatusScreen({super.key});

  @override
  State<FeeStatusScreen> createState() => _FeeStatusScreenState();
}

class FeeTransaction {
  final String transactionId;
  final String monthTitle;
  final double amount;
  final DateTime paidDate;
  final String paymentMethod;
  final String status;

  FeeTransaction({
    required this.transactionId,
    required this.monthTitle,
    required this.amount,
    required this.paidDate,
    required this.paymentMethod,
    required this.status,
  });
}

class UpcomingFeeModel {
  final String title;
  final DateTime joinDate;
  final DateTime dueDate;
  final double amount;
  final bool isPaid;

  UpcomingFeeModel({
    required this.title,
    required this.joinDate,
    required this.dueDate,
    required this.amount,
    required this.isPaid,
  });

  bool get isWarningDue {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return !isPaid && difference <= 2 && difference >= 0;
  }

  bool get isOverdue {
    final now = DateTime.now();
    return !isPaid && now.isAfter(dueDate);
  }
}

class _FeeStatusScreenState extends State<FeeStatusScreen> {
  int _selectedTab = 0; // 0 for Upcoming Dues, 1 for Paid History

  // Sample Paid History Data (Managed by Admin)
  final List<FeeTransaction> _paidHistory = [
    FeeTransaction(
      transactionId: 'TXN-984201',
      monthTitle: 'June 2026 Fee',
      amount: 4500.0,
      paidDate: DateTime(2026, 6, 14),
      paymentMethod: 'Khalti / Online Transfer',
      status: 'Verified by Admin',
    ),
    FeeTransaction(
      transactionId: 'TXN-763190',
      monthTitle: 'May 2026 Fee',
      amount: 4500.0,
      paidDate: DateTime(2026, 5, 15),
      paymentMethod: 'Cash to Warden',
      status: 'Verified by Admin',
    ),
    FeeTransaction(
      transactionId: 'TXN-542118',
      monthTitle: 'April 2026 Fee',
      amount: 4500.0,
      paidDate: DateTime(2026, 4, 15),
      paymentMethod: 'Cash to Warden',
      status: 'Verified by Admin',
    ),
  ];

  // Sample Upcoming Fee Data (Calculated based on join date cycle)
  final List<UpcomingFeeModel> _upcomingDues = [
    UpcomingFeeModel(
      title: 'July 2026 Fee Cycle',
      joinDate: DateTime(2026, 4, 15),
      dueDate: DateTime(2026, 7, 15),
      amount: 4500.0,
      isPaid: false,
    ),
    UpcomingFeeModel(
      title: 'August 2026 Fee Cycle',
      joinDate: DateTime(2026, 4, 15),
      dueDate: DateTime(2026, 8, 15),
      amount: 4500.0,
      isPaid: false,
    ),
  ];

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showDetailsBottomSheet(BuildContext context, {required String title, required List<Widget> details}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0), height: 1),
              const SizedBox(height: 16),
              ...details,
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Fee Status & History',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE2E8F0), height: 1),
        ),
      ),
      body: Column(
        children: [
          // TOP TAB SWITCHER (Upcoming Dues / Paid History)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 0 ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Upcoming Dues',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 0 ? Colors.white : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedTab == 1 ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Paid History',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 1 ? Colors.white : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // DYNAMIC BODY CONTENT BASED ON SELECTED TAB
          Expanded(
            child: _selectedTab == 0
                ? _buildUpcomingDuesView()
                : _buildPaidHistoryView(),
          ),
        ],
      ),
    );
  }

  // VIEW 1: UPCOMING DUES SECTION
  Widget _buildUpcomingDuesView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'UPCOMING & DUE FEES',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
          ),
          const SizedBox(height: 12),
          ..._upcomingDues.map((dueItem) {
            Color statusColor = const Color(0xFF2563EB);
            String statusText = 'Active Cycle';
            if (dueItem.isOverdue) {
              statusColor = const Color(0xFFDC2626);
              statusText = 'Overdue';
            } else if (dueItem.isWarningDue) {
              statusColor = const Color(0xFFD97706);
              statusText = 'Due Soon';
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: dueItem.isWarningDue || dueItem.isOverdue ? statusColor.withValues(alpha: 0.5) : const Color(0xFFE2E8F0),
                  width: dueItem.isWarningDue || dueItem.isOverdue ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 3)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dueItem.isWarningDue || dueItem.isOverdue) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, size: 18, color: statusColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                dueItem.isOverdue
                                    ? 'Alert: Fee payment is overdue! Please contact admin.'
                                    : 'Warning: Fee submission due in 2 days or less!',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: statusColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dueItem.title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Due Date: ${_formatDate(dueItem.dueDate)}',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: statusColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Monthly Rent Amount', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                        Text('NPR ${dueItem.amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _showDetailsBottomSheet(
                            context,
                            title: 'Due Details',
                            details: [
                              _buildDetailRow('Cycle Title', dueItem.title),
                              _buildDetailRow('Billing Amount', 'NPR ${dueItem.amount.toStringAsFixed(0)}'),
                              _buildDetailRow('Join Cycle Date', _formatDate(dueItem.joinDate)),
                              _buildDetailRow('Payment Due Date', _formatDate(dueItem.dueDate)),
                              _buildDetailRow('Status', statusText),
                              _buildDetailRow('Admin Verification', 'Pending Deposit'),
                            ],
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2563EB),
                          side: const BorderSide(color: Color(0xFF2563EB)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('View Full Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // VIEW 2: PAID HISTORY & STATEMENTS SECTION
  Widget _buildPaidHistoryView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PAID HISTORY & STATEMENTS',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
              ),
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading Full Fee Statement PDF...')),
                  );
                },
                icon: const Icon(Icons.download, size: 16, color: Color(0xFF2563EB)),
                label: const Text('Download Statement', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _paidHistory.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final txn = _paidHistory[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 22),
                  ),
                  title: Text(
                    txn.monthTitle,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'Paid on: ${_formatDate(txn.paidDate)}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'NPR ${txn.amount.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF16A34A)),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'View Details',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF2563EB)),
                      ),
                    ],
                  ),
                  onTap: () {
                    _showDetailsBottomSheet(
                      context,
                      title: 'Transaction Details',
                      details: [
                        _buildDetailRow('Transaction ID', txn.transactionId),
                        _buildDetailRow('Fee Month', txn.monthTitle),
                        _buildDetailRow('Paid Amount', 'NPR ${txn.amount.toStringAsFixed(0)}'),
                        _buildDetailRow('Payment Date', _formatDate(txn.paidDate)),
                        _buildDetailRow('Payment Mode', txn.paymentMethod),
                        _buildDetailRow('Verification Status', txn.status),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}