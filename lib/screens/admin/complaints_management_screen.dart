import 'package:flutter/material.dart';
import 'api_service.dart';
import 'log_new_complaint_screen.dart';

class ComplaintsManagementScreen extends StatefulWidget {
  const ComplaintsManagementScreen({super.key});

  @override
  State<ComplaintsManagementScreen> createState() =>
      _ComplaintsManagementScreenState();
}

class _ComplaintsManagementScreenState
    extends State<ComplaintsManagementScreen> {
  String _selectedFilter = "All Cases";
  List<dynamic> _allComplaints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComplaintsData();
  }

  Future<void> _fetchComplaintsData() async {
    setState(() => _isLoading = true);
    try {
      final complaints = await ApiService.fetchComplaints();
      setState(() {
        _allComplaints = complaints;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching complaints: $e");
      setState(() => _isLoading = false);
    }
  }

  List<dynamic> get _filteredComplaints {
    if (_selectedFilter == "All Cases") {
      return _allComplaints;
    }
    return _allComplaints.where((complaint) {
      return complaint["status"].toString().toLowerCase() ==
          _selectedFilter.toLowerCase();
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Complaints",
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)),
            onPressed: _fetchComplaintsData,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : RefreshIndicator(
        onRefresh: _fetchComplaintsData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Manage Complaints",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 4),
              const Text(
                "Resolve student issues promptly from Hostinger Database.",
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),

              // Category Filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip("All Cases"),
                    _buildFilterChip("Pending"),
                    _buildFilterChip("Accepted"),
                    _buildFilterChip("In Progress"),
                    _buildFilterChip("Resolved"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              _filteredComplaints.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Text(
                          "No complaints found.",
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                        ),
                      ),
                    )
                  : Column(
                      children: _filteredComplaints.map((item) {
                        return _buildComplaintCard(
                          name: item["student_name"] ?? "Anonymous",
                          room: "ROOM ${item['room_no'] ?? 'N/A'} • ${item['category'] ?? 'GENERAL'}",
                          description: item["description"] ?? "No description provided.",
                          urgent: (item["priority"]?.toString().toLowerCase() == 'high'),
                          status: item["status"] ?? "Pending",
                          assignedTo: item["assigned_staff"],
                          imageUrl: item["student_image"] ?? "https://i.pravatar.cc/100?img=12",
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E3A8A),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogNewComplaintScreen(),
            ),
          );
          if (result == true) _fetchComplaintsData();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintCard({
    required String name,
    required String room,
    required String description,
    required String imageUrl,
    bool urgent = false,
    String? status,
    String? assignedTo,
  }) {
    Color statusColor = const Color(0xFF4338CA);
    Color statusBg = const Color(0xFFEEF2FF);

    if (status?.toLowerCase() == 'in progress') {
      statusColor = const Color(0xFFC2410C);
      statusBg = const Color(0xFFFFEDD5);
    } else if (status?.toLowerCase() == 'resolved') {
      statusColor = const Color(0xFF166534);
      statusBg = const Color(0xFFDCFCE7);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        if (urgent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "URGENT",
                              style: TextStyle(
                                color: Color(0xFFDC2626),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status ?? "Pending",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.person_add_outlined,
                      size: 16, color: Colors.white),
                  label: Text(
                    assignedTo ?? "Assign Staff",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6EE7B7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline,
                      size: 16, color: Color(0xFF065F46)),
                  label: const Text(
                    "Resolve",
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
