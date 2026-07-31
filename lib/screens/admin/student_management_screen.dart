import 'package:flutter/material.dart';
import 'add_new_student_screen.dart';

class StudentManagementScreen extends StatelessWidget {
  const StudentManagementScreen({super.key});

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
            // Search Input
            TextField(
              decoration: InputDecoration(
                hintText: "Search student by name, ID or room..",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Filters Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              onPressed: () {},
              icon: const Icon(Icons.tune, size: 18, color: Color(0xFF0F172A)),
              label: const Text("FILTERS", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 13)),
            ),
            const SizedBox(height: 20),

            // Top Summary Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _buildSummaryCard("TOTAL", "1,284", Icons.groups, const Color(0xFF2563EB)),
                _buildSummaryCard("ACTIVE", "1,150", Icons.check_circle_outline, const Color(0xFF10B981)),
                _buildSummaryCard("INACTIVE", "134", Icons.cancel_outlined, const Color(0xFFEF4444)),
                _buildSummaryCard("VACANT", "42", Icons.king_bed_outlined, const Color(0xFFF59E0B)),
              ],
            ),
            const SizedBox(height: 24),

            // Active Residents Header & Sort
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Active\nResidents", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A), height: 1.1)),
                Row(
                  children: const [
                    Text("SORT BY: ", style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                    Text("Recent", style: TextStyle(fontSize: 13, color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down, color: Color(0xFF1D4ED8), size: 18),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            // Student Cards List
            _buildStudentCard("Alex Rivera", "HM-2024-0892", "B-302 (Wing B)", "B.Sc Computer Science", "Active", true),
            _buildStudentCard("Maya Sterling", "HM-2024-1104", "A-105 (Wing A)", "B.A Economics", "Active", true),
            _buildStudentCard("Jordan Smith", "HM-2023-0451", "C-404 (Wing C)", "M.B.A Finance", "Inactive", false),
            
            const SizedBox(height: 12),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  side: const BorderSide(color: Color(0xFF1D4ED8)),
                ),
                onPressed: () {},
                child: const Text("LOAD MORE STUDENTS", style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ),
          ],
        ),
      ),

      // 🚀 FAB linked to navigate to AddNewStudentScreen
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewStudentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 16, backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, color: color, size: 18)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildStudentCard(String name, String id, String room, String course, String status, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 24, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12')),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  Text("ID: $id", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("ROOM", style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                Text(room, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("COURSE", style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                Text(course, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(fontSize: 11, color: isActive ? const Color(0xFF166534) : const Color(0xFF64748B), fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.remove_red_eye_outlined, color: Color(0xFF1D4ED8), size: 20),
              SizedBox(width: 16),
              Icon(Icons.edit_outlined, color: Color(0xFF475569), size: 20),
              SizedBox(width: 16),
              Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
            ],
          )
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
          const Icon(Icons.grid_view_rounded, color: Color(0xFF2563EB)),
          const SizedBox(width: 8),
          const Text(
            "HostelMate",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
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
            onPressed: () {},
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
}