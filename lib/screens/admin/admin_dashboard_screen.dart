import 'package:flutter/material.dart';

import 'room_management_screen.dart';
import 'student_management_screen.dart';
import 'complaints_management_screen.dart';
import 'notice_management_screen.dart';
import 'recipes_management_screen.dart';
import 'menu_management_screen.dart';
import 'health_management_screen.dart';
import 'sos_emergency_screen.dart';
import 'reports_analytics_screen.dart';
import 'profile_screen.dart';
import 'events_management_screen.dart'; // 🎯 Events Screen Import थपियो

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentIndex = 0;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "HostelMate",
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A)),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: const [
                Text(
                  "Welcome back, Admin ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                Text("👋", style: TextStyle(fontSize: 22)),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Here's what's happening at the hostel today.",
              style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 20),

            // Top Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _buildStatCard("Total Students", "450", Icons.groups_outlined, const Color(0xFF4F46E5)),
                _buildStatCard("Active Users", "382", Icons.person_outline, const Color(0xFF10B981)),
                _buildStatCard("Today's\nAttendance", "92%", Icons.tune, const Color(0xFFF59E0B)),
                _buildStatCard("Pending\nComplaints", "12", Icons.error_outline, const Color(0xFFEF4444)),
                _buildStatCard("Food Ratings", "4.2/5", Icons.restaurant, const Color(0xFF10B981)),
                _buildStatCard("Monthly Revenue", "\$12.5k", Icons.account_balance_wallet_outlined, const Color(0xFF6366F1)),
              ],
            ),

            const SizedBox(height: 24),
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 12),

            // Quick Action Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.verified_user_outlined, color: Colors.white, size: 18),
                    label: const Text("Approvals", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF34D399),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NoticeManagementScreen()),
                      );
                    },
                    icon: const Icon(Icons.campaign_outlined, color: Colors.white, size: 18),
                    label: const Text("Add Notice", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RoomManagementScreen()),
                      );
                    },
                    icon: const Icon(Icons.meeting_room_outlined, color: Colors.white, size: 18),
                    label: const Text("Assign Room", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MenuManagementScreen()),
                      );
                    },
                    icon: const Icon(Icons.restaurant_menu_outlined, color: Colors.white, size: 18),
                    label: const Text("Update Menu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Management Modules", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 12),

            // Modules Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
              children: [
                _buildModuleTile(
                  "Student\nMgmt",
                  Icons.school_outlined,
                  const Color(0xFF2563EB),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentManagementScreen())),
                ),
                _buildModuleTile(
                  "Room\nMgmt",
                  Icons.king_bed_outlined,
                  const Color(0xFF10B981),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomManagementScreen())),
                ),
                _buildModuleTile(
                  "Complaints",
                  Icons.chat_bubble_outline,
                  const Color(0xFFB91C1C),
                  showBadge: true,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ComplaintsManagementScreen())),
                ),
                _buildModuleTile(
                  "Notices",
                  Icons.chat_outlined,
                  const Color(0xFFD97706),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NoticeManagementScreen())),
                ),
                _buildModuleTile(
                  "Recipes",
                  Icons.menu_book_outlined,
                  const Color(0xFF2563EB),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecipesManagementScreen())),
                ),
                _buildModuleTile(
                  "Menu",
                  Icons.fastfood_outlined,
                  const Color(0xFF059669),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuManagementScreen())),
                ),
                _buildModuleTile(
                  "Health",
                  Icons.add_location_alt_outlined,
                  const Color(0xFFDC2626),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HealthManagementScreen())),
                ),
                // 🎯 Events Navigation जोडियो
                _buildModuleTile(
                  "Events",
                  Icons.calendar_today_outlined,
                  const Color(0xFF4F46E5),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EventsManagementScreen())),
                ),
                _buildModuleTile(
                  "SOS",
                  Icons.ac_unit,
                  Colors.white,
                  isSos: true,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SosEmergencyScreen())),
                ),
                _buildModuleTile(
                  "Reports",
                  Icons.bar_chart_outlined,
                  const Color(0xFF059669),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsAnalyticsScreen())),
                ),
                _buildModuleTile(
                  "Settings",
                  Icons.settings_outlined,
                  const Color(0xFF475569),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                ),
                _buildModuleTile(
                  "...",
                  Icons.more_horiz,
                  const Color(0xFF64748B),
                  isLightBg: true,
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text("Performance Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 12),

            // Complaint Statistics Chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Complaint Statistics (Weekly)", style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                      Icon(Icons.more_vert, color: Color(0xFF64748B), size: 20),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBar("Mon", 0.5),
                        _buildBar("Tue", 0.8),
                        _buildBar("Wed", 0.4),
                        _buildBar("Thu", 0.95),
                        _buildBar("Fri", 0.65),
                        _buildBar("Sat", 0.3),
                        _buildBar("Sun", 0.75),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Student Growth Chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Student Growth", style: TextStyle(fontSize: 14, color: Color(0xFF64748B))),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: LineChartPainter(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Jan", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text("Feb", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text("Mar", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text("Apr", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text("May", style: TextStyle(fontSize: 10, color: Colors.grey)),
                      Text("Jun", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Food Rating & Daily Active Side-by-Side
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Food Rating", style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        const SizedBox(height: 16),
                        Center(
                          child: SizedBox(
                            height: 70,
                            width: 70,
                            child: CircularProgressIndicator(
                              value: 0.8,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey.shade200,
                              color: const Color(0xFF047857),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Daily Active", style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        const SizedBox(height: 4),
                        const Text("382", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF059669))),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              6,
                              (index) => Container(
                                width: 4,
                                height: (index % 2 == 0 ? 24 : 16).toDouble(),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF059669),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                TextButton(
                  onPressed: () {},
                  child: const Text("View All", style: TextStyle(color: Color(0xFF2563EB))),
                )
              ],
            ),
            const SizedBox(height: 8),

            // Recent Activity List
            _buildActivityItem(Icons.person_add_alt_1, const Color(0xFF2563EB), "New Student Registered", "Aaryan Sharma (Room 304)", "2m ago"),
            _buildActivityItem(Icons.chat_bubble_outline, const Color(0xFFEF4444), "New Complaint Submitted", "Maintenance: Leak in Block B", "15m ago"),
            _buildActivityItem(Icons.restaurant, const Color(0xFF10B981), "Menu Updated", "Weekly Breakfast Schedule", "1h ago"),
            _buildActivityItem(Icons.campaign, const Color(0xFFF59E0B), "New Notice Published", "Exam Silence Hours Starting", "3h ago"),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.grid_view_rounded, "Dashboard"),
            _buildNavItem(1, Icons.account_tree_outlined, "Management"),
            _buildNavItem(2, Icons.insert_chart_outlined, "Reports"),
            _buildNavItem(3, Icons.person_outline, "Profile"),
          ],
        ),
      ),
    );
  }

  // Bar Chart Helper Widget
  Widget _buildBar(String label, double heightRatio) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 12,
          height: 90 * heightRatio,
          decoration: BoxDecoration(
            color: const Color(0xFFB91C1C),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
      ],
    );
  }

  // Stat Card Helper Widget
  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 6),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  // Module Grid Tile Helper Widget
  Widget _buildModuleTile(
    String title, 
    IconData icon, 
    Color color, 
    {bool isSos = false, bool showBadge = false, bool isLightBg = false, VoidCallback? onTap}
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: isSos
                ? const Color(0xFFB91C1C)
                : isLightBg
                    ? const Color(0xFFEEF2FF)
                    : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: isSos ? Colors.white : color, size: 24),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSos ? Colors.white : const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              if (showBadge)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Activity Item Helper Widget
  Widget _buildActivityItem(IconData icon, Color color, String title, String subtitle, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              ],
            ),
          ),
          Text(time, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }

  // Bottom Navigation Helper Widget
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RoomManagementScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ReportsAnalyticsScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6EE7B7) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF047857) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? const Color(0xFF047857) : const Color(0xFF64748B),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// Line Chart Custom Painter
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF1D4ED8)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height * 0.8);
    path.cubicTo(
      size.width * 0.2, size.height * 0.6,
      size.width * 0.4, size.height * 0.9,
      size.width * 0.6, size.height * 0.4,
    );
    path.cubicTo(
      size.width * 0.8, size.height * 0.2,
      size.width * 0.9, size.height * 0.1,
      size.width, size.height * 0.0,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}