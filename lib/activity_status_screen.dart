import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const IOSActivityApp());
}

class IOSActivityApp extends StatelessWidget {
  const IOSActivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Activity Status - iOS',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      home: ActivityStatusIOSScreen(),
    );
  }
}

class ActivityStatusIOSScreen extends StatelessWidget {
  const ActivityStatusIOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGroupedBackground.withOpacity(0.8),
        middle: const Text(
          'Activity & Status',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.maybePop(context),
          child: const Icon(CupertinoIcons.back, size: 22, color: CupertinoColors.activeBlue),
        ),
        border: null,
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // 1. Live Connection Status Card (iOS Style Widget)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeGreen.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.checkmark_alt_circle_fill,
                      color: CupertinoColors.activeGreen,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Online & Active',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.label,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Last sync: Just now via Secure App',
                          style: TextStyle(
                            fontSize: 13,
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Fee Dues & Payment Section (iOS Grouped Section)
            const Padding(
              padding: EdgeInsets.only(left: 14, bottom: 8),
              child: Text(
                'FEE & FINANCIAL STATUS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.secondaryLabel,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildCupertinoInfoRow(
                    icon: CupertinoIcons.money_dollar_circle_fill,
                    iconColor: CupertinoColors.systemOrange,
                    title: 'Next Fee Due',
                    value: '10 Aug 2026',
                    showDivider: true,
                  ),
                  _buildCupertinoInfoRow(
                    icon: CupertinoIcons.creditcard_fill,
                    iconColor: CupertinoColors.activeBlue,
                    title: 'Pending Amount',
                    value: 'NRs. 12,500',
                    valueColor: CupertinoColors.systemRed,
                    showDivider: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      borderRadius: BorderRadius.circular(12),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.arrow_up_right_square, size: 18),
                          SizedBox(width: 8),
                          Text('Pay Hostel Dues Now', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. System Metrics & Usage Section
            const Padding(
              padding: EdgeInsets.only(left: 14, bottom: 8),
              child: Text(
                'ACCOUNT METRICS & LOGS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.secondaryLabel,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildCupertinoInfoRow(
                    icon: CupertinoIcons.shield_fill,
                    iconColor: CupertinoColors.activeBlue,
                    title: 'Verification',
                    value: 'Verified Student',
                    valueColor: CupertinoColors.activeGreen,
                    showDivider: true,
                  ),
                  _buildCupertinoInfoRow(
                    icon: CupertinoIcons.bed_double_fill,
                    iconColor: CupertinoColors.systemPurple,
                    title: 'Hostel Attendance',
                    value: '94% Safe',
                    showDivider: true,
                  ),
                  _buildCupertinoInfoRow(
                    icon: CupertinoIcons.device_phone_portrait,
                    iconColor: CupertinoColors.systemTeal,
                    title: 'Active Device',
                    value: 'iPhone / Android',
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    Color valueColor = CupertinoColors.label,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Divider(height: 1, color: CupertinoColors.systemGrey5),
          ),
      ],
    );
  }
}