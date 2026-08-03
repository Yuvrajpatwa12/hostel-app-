import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HostelDetailsScreen extends StatefulWidget {
  const HostelDetailsScreen({super.key});

  @override
  State<HostelDetailsScreen> createState() => _HostelDetailsScreenState();
}

class _HostelDetailsScreenState extends State<HostelDetailsScreen> {
  final TextEditingController _redeemController = TextEditingController();

  @override
  void dispose() {
    _redeemController.dispose();
    super.dispose();
  }

  void _handleRedeem() {
    String code = _redeemController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid referral code!')),
      );
      return;
    }

    // Simulate redemption logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Success! Referral code "$code" redeemed successfully.')),
    );
    _redeemController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hostel Sanctuary & Info',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE2E8F0), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stunning Hero Banner with Modern Gradient
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF4F46E5), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.apartment_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grand View Residence',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Block B • Room No. 304 (Double Sharing)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // // 2. REFER & EARN & REDEEM PROGRAM
            // const Text(
            //   'REFER & EARN PROGRAM',
            //   style: TextStyle(
            //     fontSize: 11,
            //     fontWeight: FontWeight.w700,
            //     color: Color(0xFF64748B),
            //     letterSpacing: 0.8,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(24),
            //     border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withValues(alpha: 0.02),
            //         blurRadius: 10,
            //         offset: const Offset(0, 4),
            //       ),
            //     ],
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               color: const Color(0xFF10B981).withValues(alpha: 0.15),
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: const Icon(Icons.card_giftcard, color: Color(0xFF10B981), size: 24),
            //           ),
            //           const SizedBox(width: 14),
            //           const Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Invite Friends & Earn Rewards!',
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                     color: Color(0xFF0F172A),
            //                   ),
            //                 ),
            //                 SizedBox(height: 2),
            //                 Text(
            //                   'Get Rs. 500 off on mess fee per successful referral.',
            //                   style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 16),
            //       // Share Code Box
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //         decoration: BoxDecoration(
            //           color: const Color(0xFFF1F5F9),
            //           borderRadius: BorderRadius.circular(16),
            //           border: Border.all(color: const Color(0xFFE2E8F0)),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Your Referral Code', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
            //                 SizedBox(height: 2),
            //                 Text('YURI2026HOSTEL', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2563EB), letterSpacing: 1.0)),
            //               ],
            //             ),
            //             ElevatedButton.icon(
            //               onPressed: () {
            //                 Clipboard.setData(const ClipboardData(text: 'YURI2026HOSTEL'));
            //                 ScaffoldMessenger.of(context).showSnackBar(
            //                   const SnackBar(content: Text('Referral code copied to clipboard!')),
            //                 );
            //               },
            //               icon: const Icon(Icons.copy, size: 14),
            //               label: const Text('Copy'),
            //               style: ElevatedButton.styleFrom(
            //                 backgroundColor: const Color(0xFF2563EB),
            //                 foregroundColor: Colors.white,
            //                 elevation: 0,
            //                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            //                 textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //       const Divider(color: Color(0xFFE2E8F0), height: 1),
            //       const SizedBox(height: 16),
            //
            //       // Redeem Code Option Section
            //       const Text(
            //         'Have a Referral Code?',
            //         style: TextStyle(
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xFF0F172A),
            //         ),
            //       ),
            //       const SizedBox(height: 8),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: TextField(
            //               controller: _redeemController,
            //               textCapitalization: TextCapitalization.characters,
            //               decoration: InputDecoration(
            //                 hintText: 'Enter code here...',
            //                 hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            //                 filled: true,
            //                 fillColor: const Color(0xFFF8FAFC),
            //                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(14),
            //                   borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            //                 ),
            //                 enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(14),
            //                   borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            //                 ),
            //                 focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(14),
            //                   borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 10),
            //           ElevatedButton(
            //             onPressed: _handleRedeem,
            //             style: ElevatedButton.styleFrom(
            //               backgroundColor: const Color(0xFF10B981),
            //               foregroundColor: Colors.white,
            //               elevation: 0,
            //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            //               textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //             ),
            //             child: const Text('Redeem'),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 28),

            // 3. Core Hostel & Room Specifications
            const Text(
              'HOSTEL & ROOM SPECIFICATIONS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Hostel Name', 'Grand View Residence', true),
                  _buildInfoRow('Room Number', 'Block B - 304', true),
                  _buildInfoRow('Bed Configuration', 'Double Sharing (Bed B)', true),
                  _buildInfoRow('Floor Level', '3rd Floor', true),
                  _buildInfoRow('Mess Facility', 'Included (Veg / Non-Veg)', true),
                  _buildInfoRow('Warden Incharge', 'Mr. Ramesh Sharma', false, valueColor: Color(0xFF2563EB)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 4. Facilities & Emergency Support
            const Text(
              'FACILITIES & EMERGENCY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Wi-Fi Network', 'High-Speed Fiber (50 Mbps)', true),
                  _buildInfoRow('Power Backup', '24/7 Generator Support', true),
                  _buildInfoRow('Security Guard', 'Main Gate (24 Hours Active)', true),
                  _buildInfoRow('Hostel Helpline', '+977 9811111111', false, valueColor: Color(0xFF10B981)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 5. Terms, Conditions & Rules
            const Text(
              'TERMS, CONDITIONS & GUIDELINES',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please read the following rules carefully:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 12),
                  _TermBulletPoint('Gate Timing: All residents must return to the hostel premises by 9:30 PM sharp.'),
                  _TermBulletPoint('Visitors Policy: External visitors and guests are strictly not allowed inside resident rooms without warden approval.'),
                  _TermBulletPoint('Electricity Usage: Heavy electrical appliances (like room heaters, induction cooktops) are prohibited.'),
                  _TermBulletPoint('Fee Submission: Monthly hostel and mess fees must be cleared on or before the 10th of every month.'),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 6. HOSTEL PRIVACY POLICY SECTION
            const Text(
              'HOSTEL PRIVACY POLICY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined, color: Color(0xFF2563EB), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Data Protection & Security',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your personal information, attendance logs, biometric records, and guardian contact details are strictly protected under institutional data compliance laws. We do not share or monetize resident data with third-party advertising networks.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CCTV surveillance is active in common areas (corridors, lobby, and gates) solely for campus security purposes. Access to footage is strictly restricted to authorized hostel administration.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, bool showDivider, {Color valueColor = const Color(0xFF0F172A)}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),
      ],
    );
  }
}

class _TermBulletPoint extends StatelessWidget {
  final String text;
  const _TermBulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF475569),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}