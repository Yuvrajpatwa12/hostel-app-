import 'package:flutter/material.dart';
import 'package:kathmadnuhostel/screens/student/raise_complaint_screen.dart';
import 'package:kathmadnuhostel/screens/student/study_corner_screen.dart';
import 'active_statues.dart';
import 'fee_status.dart';
import 'food_feedback_screen.dart' as feedback_screen;
import 'food_review.dart' as food_review_screen;
import 'hostel_details.dart';
import 'profile_screen.dart'; // यो तपाईंको प्रोफाइल स्क्रिन हो जसमा Yuvraj Patwa वाला UI छ
import 'room_mate.dart';
import 'routing_screen.dart';
import 'sos_screen.dart';
import 'rewards_screen.dart';
import 'notice_board_screen.dart';

class _NavItemData {
  final String label;
  final IconData inactiveIcon;
  final IconData activeIcon;

  const _NavItemData({
    required this.label,
    required this.inactiveIcon,
    required this.activeIcon,
  });
}

class HomeScreen extends StatefulWidget {
  final String role;
  const HomeScreen({super.key, required this.role});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<_NavItemData> _navItems = const [
    _NavItemData(label: 'Home', inactiveIcon: Icons.home_outlined, activeIcon: Icons.home_rounded),
    _NavItemData(label: 'Daily Status', inactiveIcon: Icons.monitor_heart_outlined, activeIcon: Icons.monitor_heart_rounded),
    _NavItemData(label: 'Fee', inactiveIcon: Icons.account_balance_wallet_outlined, activeIcon: Icons.account_balance_wallet_rounded),
    _NavItemData(label: 'Food Feedback', inactiveIcon: Icons.restaurant_menu_outlined, activeIcon: Icons.restaurant_menu_rounded),
    _NavItemData(label: 'Food Review', inactiveIcon: Icons.rate_review_outlined, activeIcon: Icons.rate_review_rounded),
    _NavItemData(label: 'Hostel', inactiveIcon: Icons.apartment_outlined, activeIcon: Icons.apartment_rounded),
    _NavItemData(label: 'Roommate', inactiveIcon: Icons.people_alt_outlined, activeIcon: Icons.people_alt_rounded),
    _NavItemData(label: 'SOS', inactiveIcon: Icons.emergency_outlined, activeIcon: Icons.emergency_rounded),
    _NavItemData(label: 'Routing', inactiveIcon: Icons.alt_route_outlined, activeIcon: Icons.alt_route_rounded),
    _NavItemData(label: 'Profile', inactiveIcon: Icons.account_circle_outlined, activeIcon: Icons.account_circle_rounded),
  ];

