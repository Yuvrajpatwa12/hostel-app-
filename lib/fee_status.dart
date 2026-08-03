import 'package:flutter/material.dart';
import 'screens/admin/api_service.dart';

class FeeStatusScreen extends StatefulWidget {
  final String userId;
  const FeeStatusScreen({super.key, required this.userId});

  @override
  State<FeeStatusScreen> createState() => _FeeStatusScreenState();
}

class _FeeStatusScreenState extends State<FeeStatusScreen> {
  int _selectedTab = 0; 
  bool _isLoading = true;
  List<dynamic> _paidHistory = [];
  List<dynamic> _upcomingDues = [];

  @override
  void initState() {
    super.initState();
    _fetchFeeData();
  }

  Future<void> _fetchFeeData() async {
    setState(() => _isLoading = true);
    final result = await ApiService.fetchFeeStatus(widget.userId);
    if (mounted) {
      setState(() {
        _paidHistory = result['history'] ?? [];
        _upcomingDues = result['upcoming'] ?? [];
        _isLoading = false;
      });
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "N/A";
    try {
      DateTime date = DateTime.parse(dateStr);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Fee Status & History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A))),
        actions: [IconButton(icon: const Icon(Icons.refresh, color: Colors.blue), onPressed: _fetchFeeData)],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : Column(
        children: [
          _buildTabSwitcher(),
          Expanded(child: _selectedTab == 0 ? _buildUpcomingDuesView() : _buildPaidHistoryView()),
        ],
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          _tabItem("Upcoming Dues", 0),
          const SizedBox(width: 12),
          _tabItem("Paid History", 1),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: active ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.center,
          child: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: active ? Colors.white : const Color(0xFF64748B))),
        ),
      ),
    );
  }

  Widget _buildUpcomingDuesView() {
    if (_upcomingDues.isEmpty) {
      return const Center(child: Text("No pending dues found! 🎉", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _upcomingDues.length,
      itemBuilder: (context, index) {
        final due = _upcomingDues[index];
        bool isWarning = due['is_warning'] ?? false;
        Color statusColor = isWarning ? Colors.red : Colors.blue;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withValues(alpha: 0.3), width: isWarning ? 2 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWarning) ...[
                Row(children: [Icon(Icons.warning_amber_rounded, color: Colors.red, size: 18), const SizedBox(width: 8), const Text("Payment due in 3 days!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12))]),
                const SizedBox(height: 12),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(due['fee_month'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("Due: ${_formatDate(due['due_date'])}", style: TextStyle(fontSize: 12, color: statusColor, fontWeight: FontWeight.bold)),
                  ]),
                  Text("₹ ${due['amount']} NPR", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaidHistoryView() {
    if (_paidHistory.isEmpty) {
      return const Center(child: Text("No payment history yet."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _paidHistory.length,
      itemBuilder: (context, index) {
        final txn = _paidHistory[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
          child: Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFFF0FDF4), child: Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(txn['fee_month'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Paid on: ${_formatDate(txn['payment_date'])}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ]),
              ),
              Text("₹ ${txn['amount_paid']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
            ],
          ),
        );
      },
    );
  }
}
