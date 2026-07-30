import 'package:flutter/material.dart';
import 'login.dart'; // LoginScreen ko yahan import karna zaroori hai

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _selectRole(BuildContext context, String role) {
    String roleToPass = role;
    if (role == "Warden/Admin") {
      roleToPass = "Warden";
    }

    // Ab yeh code active hai, click karte hi LoginScreen khul jayegi
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(selectedRole: roleToPass),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.apartment, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              "HostelMate",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Choose Your Role",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Please select your account type to proceed to your personalized dashboard.",
                style: TextStyle(fontSize: 14, color: Color(0xFF3D4A3D), height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Role Cards
              _buildRoleCard(context, "Student", Icons.school, "Apply for rooms, manage monthly fees, and book laundry slots."),
              const SizedBox(height: 16),
              _buildRoleCard(context, "Warden/Admin", Icons.admin_panel_settings, "Oversee room allocations, track attendance, and staff schedules."),
              const SizedBox(height: 16),
              _buildRoleCard(context, "Kitchen Staff", Icons.restaurant_menu, "Manage daily menus, track inventory, and monitor subscriptions."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, IconData icon, String description) {
    return GestureDetector(
      onTap: () => _selectRole(context, title),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFDCE9FF)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withValues(alpha: 0.04),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: const Color(0xFF006E2F), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 12, color: Color(0xFF3D4A3D))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF006E2F)),
          ],
        ),
      ),
    );
  }
}
