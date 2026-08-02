import 'package:flutter/material.dart';
import 'active_statues.dart';
import 'fee_status.dart';
import 'food_feedback_screen.dart' as feedback_screen;
import 'food_review.dart' as food_review_screen;
import 'hostel_details.dart';
import 'profile_screen.dart';
import 'room_mate.dart';
import 'routing_screen.dart';
import 'sos_screen.dart';

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

  // bottom navigation bar बाट ट्याब स्विच गर्दा खोल्ने मुख्य पेजहरू
  late final List<Widget> _pages = [
    HomeTabContent(onNavigateToFeature: _navigateToFeatureIndex),
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
          // Display current screen
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // Floating Custom Curved Navigation Bar at bottom
          Positioned(
            left: 12,
            right: 12,
            bottom: 16,
            child: Container(
              height: 84,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_navItems.length, (index) {
                      final item = _navItems[index];
                      return _buildNavItem(index, item.inactiveIcon, item.activeIcon, item.label);
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // तलको नेभिगेसन बारबाट क्लिक गर्दा चल्ने
  void _navigateToFeatureIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A).withValues(alpha: 0.10) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          width: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade500,
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// HOME TAB CONTENT (Default Dashboard)
// ----------------------------------------------------
class HomeTabContent extends StatelessWidget {
  final ValueChanged<int> onNavigateToFeature;

  const HomeTabContent({super.key, required this.onNavigateToFeature});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FF),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("HostelMate", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                      SizedBox(height: 2),
                      Text("Welcome back, Student", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_active_rounded, color: Color(0xFF1E3A8A)),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Room No. 201", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 6),
                    Text("Mess Status: Active & Paid", style: TextStyle(fontSize: 13, color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text("Student Modules", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.3,
                children: [
                  _buildCard(context, "Daily Status", "Active status", Icons.monitor_heart_outlined, Colors.indigo, const SingleDashboardScreen()),
                  _buildCard(context, "Fee Status", "Dues & History", Icons.account_balance_wallet_rounded, Colors.teal, const FeeStatusScreen()),
                  _buildCard(context, "Food Feedback", "Mess comments", Icons.restaurant_menu_rounded, Colors.amber.shade700, const feedback_screen.FoodFeedbackScreen()),
                  _buildCard(context, "Food Review", "Reviews & ratings", Icons.rate_review_rounded, Colors.purple, const food_review_screen.TabbedFoodReviewScreen()),
                  _buildCard(context, "Hostel Details", "Room & facilities", Icons.apartment_rounded, Colors.deepOrange, const HostelDetailsScreen()),
                  _buildCard(context, "Roommate", "Roommate info", Icons.people_alt_rounded, Colors.blue, const RoomMateScreen()),
                  _buildCard(context, "Routing", "Campus routes", Icons.alt_route_rounded, Colors.green, const RoutingScreen()),
                  _buildCard(context, "SOS", "Emergency help", Icons.emergency_rounded, Colors.red, const SosScreen()),
                  _buildCard(context, "Profile", "Your account", Icons.account_circle_rounded, Colors.cyan, const ProfileScreen()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String subtitle, IconData icon, Color color, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        // प्रत्येक कार्ड क्लिक गर्दा नयाँ Page मा Push गर्ने जसले गर्दा Back गर्दा ब्ल्याक स्क्रिन आउँदैन
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}