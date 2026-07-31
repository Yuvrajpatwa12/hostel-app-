import 'package:flutter/material.dart';

class PendingApprovalsScreen extends StatefulWidget {
  const PendingApprovalsScreen({super.key});

  @override
  State<PendingApprovalsScreen> createState() => _PendingApprovalsScreenState();
}

class _PendingApprovalsScreenState extends State<PendingApprovalsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ["All", "Newest", "Urgent", "Re-submissions"];

  String _searchQuery = "";
  String _advancedFilter = "All"; // Modal filter ko lagi

  // 🎯 Mock Data List
  final List<Map<String, dynamic>> _allApprovals = [
    {
      "name": "Aaryan Sharma",
      "timeAgo": "2h ago",
      "roomNo": "ROOM 304",
      "studentId": "HM-2024-8821",
      "avatarUrl": "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200&auto=format&fit=crop",
      "isUrgent": false,
      "type": "Newest",
      "tags": [
        _TagData("ID Verified", true),
        _TagData("Fee Paid", true),
        _TagData("Docs Uploaded", true),
      ],
    },
    {
      "name": "Ananya Patel",
      "timeAgo": "Pending 2 Days",
      "roomNo": "ROOM 102",
      "studentId": "HM-2024-9120",
      "avatarUrl": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop",
      "isUrgent": true,
      "type": "Urgent",
      "tags": [
        _TagData("ID Verified", true),
        _TagData("Fee Pending", false, isWarning: true),
        _TagData("Docs Uploaded", true),
      ],
    },
    {
      "name": "Rohan Verma",
      "timeAgo": "5h ago",
      "roomNo": "ROOM 405",
      "studentId": "HM-2024-7742",
      "avatarUrl": null,
      "isUrgent": false,
      "type": "Re-submissions",
      "tags": [
        _TagData("ID Rejected", false, isRejected: true),
        _TagData("Fee Paid", true),
        _TagData("Docs Uploaded", true),
      ],
    },
    {
      "name": "Sita Thapa",
      "timeAgo": "1d ago",
      "roomNo": "ROOM 201",
      "studentId": "HM-2024-5511",
      "avatarUrl": null,
      "isUrgent": true,
      "type": "Urgent",
      "tags": [
        _TagData("ID Verified", true),
        _TagData("Fee Pending", false, isWarning: true),
      ],
    },
  ];

  // 🎯 Filter Logic: Chip, Search Bar ra Bottom Sheet Filter dynamic banaune
  List<Map<String, dynamic>> get _filteredApprovals {
    return _allApprovals.where((item) {
      final selectedCategory = _filters[_selectedFilterIndex];

      // 1. Filter Chip Selection
      bool matchesChip = true;
      if (selectedCategory == "Urgent") {
        matchesChip = item["isUrgent"] == true;
      } else if (selectedCategory == "Re-submissions") {
        matchesChip = item["type"] == "Re-submissions";
      } else if (selectedCategory == "Newest") {
        matchesChip = item["type"] == "Newest";
      }

      // 2. Search Bar Query
      bool matchesSearch = item["name"].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item["studentId"].toString().toLowerCase().contains(_searchQuery.toLowerCase());

      // 3. Advanced Modal Filter
      bool matchesAdvanced = true;
      if (_advancedFilter == "Fee Pending") {
        matchesAdvanced = (item["tags"] as List<_TagData>).any((tag) => tag.isWarning);
      } else if (_advancedFilter == "ID Rejected") {
        matchesAdvanced = (item["tags"] as List<_TagData>).any((tag) => tag.isRejected);
      }

      return matchesChip && matchesSearch && matchesAdvanced;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _filteredApprovals;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: 12),

            // Filter Chips
            _buildFilterChips(),
            const SizedBox(height: 16),

            // Dynamic Approval List Display
            if (displayList.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    "No pending approvals found.",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final item = displayList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: _buildApprovalCard(
                      name: item["name"],
                      timeAgo: item["timeAgo"],
                      roomNo: item["roomNo"],
                      studentId: item["studentId"],
                      avatarUrl: item["avatarUrl"],
                      isUrgent: item["isUrgent"],
                      tags: item["tags"],
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // AppBar Component
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: const Text(
        "Pending Approvals",
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF0F2C59),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${_filteredApprovals.length} Pending",
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        const Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33'),
          ),
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          hintText: "Search by Student Name or ID...",
          hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          prefixIcon: Icon(Icons.search, color: Color(0xFF64748B), size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // Filter Chips Row
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(_filters.length, (index) {
            bool isSelected = _selectedFilterIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(_filters[index]),
                selected: isSelected,
                selectedColor: const Color(0xFF2563EB),
                backgroundColor: const Color(0xFFE2E8F0),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide.none,
                ),
                showCheckmark: false,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilterIndex = index;
                  });
                },
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed: _showFilterBottomSheet, // 🎯 Filter Button Click Handling
            icon: const Icon(Icons.tune, size: 14, color: Color(0xFF475569)),
            label: Text(
              _advancedFilter == "All" ? "Filter" : "Filter: $_advancedFilter",
              style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: _advancedFilter != "All" ? const Color(0xFFDBEAFE) : const Color(0xFFE2E8F0),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 Filter Option Modal Bottom Sheet
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filter Approvals By",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text("Show All"),
                trailing: _advancedFilter == "All" ? const Icon(Icons.check, color: Color(0xFF2563EB)) : null,
                onTap: () {
                  setState(() => _advancedFilter = "All");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Fee Pending Only"),
                trailing: _advancedFilter == "Fee Pending" ? const Icon(Icons.check, color: Color(0xFF2563EB)) : null,
                onTap: () {
                  setState(() => _advancedFilter = "Fee Pending");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("ID Rejected Only"),
                trailing: _advancedFilter == "ID Rejected" ? const Icon(Icons.check, color: Color(0xFF2563EB)) : null,
                onTap: () {
                  setState(() => _advancedFilter = "ID Rejected");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Main Card Design Component
  Widget _buildApprovalCard({
    required String name,
    required String timeAgo,
    required String roomNo,
    required String studentId,
    required List<_TagData> tags,
    String? avatarUrl,
    bool isUrgent = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUrgent ? const Color(0xFFFCA5A5) : const Color(0xFFE2E8F0),
          width: isUrgent ? 1.5 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            border: isUrgent
                ? const Border(left: BorderSide(color: Color(0xFFDC2626), width: 4))
                : null,
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFEEF2FF),
                    backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                    child: avatarUrl == null
                        ? const Icon(Icons.person_outline, color: Color(0xFF64748B))
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            if (isUrgent) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDC2626),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "URGENT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ]
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.meeting_room_outlined, size: 12, color: Color(0xFF64748B)),
                            const SizedBox(width: 2),
                            Text(
                              roomNo,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                            ),
                            const Text("  |  ", style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
                            Text(
                              studentId,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isUrgent ? const Color(0xFFFEE2E2) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isUrgent ? const Color(0xFF991B1B) : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Status Tags
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
              const SizedBox(height: 14),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF057A55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.person_add_alt_1_outlined, size: 16, color: Colors.white),
                      label: const Text("Approve", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEE2E2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.person_remove_outlined, size: 16, color: Color(0xFF991B1B)),
                      label: const Text("Reject", style: TextStyle(color: Color(0xFF991B1B), fontWeight: FontWeight.bold, fontSize: 13)),
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

  // Tag Component Generator
  Widget _buildTag(_TagData tag) {
    Color bgColor = const Color(0xFFECFDF5);
    Color textColor = const Color(0xFF047857);
    IconData icon = Icons.check_circle_outline;

    if (tag.isWarning) {
      bgColor = const Color(0xFFFFF1F2);
      textColor = const Color(0xFFBE123C);
      icon = Icons.error_outline;
    } else if (tag.isRejected) {
      bgColor = const Color(0xFFFFF1F2);
      textColor = const Color(0xFFBE123C);
      icon = Icons.cancel_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            tag.label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}

// Data holder class for Tags
class _TagData {
  final String label;
  final bool isSuccess;
  final bool isWarning;
  final bool isRejected;

  _TagData(this.label, this.isSuccess, {this.isWarning = false, this.isRejected = false});
}