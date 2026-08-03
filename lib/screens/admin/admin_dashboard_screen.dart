import 'package:flutter/material.dart';
import 'api_service.dart';
import 'room_management_screen.dart';
import 'student_management_screen.dart';
import 'complaints_management_screen.dart';
import 'notice_management_screen.dart';
import 'pending_approvals_screen.dart'; // Added this
import 'referral_management_screen.dart';
import 'fee_management_screen.dart'; // Added this
import 'menu_management_screen.dart';
import 'sos_emergency_screen.dart';
import '../dashboard/profile_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  final String userId;
  const AdminDashboardScreen({super.key, this.userId = '1'});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  Map<String, dynamic> _stats = {};
  List<dynamic> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      final statsData = await ApiService.fetchDashboardStats();
      final activitiesData = await ApiService.fetchActivities();
      setState(() {
        _stats = statsData;
        _activities = activitiesData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(userId: widget.userId)));
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'),
              ),
            ),
            const SizedBox(width: 10),
            const Text("HostelMate Admin", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A)), onPressed: _loadDashboardData),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB)))
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Quick Summary 👋", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const SizedBox(height: 4),
                    const Text("Overview of your hostel management system.", style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                    const SizedBox(height: 20),

                    // Stats Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildStatCard("Total Students", "${_stats['total_students'] ?? '0'}", Icons.groups_outlined, const Color(0xFF4F46E5)),
                        _buildStatCard("Active Users", "${_stats['active_users'] ?? '0'}", Icons.person_outline, const Color(0xFF10B981)),
                        _buildStatCard("Attendance", "${_stats['attendance'] ?? '0%'}", Icons.tune, const Color(0xFFF59E0B)),
                        _buildStatCard("Pending Issues", "${_stats['pending_complaints'] ?? '0'}", Icons.error_outline, const Color(0xFFEF4444)),
                      ],
                    ),

                    const SizedBox(height: 28),
                    const Text("Management Hub", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildModuleTile("Students", Icons.school_outlined, const Color(0xFF2563EB), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentManagementScreen()))),
                        _buildModuleTile("Rooms", Icons.king_bed_outlined, const Color(0xFF10B981), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomManagementScreen()))),
                        _buildModuleTile("Complaints", Icons.chat_bubble_outline, const Color(0xFFB91C1C), showBadge: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComplaintsManagementScreen()))),
                        _buildModuleTile("Notices", Icons.campaign_outlined, const Color(0xFFD97706), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NoticeManagementScreen()))),
                        _buildModuleTile("Menu", Icons.fastfood_outlined, const Color(0xFF059669), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuManagementScreen()))),
                        _buildModuleTile("Referrals", Icons.card_giftcard, const Color(0xFF8B5CF6), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReferralManagementScreen()))),
                        _buildModuleTile("Approvals", Icons.verified_user_outlined, const Color(0xFF0F2C59), showBadge: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PendingApprovalsScreen()))),
                        _buildModuleTile("Fees", Icons.payments_outlined, const Color(0xFF10B981), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeeManagementScreen()))),
                        _buildModuleTile("SOS", Icons.emergency_outlined, const Color(0xFFDC2626), isSos: true, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SosEmergencyScreen()))),
                      ],
                    ),

                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                        TextButton(onPressed: _loadDashboardData, child: const Text("See All", style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Activity List
                    _activities.isEmpty
                        ? _buildEmptyActivity()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _activities.length,
                            itemBuilder: (context, index) {
                              final act = _activities[index];
                              return _buildActivityItem(
                                title: act['title'] ?? 'Activity',
                                subtitle: act['subtitle'] ?? '',
                                time: act['time'] ?? 'Just now',
                                type: act['icon_type'] ?? 'info',
                              );
                            },
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 18, backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color, size: 18)),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildModuleTile(String title, IconData icon, Color color, {bool isSos = false, bool showBadge = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(color: isSos ? const Color(0xFFB91C1C) : Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: isSos ? Colors.white : color, size: 24),
                  const SizedBox(height: 6),
                  Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isSos ? Colors.white : const Color(0xFF334155))),
                ],
              ),
            ),
            if (showBadge) Positioned(top: 8, right: 8, child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({required String title, required String subtitle, required String time, required String type}) {
    IconData icon = Icons.notifications_active_outlined;
    Color iconColor = const Color(0xFF4F46E5);
    
    if (type == 'booking') {
      icon = Icons.bookmark_added_outlined;
      iconColor = const Color(0xFF10B981);
    } else if (type == 'complaint') {
      icon = Icons.warning_amber_rounded;
      iconColor = const Color(0xFFEF4444);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildEmptyActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: const Column(
        children: [
          Icon(Icons.history_rounded, size: 40, color: Color(0xFFCBD5E1)),
          SizedBox(height: 12),
          Text("No recent activities found.", style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
        ],
      ),
    );
  }
}
