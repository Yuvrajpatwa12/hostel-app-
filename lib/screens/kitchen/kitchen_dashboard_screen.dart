import 'package:flutter/material.dart';

// Import all separate feature screens with prefixes to avoid naming collisions
import 'today_menu_screen.dart';
import 'claims_screen.dart';
import 'reviews_screen.dart';
import 'ingredients_screen.dart' as ingredients_pkg;
import 'inventory_screen.dart' as inventory_pkg;
import 'broadcast_screen.dart';
import 'profile_screen.dart';

class KitchenDashboardScreen extends StatefulWidget {
  const KitchenDashboardScreen({super.key});

  @override
  State<KitchenDashboardScreen> createState() => _KitchenDashboardScreenState();
}

class _KitchenDashboardScreenState extends State<KitchenDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 35, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0F2C59),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HostelMate Kitchen",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F2C59)),
                      ),
                      Text(
                        "ADMINISTRATIVE PORTAL",
                        style: TextStyle(fontSize: 9, color: Colors.grey, letterSpacing: 0.5),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.black87, size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Text(
                    "Good Morning, Kitchen Staff 🍳",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Spacer(),
                  Text(
                    "Oct 24, 2023 | Lunch Active",
                    style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Metric Summary Grid ---
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.3,
              children: const [
                _StatCard(title: "MEALS SERVED", value: "850", icon: Icons.restaurant, iconBg: Color(0xFFEEF2FF), iconColor: Colors.indigo),
                _StatCard(title: "AVG RATING", value: "4.2", icon: Icons.star_outline, iconBg: Color(0xFFE6F7ED), iconColor: Colors.green),
                _StatCard(title: "COMPLAINTS", value: "3", icon: Icons.error_outline, iconBg: Color(0xFFFFEBEB), iconColor: Colors.red),
                _StatCard(title: "STOCK STATUS", value: "92%", icon: Icons.inventory_2_outlined, iconBg: Color(0xFFFFF3E0), iconColor: Colors.orange),
              ],
            ),
            const SizedBox(height: 16),

            // Inventory Alerts Horizontal Chips
            const Text("INVENTORY ALERT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _alertChip("🟢 Rice: 45kg", Colors.green, const Color(0xFFE6F7ED)),
                  const SizedBox(width: 8),
                  _alertChip("🔴 Milk: 12L (Low)", Colors.red, const Color(0xFFFFEBEB)),
                  const SizedBox(width: 8),
                  _alertChip("🟢 Vegetables: Fresh", Colors.green, const Color(0xFFE6F7ED)),
                  const SizedBox(width: 8),
                  _alertChip("🔵 Vegetables: Fresh", Colors.green, const Color(0xFFE6F7ED)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions Section (Linked to respective screens)
            const Text("QUICK ACTIONS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 8,
              childAspectRatio: 1.15,
              children: [
                _ActionButton(
                  icon: Icons.restaurant_menu, 
                  label: "Menu", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayMenuScreen())),
                ),
                _ActionButton(
                  icon: Icons.star_border, 
                  label: "Reviews", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewsScreen())),
                ),
                _ActionButton(
                  icon: Icons.warning_amber_rounded, 
                  label: "Claims", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClaimsScreen())),
                ),
                _ActionButton(
                  icon: Icons.local_dining, 
                  label: "Ingredients", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ingredients_pkg.IngredientsScreen())),
                ),
                //_ActionButton(
                  // icon: Icons.inventory_2_outlined, 
                  // label: "Inventory", 
                  //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const inventory_pkg.InventoryScreen())),
                  //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => inventory_pkg.InventoryScreen())),
                //),
                _ActionButton(
                  icon: Icons.campaign_outlined, 
                  label: "Broadcast", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BroadcastScreen())),
                ),
                _ActionButton(
                  icon: Icons.settings_outlined, 
                  label: "Settings", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                ),
                _ActionButton(
                  icon: Icons.add, 
                  label: "New", 
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayMenuScreen())),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Today's Menu Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Today's Menu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayMenuScreen())),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
                  child: const Text("View Week", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _menuItem("Breakfast", "Poha & Masala Tea", "Served 08:00 - 10:00 AM", "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=200", const Color(0xFF3E2723)),
            _menuItem("Lunch", "Standard Veg Thali", "Served 12:30 - 02:30 PM", "https://images.unsplash.com/photo-1610192244261-3f33de3f55e4?w=200", const Color(0xFF1B5E20)),
            _menuItem("Dinner", "Dal Makhani & Naan", "Serves at 08:00 PM", "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200", const Color(0xFFBF360C)),
            const SizedBox(height: 16),

            // --- Food Quality Section ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Food Quality", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      Icon(Icons.bar_chart, color: Colors.green, size: 20),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            value: 0.84,
                            strokeWidth: 7,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF006E2F)),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("4.2", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("/ 5.0", style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _qualityBar("Taste", 0.85),
                  const SizedBox(height: 8),
                  _qualityBar("Hygiene", 0.90),
                  const SizedBox(height: 8),
                  _qualityBar("Quantity", 0.75),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Live Updates Section ---
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Live Updates", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _updateTile(Icons.edit, Colors.indigo, Colors.indigo.shade50, "Menu Updated", "Dinner list revised by Supervisor • 2m ago"),
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: SizedBox(height: 12, child: VerticalDivider(color: Colors.grey, thickness: 1)),
                  ),
                  _updateTile(Icons.star_border, Colors.green, Colors.green.shade50, "New Review", "\"Loved the Poha!\" - Aryan • 15m ago"),
                  const Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: SizedBox(height: 12, child: VerticalDivider(color: Colors.grey, thickness: 1)),
                  ),
                  _updateTile(Icons.check, Colors.teal, Colors.teal.shade50, "Complaint Resolved", "Raw Paneer issue fixed • 45m ago"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Pending Complaints Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pending Complaints", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10)),
                  child: const Text("3 Attention Items", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Complaint Item 1
            _complaintCard(
              avatarUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100",
              name: "Rahul Sharma (Room 302)",
              badgeText: "Just Now",
              badgeColor: Colors.blue.shade50,
              badgeTextColor: Colors.blue,
              issueTitle: "EXCESS SALT IN DAL",
              description: "\"The dal today had way too much salt, couldn't finish half the portion. Please check before serving.\"",
              isResolved: false,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClaimsScreen())),
            ),
            const SizedBox(height: 10),

            // Complaint Item 2
            _complaintCard(
              avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100",
              name: "Priya Verma (Room 105)",
              badgeText: "1h ago",
              badgeColor: Colors.grey.shade100,
              badgeTextColor: Colors.grey,
              issueTitle: "COLD BREAKFAST",
              description: "\"Reached at 9:50 and the Poha was cold. Could we keep it covered?\"",
              isResolved: true,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClaimsScreen())),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayMenuScreen()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ClaimsScreen()));
          } else if (index == 3) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006E2F),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: "Complaints"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  static Widget _alertChip(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  static Widget _menuItem(String category, String title, String time, String imgUrl, Color badgeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imgUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.fastfood)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                  child: Text(category, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 3),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayMenuScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEEF2FF),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: const Size(50, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Update", style: TextStyle(color: Colors.blue, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _qualityBar(String label, double progress) {
    return Row(
      children: [
        SizedBox(width: 65, child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade100,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF006E2F)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _updateTile(IconData icon, Color iconColor, Color iconBg, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _complaintCard({
    required String avatarUrl,
    required String name,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String issueTitle,
    required String description,
    required bool isResolved,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 16, backgroundImage: NetworkImage(avatarUrl)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(issueTitle, style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                child: Text(badgeText, style: TextStyle(color: badgeTextColor, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: TextStyle(fontSize: 11, color: Colors.grey.shade700, fontStyle: FontStyle.italic)),
          const SizedBox(height: 10),
          isResolved
              ? SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Resolved", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: OutlinedButton(
                          onPressed: onTap,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Reply", style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA5D6A7),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Resolve", style: TextStyle(color: Color(0xFF006E2F), fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  const _StatCard({required this.title, required this.value, required this.icon, required this.iconBg, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Icon(icon, color: const Color(0xFF0B1C30), size: 20),
          ),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}