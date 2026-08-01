import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool pushNotifications = true;
  bool lowStockAlerts = false;
  int _currentIndex = 3; // Profile tab selected

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(milliseconds: 1200)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "HostelMate Kitchen",
                style: TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black87),
              onPressed: () => _showSnackBar("No new notifications"),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Card with Badge
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("https://images.unsplash.com/photo-1556157382-97eda2d62296?w=100"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_circle, color: Colors.green, size: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Kitchen Supervisor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    SizedBox(height: 4),
                    Text("Central Wing Kitchen • ID: #44920", style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // PROFILE SETTINGS
          const Text("PROFILE SETTINGS", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _settingsTile(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  subtitle: "Change photo, name, and role",
                  onTap: () => _showSnackBar("Opening Edit Profile"),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
                _settingsTile(
                  icon: Icons.shield_outlined,
                  title: "Password & Security",
                  subtitle: "2FA, password management",
                  onTap: () => _showSnackBar("Opening Password & Security"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // KITCHEN ADMINISTRATION
          const Text("KITCHEN ADMINISTRATION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _settingsTile(
                  icon: Icons.access_time_outlined,
                  title: "Shift Management",
                  subtitle: "Manage staff rotations and timings",
                  onTap: () => _showSnackBar("Opening Shift Management"),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.timer_outlined, color: Color(0xFF2563EB), size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Kitchen Hours", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                            const SizedBox(height: 2),
                            const Text("Meal serving windows", style: TextStyle(fontSize: 11, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Open Now",
                          style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // PREFERENCES
          const Text("PREFERENCES", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.notifications_active_outlined, color: Color(0xFF2563EB), size: 20),
                  ),
                  title: const Text("Push Notifications", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                  subtitle: const Text("Real-time alerts for complaints", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  value: pushNotifications,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF2563EB),
                  onChanged: (val) {
                    setState(() => pushNotifications = val);
                    _showSnackBar("Push Notifications: ${val ? 'Enabled' : 'Disabled'}");
                  },
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
                SwitchListTile(
                  secondary: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF2563EB), size: 20),
                  ),
                  title: const Text("Low Stock Alerts", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                  subtitle: const Text("Auto-notify when supplies are low", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  value: lowStockAlerts,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF2563EB),
                  onChanged: (val) {
                    setState(() => lowStockAlerts = val);
                    _showSnackBar("Low Stock Alerts: ${val ? 'Enabled' : 'Disabled'}");
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // SUPPORT
          const Text("SUPPORT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _settingsTile(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  subtitle: "",
                  onTap: () => _showSnackBar("Opening Help Center"),
                ),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
                _settingsTile(
                  icon: Icons.description_outlined,
                  title: "Terms of Service",
                  subtitle: "",
                  onTap: () => _showSnackBar("Opening Terms of Service"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Sign Out Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => _showSnackBar("Signed out successfully"),
              icon: const Icon(Icons.logout, color: Colors.red, size: 18),
              label: const Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.shade200),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Version Info
          const Center(
            child: Text(
              "Version 2.4.0 (Stable Build)",
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006E2F),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
          String tabName = ["Dashboard", "Menu", "Complaints", "Profile"][index];
          _showSnackBar("Navigated to $tabName tab");
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: "Complaints"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _settingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: const Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}