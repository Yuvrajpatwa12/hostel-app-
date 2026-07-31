import 'package:flutter/material.dart';

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 18),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Text("HostelMate", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18)),
    actions: [
      IconButton(icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A)), onPressed: () {}),
      const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5')),
      const SizedBox(width: 12),
    ],
  );
}

Widget _buildBottomNav(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFF1F5F9)))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(context, Icons.grid_view_rounded, "Dashboard"),
        _buildNavItem(context, Icons.check_box_outlined, "Manage", isSelected: true),
        _buildNavItem(context, Icons.insert_chart_outlined, "Reports"),
        _buildNavItem(context, Icons.person_outline, "Profile"),
      ],
    ),
  );
}

Widget _buildNavItem(BuildContext context, IconData icon, String label, {bool isSelected = false}) {
  return GestureDetector(
    onTap: () => Navigator.pop(context), // 🚀 Clicking Nav Bar sends back to Admin Dashboard
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6EE7B7) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: isSelected ? const Color(0xFF047857) : const Color(0xFF64748B), size: 20),
        ),
        Text(label, style: TextStyle(fontSize: 10, color: isSelected ? const Color(0xFF047857) : const Color(0xFF64748B), fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ],
    ),
  );
}