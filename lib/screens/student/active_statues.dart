import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DailyActiveStatusApp());
}

class DailyActiveStatusApp extends StatelessWidget {
  const DailyActiveStatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Yuvraj Dashboard',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: Color(0xFFF4F6F9),
      ),
      home: SingleDashboardScreen(),
    );
  }
}

class SingleDashboardScreen extends StatelessWidget {
  const SingleDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
          children: [
            // 1. Top Header with Back Button & User Info
            Row(
              children: [
                // Back Button Added Here
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Handle back navigation
                    Navigator.maybePop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(CupertinoIcons.back, size: 20, color: CupertinoColors.activeBlue),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CupertinoColors.activeBlue, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Yuvraj Patwa',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: CupertinoColors.label),
                      ),
                      Text(
                        'Block B - 304',
                        style: TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Icon(CupertinoIcons.bell, size: 18, color: CupertinoColors.label),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 2. Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Row(
                children: [
                  Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey, size: 20),
                  SizedBox(width: 10),
                  Text('Search activities, rooms, status...', style: TextStyle(color: CupertinoColors.systemGrey, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Fuel Meter / Daily Habits Hero Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Daily Health & Fuel Meter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Today 💧', style: TextStyle(fontSize: 13, color: CupertinoColors.activeBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHabitMetric('Water Goal', '2.8L / 3L', CupertinoIcons.drop_fill, CupertinoColors.activeBlue),
                      _buildHabitMetric('Cardio Run', '5.2 km', CupertinoIcons.timer, CupertinoColors.systemOrange),
                      _buildHabitMetric('Meals Eaten', '3 / 3 🍏', CupertinoIcons.checkmark_circle_fill, CupertinoColors.activeGreen),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. Health Status Quick Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4ED),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFFD8BF)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(CupertinoIcons.heart_fill, color: CupertinoColors.systemOrange, size: 24),
                        SizedBox(height: 12),
                        Text('Physical Health', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CupertinoColors.label)),
                        SizedBox(height: 4),
                        Text('215 / 1499 kcal', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F8F0),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFB8E6D0)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.ice_skating, color: CupertinoColors.activeGreen, size: 24),
                        SizedBox(height: 12),
                        Text('Mental Health', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: CupertinoColors.label)),
                        SizedBox(height: 4),
                        Text('459 / 980 mins', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 5. Training List Section
            const Text('TRAINING & WORKOUT LIST', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 10),
            _buildTrainingCard('Upper Body Power - Chest & Arms', '65%', '45 mins left', '3/5 sets Completed', '2/5 sets Not done'),
            const SizedBox(height: 12),
            _buildTrainingCard('Run for 17Km', '70%', '1.5 hours remaining', '40/60km Completed', '20/60km Not done'),
            const SizedBox(height: 20),

            // 6. Growth & Analytics Section
            const Text('GROWTH & ANALYTICS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Row(
                children: [
                  Icon(CupertinoIcons.lightbulb_fill, color: CupertinoColors.systemYellow),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Suggestion', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        SizedBox(height: 2),
                        Text('Do proper stretching. You need to do 15 min proper stretching.', style: TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 7. Hostel & Active Status Hub Section
            const Text('HOSTEL & ACTIVITY HUB', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: CupertinoColors.secondaryLabel)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildInfoRow(CupertinoIcons.home, CupertinoColors.activeBlue, 'Current Room', 'Block B - 304', true),
                  _buildInfoRow(CupertinoIcons.arrow_right_square, CupertinoColors.activeGreen, 'Last Check-in', '28 Jul, 04:30 PM', true),
                  _buildInfoRow(CupertinoIcons.calendar, CupertinoColors.systemPurple, 'Last Attendance', 'Today (Present)', true),
                  _buildInfoRow(CupertinoIcons.doc_text, CupertinoColors.systemIndigo, 'Leave Status', 'Approved', true),
                  _buildInfoRow(CupertinoIcons.wrench, CupertinoColors.systemRed, 'Maintenance', 'In Progress', true),
                  _buildInfoRow(CupertinoIcons.money_dollar_circle, CupertinoColors.systemOrange, 'Next Fee Pay Day', '10 Aug 2026', true),
                  _buildInfoRow(CupertinoIcons.cube_box, CupertinoColors.systemTeal, 'Parcel Status', '1 Package at Reception', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildHabitMetric(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 11, color: CupertinoColors.secondaryLabel)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: CupertinoColors.label)),
      ],
    );
  }

  static Widget _buildTrainingCard(String title, String percent, String time, String status1, String status2) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
              Text(percent, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue)),
            ],
          ),
          const SizedBox(height: 6),
          Text(time, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
          const SizedBox(height: 14),
          Container(height: 8, decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(status1, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: CupertinoColors.activeGreen)),
              Text(status2, style: const TextStyle(fontSize: 12, color: CupertinoColors.secondaryLabel)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildInfoRow(IconData icon, Color color, String title, String value, bool showDivider) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: CupertinoColors.label)),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, indent: 48, color: Color(0xFFF1F5F9)),
      ],
    );
  }
}