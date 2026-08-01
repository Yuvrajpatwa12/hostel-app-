import 'package:flutter/material.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text("Claims & Complaints", style: TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0F2C59)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(child: _statusBox("12 Claims", "ACTIVE", Colors.red, Colors.red.shade50, Icons.error_outline)),
              const SizedBox(width: 12),
              Expanded(child: _statusBox("48 Today", "RESOLVED", Colors.green, Colors.green.shade50, Icons.check_circle_outline)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Active Complaints", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: const [
                  Icon(Icons.filter_list, size: 16, color: Colors.blue),
                  SizedBox(width: 4),
                  Text("Filter", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          _complaintCard(
            icon: Icons.ac_unit,
            iconBg: Colors.indigo.shade50,
            iconColor: Colors.indigo,
            title: "Cold Breakfast",
            category: "Category: Food Quality",
            user: "Rahul Sharma • Room 402-B",
            desc: "\"The omelette served at 8:15 AM was completely cold and the bread was soggy. This is the third time this week.\"",
            priority: "High Priority",
            priorityColor: Colors.red,
            status: "Pending",
          ),
          const SizedBox(height: 12),
          _complaintCard(
            icon: Icons.access_time,
            iconBg: Colors.blue.shade50,
            iconColor: Colors.blue,
            title: "Late Delivery",
            category: "Category: Logistics",
            user: "Ananya Iyer • Room 105-A",
            desc: "\"Dinner delivery was delayed by 45 minutes without any notification. I have an exam tomorrow and need to manage time.\"",
            priority: "Medium",
            priorityColor: Colors.blue,
            status: "In Progress",
          ),
          const SizedBox(height: 12),
          _complaintCard(
            icon: Icons.bug_report_outlined,
            iconBg: Colors.purple.shade50,
            iconColor: Colors.purple,
            title: "Hygiene Concern",
            category: "Category: Hygiene",
            user: "Vikram Singh • Room 212-C",
            desc: "\"Found a small insect in the salad bowl during lunch today. Please investigate the pantry cleanliness immediately.\"",
            priority: "Urgent",
            priorityColor: Colors.red,
            status: "Pending",
          ),
        ],
      ),
    );
  }

  static Widget _statusBox(String value, String label, Color textColor, Color bgColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: textColor, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _complaintCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String category,
    required String user,
    required String desc,
    required String priority,
    required Color priorityColor,
    required String status,
  }) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(category, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: priorityColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(priority, style: TextStyle(color: priorityColor, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(user, style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.3)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.white),
                        label: const Text("Chat with Student", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003366),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
                            const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}