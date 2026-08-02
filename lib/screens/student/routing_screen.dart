import 'package:flutter/material.dart';

class RoutingScreen extends StatelessWidget {
  final Map<String, dynamic>? studentData; // Login state ya user data jo aage pass hoga

  const RoutingScreen({super.key, this.studentData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Campus & Hostel Routing",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
              ),
              const SizedBox(height: 4),
              const Text(
                "Find directions to key locations around the facility",
                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildRouteCard(
                      context,
                      "Main Dining Hall",
                      "Block A, Ground Floor",
                      "2 mins walk",
                      Icons.restaurant_rounded,
                    ),
                    _buildRouteCard(
                      context,
                      "Warden Office",
                      "Administrative Block, 1st Floor",
                      "5 mins walk",
                      Icons.admin_panel_settings_rounded,
                    ),
                    _buildRouteCard(
                      context,
                      "Study & Library Room",
                      "Block B, 2nd Floor",
                      "3 mins walk",
                      Icons.local_library_rounded,
                    ),
                    _buildRouteCard(
                      context,
                      "Medical Room / First Aid",
                      "Security Gate 1",
                      "4 mins walk",
                      Icons.local_hospital_rounded,
                    ),
                    _buildRouteCard(
                      context,
                      "Laundry Service",
                      "Basement Area, Block C",
                      "3 mins walk",
                      Icons.local_laundry_service_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCard(
      BuildContext context,
      String title,
      String location,
      String duration,
      IconData icon,
      ) {
    return InkWell(
      onTap: () {
        // Yahan par jo card select/click hoga, wahi login state ya data aage forward ho jayega
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RouteDetailScreen(
              title: title,
              location: location,
              duration: duration,
              studentData: studentData, // Selected login data aage pass ho raha hai
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                duration,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Detail Screen jahan click kiya hua data aur login state (studentData) pahunchega
class RouteDetailScreen extends StatelessWidget {
  final String title;
  final String location;
  final String duration;
  final Map<String, dynamic>? studentData;

  const RouteDetailScreen({
    super.key,
    required this.title,
    required this.location,
    required this.duration,
    this.studentData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Destination: $title",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 10),
            Text("Location Details: $location", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text("Estimated Time: $duration", style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const Divider(height: 30),
            if (studentData != null) ...[
              const Text(
                "Logged In User Data Passed:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green),
              ),
              const SizedBox(height: 5),
              Text("Name: ${studentData!['studentNameEng'] ?? 'N/A'}"),
              Text("Email: ${studentData!['email'] ?? 'N/A'}"),
            ] else ...[
              const Text("No student session data found.", style: TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}