import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Profile Card
            _buildProfileHeaderCard(),
            const SizedBox(height: 20),

            // Account Section
            _buildSectionHeader("Account"),
            _buildCardGroup([
              _buildListTile(
                icon: Icons.person_outline,
                iconColor: const Color(0xFF4F46E5),
                bgColor: const Color(0xFFEEF2FF),
                title: "Edit Profile",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.lock_outline,
                iconColor: const Color(0xFF4F46E5),
                bgColor: const Color(0xFFEEF2FF),
                title: "Change Password",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.notifications_none_outlined,
                iconColor: const Color(0xFF4F46E5),
                bgColor: const Color(0xFFEEF2FF),
                title: "Notification Preferences",
                onTap: () {},
                isLast: true,
              ),
            ]),
            const SizedBox(height: 20),

            // Administrative Section
            _buildSectionHeader("Administrative"),
            _buildCardGroup([
              _buildListTile(
                icon: Icons.groups_outlined,
                iconColor: const Color(0xFF059669),
                bgColor: const Color(0xFFD1FAE5),
                title: "Manage Staff",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.single_bed_outlined,
                iconColor: const Color(0xFF059669),
                bgColor: const Color(0xFFD1FAE5),
                title: "Room Configurations",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.apartment,
                iconColor: const Color(0xFF059669),
                bgColor: const Color(0xFFD1FAE5),
                title: "Hostel Information",
                onTap: () {},
                isLast: true,
              ),
            ]),
            const SizedBox(height: 20),

            // System Section
            _buildSectionHeader("System"),
            _buildCardGroup([
              _buildListTile(
                icon: Icons.palette_outlined,
                iconColor: const Color(0xFF4338CA),
                bgColor: const Color(0xFFEEF2FF),
                title: "App Theme",
                trailing: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E7FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildThemeToggleIcon(Icons.wb_sunny_outlined, !isDarkMode),
                      _buildThemeToggleIcon(Icons.nightlight_round, isDarkMode),
                    ],
                  ),
                ),
              ),
              _buildListTile(
                icon: Icons.language,
                iconColor: const Color(0xFF4338CA),
                bgColor: const Color(0xFFEEF2FF),
                title: "Language",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedLanguage,
                      style: const TextStyle(
                        color: Color(0xFF1E3A8A),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Color(0xFF1E3A8A)),
                  ],
                ),
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.cloud_upload_outlined,
                iconColor: const Color(0xFF4338CA),
                bgColor: const Color(0xFFEEF2FF),
                title: "Backup & Restore",
                onTap: () {},
                isLast: true,
              ),
            ]),
            const SizedBox(height: 20),

            // Support Section
            _buildSectionHeader("Support"),
            _buildCardGroup([
              _buildListTile(
                icon: Icons.help_outline,
                iconColor: const Color(0xFFEA580C),
                bgColor: const Color(0xFFFFEDD5),
                title: "Help Center",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.verified_user_outlined,
                iconColor: const Color(0xFFEA580C),
                bgColor: const Color(0xFFFFEDD5),
                title: "Privacy Policy",
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.info_outline,
                iconColor: const Color(0xFFEA580C),
                bgColor: const Color(0xFFFFEDD5),
                title: "App Version",
                trailing: const Text(
                  "v2.4.1",
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
                isLast: true,
              ),
            ]),
            const SizedBox(height: 20),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout, color: Color(0xFFDC2626), size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: const [
          Icon(Icons.grid_view_rounded, color: Color(0xFF1E3A8A), size: 24),
          SizedBox(width: 8),
          Text(
            "HostelMate",
            style: TextStyle(
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildProfileHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2563EB), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150',
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF10B981),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Robert Wilson",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "SENIOR WARDEN",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "ID: HM-ADMIN-01",
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note, color: Color(0xFF1E3A8A), size: 26),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildCardGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          trailing: trailing ??
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF94A3B8),
                size: 20,
              ),
          onTap: onTap,
        ),
        if (!isLast)
          const Divider(
            height: 1,
            indent: 56,
            endIndent: 16,
            color: Color(0xFFF1F5F9),
          ),
      ],
    );
  }

  Widget _buildThemeToggleIcon(IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = icon == Icons.nightlight_round;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  )
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: 14,
          color: isActive ? const Color(0xFF0F172A) : const Color(0xFF64748B),
        ),
      ),
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
          _buildNavItem(Icons.grid_view_rounded, "Dashboard", false, () {}),
          _buildNavItem(Icons.apartment_outlined, "Management", false, () {}),
          _buildNavItem(Icons.insert_chart_outlined, "Reports", false, () {}),
          _buildNavItem(Icons.person, "Profile", true, () {}),
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
              color: isSelected ? const Color(0xFF6EE7B7) : Colors.transparent,
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