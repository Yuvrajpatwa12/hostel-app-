import 'package:flutter/material.dart';

PreferredSizeWidget buildAdminAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
  );
}

Widget buildAdminBottomNav(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF047857)),
          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
        IconButton(
          icon: const Icon(Icons.account_tree_outlined, color: Color(0xFF64748B)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.insert_chart_outlined, color: Color(0xFF64748B)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.person_outline, color: Color(0xFF64748B)),
          onPressed: () {},
        ),
      ],
    ),
  );
}