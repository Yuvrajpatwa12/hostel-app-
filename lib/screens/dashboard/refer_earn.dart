import 'dart:async';
import 'package:flutter/material.dart';
import '../admin/api_service.dart';

class ReferAndEarnScreen extends StatefulWidget {
  final String userId;
  const ReferAndEarnScreen({super.key, required this.userId});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  String _referralCode = "LOADING...";
  int _cashBalance = 0;
  List<dynamic> _myReferrals = [];
  bool _isLoading = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    final result = await ApiService.fetchReferralInfo(widget.userId);
    if (mounted) {
      setState(() {
        _referralCode = result['code'] ?? "ERROR";
        _cashBalance = result['points'] ?? 0;
        _myReferrals = result['referrals'] ?? [];
        _isLoading = false;
      });
    }
  }

  Future<void> _handleInvite() async {
    if (_emailController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill all details!")));
      return;
    }
    setState(() => _isLoading = true);
    final res = await ApiService.inviteFriend(widget.userId, _emailController.text, _phoneController.text);
    if (mounted) {
      if (res['success']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Step 1 Complete: Friend Invited!"), backgroundColor: Colors.green));
        _emailController.clear(); _phoneController.clear();
        _fetchData();
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? "Error")));
      }
    }
  }

  Future<void> _handleLinkCode() async {
    if (_codeController.text.isEmpty) return;
    setState(() => _isLoading = true);
    final res = await ApiService.applyReferralCode(widget.userId, _codeController.text);
    if (mounted) {
      if (res['success']) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Step 3 Complete: Code Linked!"), backgroundColor: Colors.green));
        _codeController.clear();
        _fetchData();
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? "Error")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20), onPressed: () => Navigator.pop(context)),
          title: const Text("Referral System", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17)),
          actions: [IconButton(icon: const Icon(Icons.refresh, color: Colors.blue), onPressed: _fetchData)],
          bottom: const TabBar(
            labelColor: Colors.blue, unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [Tab(text: "Invite Friend"), Tab(text: "Apply Code")],
          ),
        ),
        body: _isLoading ? const Center(child: CircularProgressIndicator()) : TabBarView(
          children: [
            _buildInviteTab(),
            _buildLinkTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildWalletHeader(),
        const SizedBox(height: 24),
        const Text("Invite a New Friend", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _inputField("Friend Email", _emailController, Icons.email_outlined),
        const SizedBox(height: 12),
        _inputField("Friend Phone", _phoneController, Icons.phone_android_outlined),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: _handleInvite,
          child: const Text("Send Step 1 Invite", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 32),
        const Text("Track Your Referrals", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ..._myReferrals.map((ref) => _buildStepperCard(ref)),
      ],
    );
  }

  Widget _buildLinkTab() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Enter Friend's Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("If a friend invited you, enter their code here to link Step 3.", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 24),
          _inputField("Referral Code", _codeController, Icons.qr_code_scanner),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: _handleLinkCode,
            child: const Text("Verify & Link Step 3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)]), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Wallet Balance", style: TextStyle(color: Colors.white70, fontSize: 12)),
          Text("₹$_cashBalance NPR", style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.white24, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Code: $_referralCode", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const Icon(Icons.copy, color: Colors.white70, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepperCard(dynamic ref) {
    int currentStep = ref['current_step'] ?? 1;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ref['friend_email'], style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stepDot("Invited", currentStep >= 1),
              _stepLine(currentStep >= 2),
              _stepDot("Joined", currentStep >= 2),
              _stepLine(currentStep >= 3),
              _stepDot("Linked", currentStep >= 3),
              _stepLine(currentStep >= 4),
              _stepDot("Earned", currentStep >= 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepDot(String label, bool active) {
    return Column(
      children: [
        CircleAvatar(radius: 6, backgroundColor: active ? Colors.green : Colors.grey.shade300),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 8, color: active ? Colors.green : Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _stepLine(bool active) {
    return Expanded(child: Container(height: 2, color: active ? Colors.green : Colors.grey.shade200));
  }

  Widget _inputField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label, prefixIcon: Icon(icon, size: 20),
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      ),
    );
  }
}
