import 'package:flutter/material.dart';
import 'api_service.dart';
import 'create_notice_screen.dart';

class NoticeManagementScreen extends StatefulWidget {
  const NoticeManagementScreen({super.key});

  @override
  State<NoticeManagementScreen> createState() => _NoticeManagementScreenState();
}

class _NoticeManagementScreenState extends State<NoticeManagementScreen> {
  String _selectedFilter = "All Notices";
  List<dynamic> _allNotices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNoticesData();
  }

  Future<void> _fetchNoticesData() async {
    setState(() => _isLoading = true);
    try {
      final notices = await ApiService.fetchNotices();
      setState(() {
        _allNotices = notices;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching notices: $e");
      setState(() => _isLoading = false);
    }
  }

  List<dynamic> get _filteredNotices {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notice Board",
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)),
            onPressed: _fetchNoticesData,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator()) 
          : RefreshIndicator(
        onRefresh: _fetchNoticesData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                "Manage and broadcast updates from Hostinger Database.",
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),

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

              _filteredNotices.isEmpty
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    "No notices found.",
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
              )
                  : Column(
                children: _filteredNotices.map((notice) {
                  return _buildNoticeCard(
                    category: notice["category"] ?? "General",
                    date: notice["date"] ?? "Just now",
                    title: notice["title"] ?? "No Title",
                    desc: notice["description"] ?? "",
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
              builder: (context) => const CreateNoticeScreen(),
            ),
          );
          if (result == true) _fetchNoticesData();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildNoticeFilter(String label) {
    final bool active = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
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

  Widget _buildNoticeCard({
    required String category,
    required String date,
    required String title,
    required String desc,
  }) {
    IconData icon = Icons.campaign_outlined;
    Color iconBg = const Color(0xFFCBD5E1);
    Color badgeColor = const Color(0xFF166534);

    if (category.toLowerCase() == 'events') {
      icon = Icons.calendar_today_outlined;
      iconBg = const Color(0xFF818CF8);
    } else if (category.toLowerCase() == 'alerts') {
      icon = Icons.warning_amber_rounded;
      iconBg = const Color(0xFFFDBA74);
      badgeColor = const Color(0xFF9A3412);
    } else if (category.toLowerCase() == 'maintenance') {
      icon = Icons.build_outlined;
      iconBg = const Color(0xFF38BDF8);
    }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: badgeColor, size: 20),
              ),
              Text(date, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              category.toUpperCase(),
              style: TextStyle(
                color: badgeColor,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.edit_outlined, color: Color(0xFF1D4ED8), size: 18),
              SizedBox(width: 16),
              Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
            ],
          )
        ],
      ),
    );
  }
}
