import 'package:flutter/material.dart';
import '../community/community_screen.dart';
import 'sos_screen.dart';
import '../../routing_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String role;
  final String userId;
  final String userName;

  const HomeScreen({
    super.key,
    required this.role,
    required this.userId,
    required this.userName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeTabContent(userName: widget.userName),
      CommunityScreen(userId: widget.userId, userName: widget.userName),
      const SosScreen(),
      const RoutingScreen(),
      ProfileScreen(userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A8A), // Background matching your image theme
      body: Stack(
        children: [
          // Display current screen with smooth fade transition
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _pages[_currentIndex],
          ),

          // Floating Custom Curved Navigation Bar at bottom
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Animated Indicator Dot on top of selected icon
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: _calculateIndicatorPosition(context, _currentIndex),
                    top: 10,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E3A8A),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Navigation Items Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, "Home"),
                      _buildNavItem(1, Icons.forum_outlined, Icons.forum_rounded, "Community"),
                      _buildNavItem(2, Icons.emergency_outlined, Icons.emergency_rounded, "SOS"),
                      _buildNavItem(3, Icons.alt_route_outlined, Icons.alt_route_rounded, "Routing"),
                      _buildNavItem(4, Icons.account_circle_outlined, Icons.account_circle_rounded, "Profile"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to place the top indicator dot accurately based on item index
  double _calculateIndicatorPosition(BuildContext context, int index) {
    double totalWidth = MediaQuery.of(context).size.width - 40; // accounting for padding
    double itemWidth = totalWidth / 5;
    return (itemWidth * index) + (itemWidth / 2) - 3;
  }

  Widget _buildNavItem(int index, IconData inactiveIcon, IconData activeIcon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(6),
                child: Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade400,
                  size: 26,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: isSelected ? 11 : 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade500,
                ),
                child: Text(label),
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
  final String userName;
  const HomeTabContent({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F7FF),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // extra bottom padding for floating bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("HostelMate", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                      const SizedBox(height: 2),
                      Text("Welcome back, $userName", style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
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
              const Text("Quick Actions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.3,
                children: [
                  _buildCard("Mess Menu", "Check daily food", Icons.restaurant_menu_rounded, Colors.amber.shade700),
                  _buildCard("Attendance", "View logs", Icons.fact_check_rounded, Colors.indigo),
                  _buildCard("Fee Status", "Dues & History", Icons.account_balance_wallet_rounded, Colors.teal),
                  _buildCard("Notices", "Hostel updates", Icons.campaign_rounded, Colors.deepOrange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
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
    );
  }
}
