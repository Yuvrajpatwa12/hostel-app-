import 'package:flutter/material.dart';

class SosEmergencyScreen extends StatelessWidget {
  const SosEmergencyScreen({super.key});

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
              "Emergency Contacts",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              "Quick access to essential services and site administration.",
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 24),

            // Big SOS Circle Button with Concentric Outer Rings
            Center(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFCA5A5).withValues(alpha: 0.3), width: 1.5),
                ),
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFCA5A5).withValues(alpha: 0.5), width: 1.5),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFB91C1C),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33B91C1C),
                          blurRadius: 16,
                          spreadRadius: 4,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "SOS",
                          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 1),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "EMERGENCY",
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Emergency Call Cards
            _buildContactCard("WARDEN", "Mr. David Smith", "+1 (555) 012-3456", Icons.people_outline, const Color(0xFFEEF2FF), const Color(0xFF1D4ED8)),
            _buildContactCard("AMBULANCE", "Medical Response", "911", Icons.car_crash_outlined, const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
            _buildContactCard("POLICE", "Campus Security", "100 / 999", Icons.shield_outlined, const Color(0xFFDBEAFE), const Color(0xFF1D4ED8)),
            _buildContactCard("FIRE BRIGADE", "Fire Rescue Dept", "101", Icons.fire_truck_outlined, const Color(0xFFFFEDD5), const Color(0xFFC2410C)),
            _buildContactCard("HOSPITAL", "City General", "+1 (555) 098-7654", Icons.medical_services_outlined, const Color(0xFFD1FAE5), const Color(0xFF059669)),
            _buildContactCard("BLOOD BANK", "Red Cross Depot", "+1 (555) 111-2222", Icons.water_drop_outlined, const Color(0xFFFEE2E2), const Color(0xFFDC2626)),

            const SizedBox(height: 20),

            // Recent Alerts Section
            const Text(
              "Recent Alerts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),
            _buildAlertCard(
              title: "Emergency SOS Triggered - Room 302",
              subtitle: "Response team dispatched at 14:22",
              time: "2 MIN AGO",
              dotColor: const Color(0xFFDC2626),
            ),
            _buildAlertCard(
              title: "Routine Fire Drill Completed",
              subtitle: "All blocks evacuated and cleared",
              time: "YESTERDAY",
              dotColor: const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildContactCard(String role, String name, String phone, IconData icon, Color bg, Color iconColor) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor: bg,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Text(
                "EDIT",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Text(
            role,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 0.5),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 14, color: iconColor),
              const SizedBox(width: 4),
              Text(
                phone,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: iconColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard({required String title, required String subtitle, required String time, required Color dotColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.grid_view_rounded, color: Color(0xFF1E3A8A)),
          const SizedBox(width: 8),
          const Text(
            "HostelMate",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_none_outlined, color: Color(0xFF1E3A8A), size: 20),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150'),
        ),
        const SizedBox(width: 16),
      ],
      iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.grid_view_rounded, "Dashboard", false, () => Navigator.pop(context)),
          _buildNavItem(Icons.check_box_outlined, "Manage", true, () {}),
          _buildNavItem(Icons.insert_chart_outlined, "Reports", false, () {}),
          _buildNavItem(Icons.person_outline, "Profile", false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFA7F3D0) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF065F46) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFF065F46) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}