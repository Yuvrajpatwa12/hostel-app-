import 'package:flutter/material.dart';

class WardenSignupScreen extends StatefulWidget {
  const WardenSignupScreen({super.key});

  @override
  State<WardenSignupScreen> createState() => _WardenSignupScreenState();
}

class _WardenSignupScreenState extends State<WardenSignupScreen> {
  // Mock Data for Leave Requests
  final List<Map<String, dynamic>> _leaveRequests = [
    {"name": "Aarav Sharma", "room": "Block A - 102", "reason": "Family Emergency", "status": "Pending"},
    {"name": "Rohan Verma", "room": "Block B - 204", "reason": "Medical Checkup", "status": "Pending"},
    {"name": "Siddharth Roy", "room": "Block A - 310", "reason": "Home Visit", "status": "Pending"},
  ];

  void _updateLeaveStatus(int index, String status) {
    setState(() {
      _leaveRequests[index]["status"] = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Leave request $status successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text("Warden Dashboard", style: TextStyle(color: Color(0xFF0B1C30), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0B1C30)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF006E2F)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF006E2F), Color(0xFF22C55E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome, Warden!",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Manage student leaves, room allocation, and hostel safety.",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Statistics Grid
              Row(
                children: [
                  Expanded(child: _buildStatCard("Total Students", "180", Icons.group, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard("Rooms Occupied", "92%", Icons.meeting_room, Colors.orange)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildStatCard("Pending Leaves", "${_leaveRequests.where((e) => e['status'] == 'Pending').length}", Icons.pending_actions, Colors.red)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard("Complaints", "3 Active", Icons.report_problem, Colors.purple)),
                ],
              ),
              const SizedBox(height: 28),

              // Section: Student Leave Requests
              const Text(
                "Student Leave Requests",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
              ),
              const SizedBox(height: 12),

              _leaveRequests.isEmpty
                  ? const Center(child: Text("No pending leave requests.", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _leaveRequests.length,
                itemBuilder: (context, index) {
                  final req = _leaveRequests[index];
                  bool isPending = req["status"] == "Pending";

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(req["name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: req["status"] == "Approved"
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : req["status"] == "Rejected"
                                    ? Colors.red.withValues(alpha: 0.1)
                                    : Colors.orange.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                req["status"],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: req["status"] == "Approved"
                                      ? Colors.green
                                      : req["status"] == "Rejected"
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text("${req["room"]} • Reason: ${req["reason"]}", style: const TextStyle(fontSize: 13, color: Color(0xFF6D7B6C))),
                        const SizedBox(height: 12),
                        if (isPending)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => _updateLeaveStatus(index, "Rejected"),
                                child: const Text("Reject"),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF006E2F),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => _updateLeaveStatus(index, "Approved"),
                                child: const Text("Approve", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF6D7B6C))),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
            ],
          ),
        ],
      ),
    );
  }
}
