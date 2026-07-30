import 'package:flutter/material.dart';

class UserSettingBody extends StatefulWidget {
  const UserSettingBody({super.key});

  @override
  State<UserSettingBody> createState() => _UserSettingBodyState();
}

class _UserSettingBodyState extends State<UserSettingBody> {
  bool _faceIdEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GENERAL SECTION
          const Text(
            'General',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildMenuCard(
            children: [
              _buildNavigationRow(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.wb_sunny_outlined,
                title: 'Appearance',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.language_outlined,
                title: 'Language',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // SECURITY SECTION
          const Text(
            'Security',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildMenuCard(
            children: [
              _buildSwitchRow(
                icon: Icons.face_outlined,
                title: 'Face ID',
                value: _faceIdEnabled,
                onChanged: (val) {
                  setState(() {
                    _faceIdEnabled = val;
                  });
                },
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.phonelink_setup_outlined,
                title: 'Linked Devices',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.lock_outline_rounded,
                title: 'Passcode',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.verified_user_outlined,
                title: 'Transaction Confirmation',
                onTap: () {},
              ),
              const Divider(height: 1, indent: 52, color: Color(0xFFF1F5F9)),
              _buildNavigationRow(
                icon: Icons.fingerprint_rounded,
                title: 'Biometrics',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // PAYMENTS & TRANSFERS SECTION
          const Text(
            'Payments & Transfers',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          _buildMenuCard(
            children: [
              _buildNavigationRow(
                icon: Icons.arrow_upward_rounded,
                title: 'Faster Payments System',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Reusable Container Box
  Widget _buildMenuCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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

  // Reusable Navigation Row with Arrow
  Widget _buildNavigationRow({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(width: 14),
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
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Switch Row
  Widget _buildSwitchRow({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(width: 14),
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
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }
}