  late final List<Widget> _pages = [
    HomeTabContent(
      onNavigateToFeature: _navigateToFeatureIndex,
      onOpenProfile: () {
        // माथिको प्रोफाइल सेक्सनमा क्लिक गर्दा प्रोफाइल पेज खोल्न
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
    ),
    const SingleDashboardScreen(),
    const FeeStatusScreen(),
    const feedback_screen.FoodFeedbackScreen(),
    const food_review_screen.TabbedFoodReviewScreen(),
    const HostelDetailsScreen(),
    const RoomMateScreen(),
    const SosScreen(),
    const RoutingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A8A),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // Floating Bottom Navigation Bar
          Positioned(
            left: 12,
            right: 12,
            bottom: 16,
            child: Container(
              height: 76,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_navItems.length > 4 ? 4 : _navItems.length, (index) {
                    final item = _navItems[index];
                    return _buildNavItem(index, item.inactiveIcon, item.activeIcon, item.label);
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToFeatureIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    bool isSelected = _currentIndex == index;
    
    // यदि यो अन्तिम प्रोफाइल आइकन हो भने फोटो देखाउने
    if (index == 9) {
      return GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: const CircleAvatar(
                radius: 11,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : inactiveIcon,
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// HOME TAB CONTENT
// ----------------------------------------------------
class HomeTabContent extends StatelessWidget {
  final ValueChanged<int> onNavigateToFeature;
  final VoidCallback onOpenProfile;

  const HomeTabContent({
    super.key, 
    required this.onNavigateToFeature,
    required this.onOpenProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FF),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header with Deep Blue Background & Profile (Clickable to open ProfileScreen)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: onOpenProfile, // यहाँ क्लिक गर्दा तपाईंले पठाउनुभएको प्रोफाइल पेज खुल्छ
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Good Morning,", style: TextStyle(fontSize: 12, color: Colors.white70)),
                                Row(
                                  children: const [
                                    Text("Yuvraj", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    SizedBox(width: 4),
                                    Icon(Icons.verified, color: Colors.blueAccent, size: 16),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {},
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                                onPressed: () {},
                              ),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  // Maintenance Update Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
                          child: const Icon(Icons.campaign_outlined, color: Colors.red, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("MAINTENANCE UPDATE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
                              SizedBox(height: 2),
                              Text("Water supply scheduled maintenance: 2 PM – 4 PM today.", style: TextStyle(fontSize: 12, color: Color(0xFF334155))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Attendance & Tank Level Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("ATTENDANCE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                                  Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF1E3A8A)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text("92%", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                              const SizedBox(height: 4),
                              const Text("Above required 75%", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("TANK LEVEL", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                                  Icon(Icons.water_drop_outlined, size: 16, color: Color(0xFF1E3A8A)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text("Optimal", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                              const SizedBox(height: 4),
                              const Text("Updated 5m ago", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Quick Actions Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Quick Actions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      Text("View All", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6))),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Quick Actions Grid
                  GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 0.85,
                    children: [
                      _buildQuickAction(context, "Daily Status", Icons.monitor_heart_outlined, Colors.indigo, const SingleDashboardScreen()),
                      _buildQuickAction(context, "Fee Status", Icons.account_balance_wallet_outlined, Colors.teal, const FeeStatusScreen(), hasBadge: true),
                      _buildQuickAction(context, "Food Feedback", Icons.restaurant_menu_outlined, Colors.amber.shade700, const feedback_screen.FoodFeedbackScreen()),
                      _buildQuickAction(context, "Food Review", Icons.rate_review_outlined, Colors.purple, const food_review_screen.TabbedFoodReviewScreen()),
                      _buildQuickAction(context, "Hostel Info", Icons.apartment_outlined, Colors.deepOrange, const HostelDetailsScreen()),
                      _buildQuickAction(context, "Roommate", Icons.people_alt_outlined, Colors.blue, const RoomMateScreen()),
                      _buildQuickAction(context, "Routine", Icons.calendar_month_outlined, Colors.purple.shade300, const RoutingScreen()),
                      _buildQuickAction(
                        context, 
                        "Rewards", 
                        Icons.workspace_premium_outlined, 
                        Colors.amber, 
                        const RewardsScreen()), 
                      _buildQuickAction(
                        context, 
                        "Complaints", 
                        Icons.error_outline, 
                        Colors.pink, 
                        const RaiseComplaintScreen(),
                      ),
                      _buildQuickAction(
                        context, 
                        "Study Corner", 
                        Icons.menu_book_outlined, 
                        Colors.indigo, 
                        const StudyCornerScreen(),
                      ),
                      // यहाँ Notice मा क्लिक गर्दा NoticeBoardScreen खुल्ने बनाइएको छ
                      _buildQuickAction(context, "Notice", Icons.notifications_active_outlined, Colors.orange, const NoticeBoardScreen()),
                      _buildQuickAction(context, "SOS", Icons.emergency_outlined, Colors.white, const SosScreen(), isSos: true),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Today's Menu Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.restaurant, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text("Today's Menu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                              child: const Text("View Full", style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildMenuRow("Breakfast", "Masala Dosa, Ginger Chai, Banana"),
                        const Divider(color: Colors.white24, height: 20),
                        _buildMenuRow("Lunch", "Paneer Makhani, Roti, Jeera Rice"),
                        const Divider(color: Colors.white24, height: 20),
                        _buildMenuRow("Dinner", "Mixed Veg Curry, Rice, Curd"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Routine Tracker
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Routine Tracker", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                            Icon(Icons.access_time, color: Color(0xFF64748B), size: 20),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildRoutineItem("Gym Session", "07:00 AM — FINISHED", true, true),
                        _buildRoutineItem("Lecture: Data Structures", "10:30 AM — 12:00 PM", true, false, isLive: true),
                        _buildRoutineItem("Library Session", "04:00 PM", false, false),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Monthly Budget
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Monthly Budget", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                            const Text("₹1,800", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("Spent ₹4,200 of ₹6,000", style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 4200 / 6000,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E3A8A)),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String title, IconData icon, Color color, Widget targetScreen, {bool hasBadge = false, bool isSos = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSos ? const Color(0xFFDC2626) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (!isSos) BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 3)),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: isSos ? Colors.white : color, size: 24),
                const SizedBox(height: 6),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSos ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            if (hasBadge)
              Positioned(
                right: 14,
                top: 10,
                child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow(String mealTime, String items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(mealTime, style: const TextStyle(fontSize: 12, color: Colors.white70)),
        const SizedBox(height: 2),
        Text(items, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildRoutineItem(String title, String time, bool isCompleted, bool isFirst, {bool isLive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? const Color(0xFF1E3A8A) : Colors.transparent,
              border: Border.all(color: isCompleted ? const Color(0xFF1E3A8A) : Colors.grey.shade400, width: 2),
            ),
            child: isCompleted ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isCompleted ? const Color(0xFF64748B) : const Color(0xFF0F172A))),
                    if (isLive) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(6)),
                        child: const Text("LIVE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.red)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(time, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}