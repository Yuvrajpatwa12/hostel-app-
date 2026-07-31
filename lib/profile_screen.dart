import 'package:flutter/material.dart';
import 'hostel_details.dart';   // Import hostel details page
import 'room_mate.dart';       // Import roommate page
import 'fee_status.dart';      // Import fee status page
import 'food_feedback_screen.dart'; // Import separate food review & QR attendance screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel App Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Inter',
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showDetailBottomSheet(BuildContext context, {required String title, required List<Widget> details}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF1F5F9),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFE2E8F0), height: 1),
              const SizedBox(height: 16),
              ...details,
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Settings Icon
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserSettingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF0F172A),
                    size: 24,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Profile Avatar & Name
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 46,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2563EB),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Yuvraj Patwa',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'yuvraj.dev@example.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      label: const Text('Edit Profile'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2563EB),
                        side: const BorderSide(color: Color(0xFF2563EB)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ACCOUNT & STATUS SECTION
              const Text(
                'ACCOUNT & STATUS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuCard(
                children: [
                  _buildNavigationRow(
                    icon: Icons.person_outline,
                    title: 'Personal Details',
                    onTap: () {
                      _showDetailBottomSheet(
                        context,
                        title: 'Personal Details',
                        details: [
                          _buildDetailRow('Full Name', 'Yuvraj Patwa'),
                          _buildDetailRow('Email', 'yuvraj.developer@example.com'),
                          _buildDetailRow('Phone', '+977 9800000000'),
                          _buildDetailRow('Date of Birth', '15 Aug 2005'),
                          _buildDetailRow('Guardian Name', 'Rajendra Patwa'),
                          _buildDetailRow('Address', 'Birgunj, Nepal'),
                        ],
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(
                    icon: Icons.badge_outlined,
                    title: 'My Hostel ID',
                    onTap: () {
                      _showDetailBottomSheet(
                        context,
                        title: 'Hostel ID Card Info',
                        details: [
                          _buildDetailRow('Student ID', 'HST-2026-8942'),
                          _buildDetailRow('Hostel Name', 'Grand View Residence'),
                          _buildDetailRow('Room No.', 'Block B - 304'),
                          _buildDetailRow('Bed Type', 'Double Sharing'),
                          _buildDetailRow('Valid Upto', 'December 2026'),
                          _buildDetailRow('Status', 'Verified & Active'),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // HOSTEL & ACCOMMODATION SECTION
              const Text(
                'HOSTEL & ACCOMMODATION',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuCard(
                children: [
                  _buildNavigationRow(
                    icon: Icons.home_work_outlined,
                    title: 'Hostel Details',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HostelDetailsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(
                    icon: Icons.group_outlined,
                    title: 'Roommate',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RoomMateScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Fee Status',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeeStatusScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  // Opens FoodFeedbackScreen from food_feedback_screen.dart
                  _buildNavigationRow(
                    icon: Icons.restaurant_menu_rounded,
                    title: 'Food Review',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FoodFeedbackScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // HISTORY & LOGS SECTION
              const Text(
                'HISTORY & LOGS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuCard(
                children: [
                  _buildNavigationRow(icon: Icons.exit_to_app_outlined, title: 'Leave History', onTap: () {}),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(icon: Icons.report_problem_outlined, title: 'Complaint History', onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),

              // SUPPORT & HELP SECTION
              const Text(
                'SUPPORT & HELP',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              _buildMenuCard(
                children: [
                  _buildNavigationRow(icon: Icons.support_agent_outlined, title: 'Contact Warden', onTap: () {}),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(icon: Icons.emergency_outlined, title: 'Emergency Contacts', onTap: () {}),
                  const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
                  _buildNavigationRow(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildNavigationRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF0F172A)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class UserSettingScreen extends StatelessWidget {
  const UserSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
        ),
      ),
      body: const Center(child: Text('Settings Options')),
    );
  }
}