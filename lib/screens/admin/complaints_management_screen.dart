import 'package:flutter/material.dart';
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

  final List<Map<String, dynamic>> _allComplaints = [
    {
      "name": "Ethan Walker",
      "room": "ROOM 402 • PLUMBING",
      "description":
          '"The bathroom sink has a significant leak since morning. It\'s flooding the floor slightly and..."',
      "urgent": true,
      "accepted": false,
      "inProgress": false,
      "status": "Pending",
      "statusBg": const Color(0xFFEEF2FF),
      "statusColor": const Color(0xFF4338CA),
      "assignedTo": null,
      "imageUrl": "https://images.unsplash.com/photo-1584622650111-993a426fbf0a",
    },
    {
      "name": "Maya Rodriguez",
      "room": "ROOM 215 • ELECTRICAL",
      "description":
          '"The main ceiling light keeps flickering. It\'s making it hard to study during the night. Hav..."',
      "urgent": false,
      "accepted": true,
      "inProgress": true,
      "status": "In Progress",
      "statusBg": const Color(0xFFFFEDD5),
      "statusColor": const Color(0xFFC2410C),
      "assignedTo": "Assigned: Sam Johnson",
      "imageUrl": "https://images.unsplash.com/photo-1513694203232-719a280e022f",
    },
    {
      "name": "Liam Chen",
      "room": "ROOM 108 • FURNITURE",
      "description":
          '"The study desk has a large crack on the right corner. Might be a safety hazard for my..."',
      "urgent": false,
      "accepted": true,
      "inProgress": false,
      "status": "Accepted",
      "statusBg": const Color(0xFFF1F5F9),
      "statusColor": const Color(0xFF475569),
      "assignedTo": null,
      "imageUrl": "https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd",
    },
  ];

  List<Map<String, dynamic>> get _filteredComplaints {
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
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
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
              "Resolve student issues promptly to maintain satisfaction.",
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search by student or room...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              ),
            ),
            const SizedBox(height: 12),

            // Category Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip("All Cases"),
                  _buildFilterChip("Pending"),
                  _buildFilterChip("Accepted"),
                  _buildFilterChip("In Progress"),
                  _buildFilterChip("In Completed"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _filteredComplaints.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Text(
                        "No complaints found for this status.",
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                      ),
                    ),
                  )
                : Column(
                    children: _filteredComplaints.map((item) {
                      return _buildComplaintCard(
                        name: item["name"],
                        room: item["room"],
                        description: item["description"],
                        urgent: item["urgent"] ?? false,
                        accepted: item["accepted"] ?? false,
                        inProgress: item["inProgress"] ?? false,
                        status: item["status"],
                        statusBg: item["statusBg"],
                        statusColor: item["statusColor"],
                        assignedTo: item["assignedTo"],
                        imageUrl: item["imageUrl"],
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),

      // 🚀 Floating Action Button connected to LogNewComplaintScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E3A8A),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogNewComplaintScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: _buildBottomNav(context),
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
    bool accepted = false,
    bool inProgress = false,
    String? status,
    Color? statusBg,
    Color? statusColor,
    String? assignedTo,
  }) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 50),
                ),
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
                        if (accepted)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "ACCEPTED",
                              style: TextStyle(
                                color: Color(0xFF166534),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (inProgress)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEDD5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "In Progress",
                              style: TextStyle(
                                color: Color(0xFFC2410C),
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
              if (status != null && !inProgress && !accepted)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
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
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              if (assignedTo != null)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 10,
                          backgroundColor: Color(0xFF1E3A8A),
                          child: Text(
                            "SJ",
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            assignedTo,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF334155),
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined,
                        size: 16, color: Colors.white),
                    label: const Text(
                      "Assign Staff",
                      style: TextStyle(
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_outline,
                      size: 18, color: Color(0xFF1E293B)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: const [
          Icon(Icons.grid_view_rounded, color: Color(0xFF2563EB)),
          SizedBox(width: 8),
          Text(
            "HostelMate",
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF047857)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_tree_outlined,
                color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.insert_chart_outlined,
                color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}