import 'package:flutter/material.dart';
import 'api_service.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  
  Map<String, dynamic>? _foundStudent;
  List<dynamic> _feeHistory = [];
  bool _isSearching = false;
  bool _isSaving = false;
  String _selectedMonth = "January 2026";

  final List<String> _months = [
    "January 2025", "February 2025", "March 2025", "April 2025",
    "May 2025", "June 2025", "July 2025", "August 2025",
    "September 2025", "October 2025", "November 2025", "December 2025",
    "January 2026", "February 2026", "March 2026", "April 2026",
    "May 2026", "June 2026", "July 2026", "August 2026",
    "September 2026", "October 2026", "November 2026", "December 2026"
  ];

  Future<void> _searchStudent() async {
    if (_searchController.text.isEmpty) return;
    setState(() => _isSearching = true);
    final result = await ApiService.searchStudentByEmail(_searchController.text.trim());
    if (mounted) {
      setState(() {
        _foundStudent = result['success'] == true ? result['student'] : null;
        _feeHistory = result['success'] == true ? (result['fee_history'] ?? []) : [];
        _isSearching = false;
      });
      if (_foundStudent == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Student not found!")));
      }
    }
  }

  Future<void> _handleCollectFee() async {
    if (_foundStudent == null || _amountController.text.isEmpty || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all details!")));
      return;
    }

    setState(() => _isSaving = true);
    final result = await ApiService.collectFee({
      "user_id": _foundStudent!['id'],
      "amount": _amountController.text.trim(),
      "fee_month": _selectedMonth,
      "payment_date": _dateController.text.trim(),
    });

    if (mounted) {
      setState(() => _isSaving = false);
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fee Recorded Successfully! 🎉"), backgroundColor: Colors.green));
        _amountController.clear();
        _dateController.clear();
        _searchStudent(); // Refresh data to show new history
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${result['message']}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white, elevation: 0,
        title: const Text("Student Info & Fees", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            _buildSearchBox(),
            
            if (_foundStudent != null) ...[
              const SizedBox(height: 24),
              _buildProfileHeader(),
              const SizedBox(height: 24),
              
              // Fee Collection Form
              _buildFeeForm(),
              const SizedBox(height: 32),
              
              // Payment History Ledger
              const Text("Payment History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildFeeLedger(),
              const SizedBox(height: 32),
              
              // Personal Dossier
              const Text("Student Dossier", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildStudentDossier(),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search Student by Email...",
          prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF2563EB)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          suffixIcon: _isSearching 
            ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2))
            : IconButton(onPressed: _searchStudent, icon: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF2563EB))),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0F172A), Color(0xFF1E293B)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${_foundStudent!['email']}'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_foundStudent!['student_name_eng'] ?? "No Name", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_foundStudent!['email'] ?? "", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Text("Joined: ${_foundStudent!['joining_date'] ?? 'N/A'}", style: const TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
            child: const Text("ACTIVE", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Collect Payment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedMonth,
            items: _months.map((m) => DropdownMenuItem(value: m, child: Text(m, style: const TextStyle(fontSize: 14)))).toList(),
            onChanged: (v) => setState(() => _selectedMonth = v!),
            decoration: InputDecoration(labelText: "Billing Month", filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Amount (NPR)", prefixText: "₹ ", filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _dateController,
            onTap: () async {
              DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2024), lastDate: DateTime(2030));
              if (picked != null) setState(() => _dateController.text = "${picked.year}-${picked.month}-${picked.day}");
            },
            readOnly: true,
            decoration: InputDecoration(labelText: "Payment Date", prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18), filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: _isSaving ? null : _handleCollectFee,
            child: _isSaving ? const CircularProgressIndicator(color: Colors.white) : const Text("Approve Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeLedger() {
    if (_feeHistory.isEmpty) {
      return Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: const Text("No previous payments recorded.", style: TextStyle(color: Colors.grey, fontSize: 13)));
    }
    return Column(
      children: _feeHistory.map((fee) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(fee['fee_month'] ?? "Unknown Month", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Paid: ${fee['payment_date']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ])),
            Text("₹${fee['amount_paid']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildStudentDossier() {
    return Column(
      children: [
        _infoCard("Educational Background", [
          _infoTile("Institute", _foundStudent!['institute']),
          _infoTile("Study Level", _foundStudent!['level_of_study']),
          _infoTile("Class Time", _foundStudent!['class_time']),
        ]),
        const SizedBox(height: 16),
        _infoCard("Personal & Health", [
          _infoTile("DOB", _foundStudent!['dob']),
          _infoTile("Food Pref.", _foundStudent!['food_preference']),
          _infoTile("Disease/Note", _foundStudent!['disease'] ?? "None"),
        ]),
        const SizedBox(height: 16),
        _infoCard("Address Details", [
          _infoTile("District", _foundStudent!['district']),
          _infoTile("Ward / Street", "${_foundStudent!['ward']} / ${_foundStudent!['street']}"),
          _infoTile("Citizenship", _foundStudent!['citizenship']),
        ]),
        const SizedBox(height: 16),
        _infoCard("Guardian Contacts", [
          _infoTile("Father", "${_foundStudent!['father_name']} (${_foundStudent!['father_contact']})"),
          _infoTile("Mother", "${_foundStudent!['mother_name']} (${_foundStudent!['mother_contact']})"),
          _infoTile("Local G.", "${_foundStudent!['lg_name']} (${_foundStudent!['lg_contact']})"),
        ]),
      ],
    );
  }

  Widget _infoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _infoTile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          Flexible(child: Text(value ?? "N/A", textAlign: TextAlign.right, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)))),
        ],
      ),
    );
  }
}
