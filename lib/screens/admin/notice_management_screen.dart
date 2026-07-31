import 'package:flutter/material.dart';
import 'create_notice_screen.dart';

class NoticeManagementScreen extends StatefulWidget {
  const NoticeManagementScreen({super.key});

  @override
  State<NoticeManagementScreen> createState() => _NoticeManagementScreenState();
}

class _NoticeManagementScreenState extends State<NoticeManagementScreen> {
  String _selectedFilter = "All Notices";

  // Dummy Master Data List
  final List<Map<String, dynamic>> _allNotices = [
    {
      "icon": Icons.calendar_today_outlined,
      "iconBg": const Color(0xFF818CF8),
      "category": "Events",
      "badgeText": "EVENT",
      "date": "Oct 24, 2023",
      "title": "Annual Cultural Night 2023",
      "desc": "Join us for a night of music, dance, and celebrations in the main quadrangle...",
      "badgeColor": null,
    },
    {
      "icon": Icons.warning_amber_rounded,
      "iconBg": const Color(0xFFFDBA74),
      "category": "Alerts",
      "badgeText": "ALERT",
      "date": "Oct 22, 2023",
      "title": "Water Supply Maintenance",
      "desc": "Emergency water tank cleaning scheduled for Block C. Drinking water canisters available...",
      "badgeColor": const Color(0xFF9A3412),
    },
    {
      "icon": Icons.campaign_outlined,
      "iconBg": const Color(0xFFCBD5E1),
      "category": "General",
      "badgeText": "GENERAL",
      "date": "Oct 20, 2023",
      "title": "New Laundry Facility Rules",
      "desc": "Please ensure all personal items are removed immediately after washing cycles...",
      "badgeColor": null,
    },
    {
      "icon": Icons.build_outlined,
      "iconBg": const Color(0xFF38BDF8),
      "category": "Maintenance",
      "badgeText": "MAINTENANCE",
      "date": "Oct 19, 2023",
      "title": "Elevator Maintenance (Block A)",
      "desc": "Routine safety inspection and lubrication of main hoist cables...",
      "badgeColor": null,
    },
    {
      "icon": Icons.flatware,
      "iconBg": const Color(0xFF818CF8),
      "category": "Events",
      "badgeText": "EVENT",
      "date": "Oct 18, 2023",
      "title": "International Food Festival",
      "desc": "Celebrate global cuisines with dishes prepared by hostel residents...",
      "badgeColor": null,
    },
  ];

  // Logic to filter list dynamically
  List<Map<String, dynamic>> get _filteredNotices {
    if (_selectedFilter == "All Notices") {
      return _allNotices;
    }
    return _allNotices
        .where((notice) =>
            notice['category'].toString().toLowerCase() ==
            _selectedFilter.toLowerCase())
        .toList();
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
              "Notice Management",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Manage and broadcast important updates to residents.",
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search notices by title or category...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Category Filter Buttons Bar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildNoticeFilter("All Notices"),
                  _buildNoticeFilter("Events"),
                  _buildNoticeFilter("Alerts"),
                  _buildNoticeFilter("Maintenance"),
                  _buildNoticeFilter("General"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Render Filtered Dynamic List Cards
            ..._filteredNotices.map((notice) {
              return _buildNoticeCard(
                notice["icon"],
                notice["iconBg"],
                notice["badgeText"],
                notice["date"],
                notice["title"],
                notice["desc"],
                badgeColor: notice["badgeColor"],
              );
            }),

            // Empty State message if list is empty
            if (_filteredNotices.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    "No notices found for this category.",
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ),
              )
          ],
        ),
      ),

      // 🚀 Connected FloatingActionButton to CreateNoticeScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E3A8A),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNoticeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // Interactive Filter Button Widget
  Widget _buildNoticeFilter(String label) {
    final bool active = _selectedFilter == label;

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
          color: active ? const Color(0xFF6EE7B7) : const Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFF065F46) : const Color(0xFF3B82F6),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeCard(
    IconData icon,
    Color iconBg,
    String badgeText,
    String date,
    String title,
    String desc, {
    Color? badgeColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: badgeColor ?? const Color(0xFF2563EB), size: 20),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: badgeColor ?? const Color(0xFF166534),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(date, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.remove_red_eye_outlined, color: Color(0xFF1E293B), size: 18),
              SizedBox(width: 16),
              Icon(Icons.edit_outlined, color: Color(0xFF1D4ED8), size: 18),
              SizedBox(width: 16),
              Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
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
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
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
            icon: const Icon(Icons.account_tree_outlined, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.insert_chart_outlined, color: Color(0xFF64748B)),
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