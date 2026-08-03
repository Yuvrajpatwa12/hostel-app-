import 'package:flutter/material.dart';
import 'api_service.dart';

class PendingApprovalsScreen extends StatefulWidget {
  const PendingApprovalsScreen({super.key});

  @override
  State<PendingApprovalsScreen> createState() => _PendingApprovalsScreenState();
}

class _PendingApprovalsScreenState extends State<PendingApprovalsScreen> {
  List<dynamic> _bookings = [];
  bool _isLoading = true;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() => _isLoading = true);
    try {
      final data = await ApiService.fetchAllBookings();
      setState(() {
        _bookings = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleStatusUpdate(int id, String status, String roomNo) async {
    setState(() => _isLoading = true);
    final result = await ApiService.updateBookingStatus(id, status, roomNo);
    if (mounted) {
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Request $status!"),
            backgroundColor: status == 'Approved' ? Colors.green : Colors.red));
        _fetchBookings();
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${result['message']}")));
      }
    }
  }

  void _showBookingDetails(dynamic request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Student Details",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
              const Divider(height: 32),
              _detailItem("Full Name", request['student_name']),
              _detailItem("Relation", request['applicant_relation']),
              _detailItem("Phone", request['phone']),
              _detailItem("Parent/Guardian", request['parent_name']),
              _detailItem("Address", request['address']),
              _detailItem("School/College", request['school_college']),
              _detailItem("Purpose", request['purpose']),
              const SizedBox(height: 30),
              if (request['status'] == 'Pending')
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14)),
                        onPressed: () {
                          Navigator.pop(context);
                          _handleStatusUpdate(
                              int.parse(request['id'].toString()),
                              'Approved',
                              request['room_no'].toString());
                        },
                        child: const Text("Approve Now",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 14)),
                        onPressed: () {
                          Navigator.pop(context);
                          _handleStatusUpdate(
                              int.parse(request['id'].toString()),
                              'Rejected',
                              request['room_no'].toString());
                        },
                        child: const Text("Reject",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value ?? "N/A",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  List<dynamic> get _filteredList {
    return _bookings.where((b) {
      return b['student_name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          b['room_no'].toString().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
            onPressed: () => Navigator.pop(context)),
        title: const Text("Booking Approvals",
            style: TextStyle(
                color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)),
              onPressed: _fetchBookings)
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: "Search student or room...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchBookings,
                    child: _filteredList.isEmpty
                        ? const Center(child: Text("No requests found."))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _filteredList.length,
                            itemBuilder: (context, index) =>
                                _buildRequestCard(_filteredList[index]),
                          ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRequestCard(dynamic request) {
    String status = request['status'] ?? 'Pending';
    bool isPending = status == 'Pending';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(request['student_name'] ?? 'Unknown',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              _statusBadge(status),
            ],
          ),
          const SizedBox(height: 8),
          Text("Room No: ${request['room_no']}",
              style: const TextStyle(
                  color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
          Text("Phone: ${request['phone']}",
              style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showBookingDetails(request),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("View Details", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              if (isPending) ...[
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _handleStatusUpdate(
                      int.parse(request['id'].toString()),
                      'Approved',
                      request['room_no'].toString()),
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  tooltip: "Quick Approve",
                ),
                IconButton(
                  onPressed: () => _handleStatusUpdate(
                      int.parse(request['id'].toString()),
                      'Rejected',
                      request['room_no'].toString()),
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  tooltip: "Quick Reject",
                ),
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color = Colors.orange;
    if (status == 'Approved') color = Colors.green;
    if (status == 'Rejected') color = Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
