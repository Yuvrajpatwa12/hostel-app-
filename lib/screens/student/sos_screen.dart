import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> with TickerProviderStateMixin {
  bool _isSosActive = false;
  double _holdProgress = 0.0;
  bool _isLiveLocationShared = true;
  late AnimationController _pulseController;
  late AnimationController _breatheController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  void _triggerSos() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isSosActive = true;
    });
  }

  void _cancelSos() {
    setState(() {
      _isSosActive = false;
      _holdProgress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0), // Organic Warm Cream Background
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Organic Custom Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Sanctuary',
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2C221E),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Hostel Care & Safety System',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF8C7A70),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFECE6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.shield_outlined, color: Color(0xFF5C4A42)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All safety loops are active & encrypted.')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Roommate Health Status Widget (Organic Card)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2E6E2), // Soft terracotta tint
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xFFE2D0C9)),
                      ),
                      child: Row(
                        children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade700,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
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
                                'Aarti (Room 304)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF3D2C24),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Tabiyat theek nahi lag rahi (Mild Fever)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF8A5A4A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_outline, color: Color(0xFF8A5A4A)),
                          onPressed: () {
                            _showRoommateCareModal(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  ),
                  const SizedBox(height: 28),

                  // Center Organic SOS Core Button
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 230,
                          height: 230,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ScaleTransition(
                                scale: Tween(begin: 1.0, end: 1.1).animate(_breatheController),
                                child: Container(
                                  width: 220,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFFD94E36).withOpacity(0.12),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 190,
                                height: 190,
                                child: CircularProgressIndicator(
                                  value: _holdProgress,
                                  strokeWidth: 6,
                                  backgroundColor: const Color(0xFFE2D0C9),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD94E36)),
                                ),
                              ),
                              GestureDetector(
                                onTapDown: (_) {
                                  HapticFeedback.mediumImpact();
                                  _simulateHold();
                                },
                                onTapUp: (_) => _cancelSos(),
                                onTapCancel: _cancelSos,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFE05638), Color(0xFFB8321B)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFD94E36).withOpacity(0.4),
                                        blurRadius: 25,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'SOS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 38,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'PRESS & HOLD',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Apni suraksha ke liye 3 second press karke rakhein',
                          style: TextStyle(
                            color: Color(0xFF8C7A70),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 🌟 QUICK DIRECT DIAL MOVED TO A BETTER PROMINENT SPOT (Right Below SOS)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE2D0C9)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quick Direct Dial',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C221E),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => _showCustomActionDialog(context, 'Hostel Warden', 'Warden ko call lagayi ja rahi hai...'),
                                child: _buildQuickDialButton('Hostel Warden', Icons.person_pin, 'Call'),
                              ),
                              GestureDetector(
                                onTap: () => _showCustomActionDialog(context, 'Hostel Doctor', 'Doctor ko call lagayi ja rahi hai...'),
                                child: _buildQuickDialButton('Hostel Doctor', Icons.local_hospital, 'Doctor'),
                              ),
                              GestureDetector(
                                onTap: () => _showCustomActionDialog(context, 'Ambulance 102', 'Ambulance 102 par call kiya ja raha hai...'),
                                child: _buildQuickDialButton('Ambulance', Icons.emergency, '102'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Share Live Location Toggle Card
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2D0C9)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBF4EC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.location_on, color: Color(0xFF4A5D4E), size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Share Live Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF2C221E),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Update contacts with your real-time coordinates',
                                  style: TextStyle(fontSize: 11, color: Color(0xFF8C7A70)),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isLiveLocationShared,
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFF4A5D4E),
                            onChanged: (val) {
                              setState(() {
                                _isLiveLocationShared = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Hostel Specific Practical Emergency Grid (Organic Style)
                  const Text(
                    'Instant Emergency Assistance',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C221E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 2.3,
                    children: [
                      _buildOrganicCard('Roommate Tabiyat', Icons.medical_services_outlined, const Color(0xFFD94E36), () {
                        _showCustomActionDialog(context, 'Roommate Medical Alert', 'Roommate ki tabiyat kharab hone ka alert Warden aur Doctor ko bhej diya gaya hai.');
                      }),
                      _buildOrganicCard('Midnight Security', Icons.nightlight_outlined, const Color(0xFF4A5D4E), () {
                        _showCustomActionDialog(context, 'Midnight Security Guard', 'Gate guard ko aapke room ki taraf bheja ja raha hai.');
                      }),
                      _buildOrganicCard('Room Lock Issue', Icons.key_outlined, const Color(0xFF8C6D4F), () {
                        _showCustomActionDialog(context, 'Maintenance Support', 'Hostel electrician/carpenter ko notify kar diya hai.');
                      }),
                      _buildOrganicCard('Anti-Panic Space', Icons.self_improvement_outlined, const Color(0xFF5A6B7C), () {
                        _showCalmingModal(context);
                      }),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Hostel Authority / Warden Card
                  _buildAuthorityCard(
                    category: 'HOSTEL AUTHORITY',
                    title: 'Hostel Warden',
                    subtitle: 'Mr. Robert Wilson • Block A, Room 102',
                    buttonText: 'Call',
                    buttonColor: const Color(0xFF4A5D4E),
                    iconData: Icons.phone,
                    secondaryIcon: Icons.chat_bubble_outline,
                    onPressed: () {
                      _showCustomActionDialog(context, 'Hostel Warden', 'Warden ko call lagayi ja rahi hai...');
                    },
                  ),
                  const SizedBox(height: 16),

                  // Medical / Ambulance Card
                  _buildAuthorityCard(
                    category: 'MEDICAL',
                    title: 'Ambulance',
                    subtitle: 'Campus Medical Center • 24/7 Available',
                    buttonText: 'Call 108',
                    buttonColor: const Color(0xFFD94E36),
                    iconData: Icons.phone,
                    badgeIcon: Icons.medical_services_outlined,
                    onPressed: () {
                      _showCustomActionDialog(context, 'Ambulance Alert', 'Emergency ambulance ko notify kar diya gaya hai.');
                    },
                  ),
                  const SizedBox(height: 16),

                  // Public Safety / Police Dept Card
                  _buildAuthorityCard(
                    category: 'PUBLIC SAFETY',
                    title: 'Police Dept.',
                    subtitle: 'Downtown Station • 0.8 miles away',
                    buttonText: 'Call 100',
                    buttonColor: const Color(0xFF2C221E),
                    iconData: Icons.phone,
                    badgeIcon: Icons.local_police_outlined,
                    onPressed: () {
                      _showCustomActionDialog(context, 'Police Alert', 'Local police station ko alert bhej diya gaya hai.');
                    },
                  ),
                  const SizedBox(height: 28),

                  // Safety Stations Near You Header + World Map Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Safety Stations Near You',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C221E),
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A5D4E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // 🌟 WORLD MAP IMAGE PLACED HERE
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2D0C9)),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1589519160732-57fc498494f8?auto=format&fit=crop&w=800&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEBF4EC),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.local_hospital, color: Color(0xFF4A5D4E), size: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'City Hospital',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF2C221E)),
                                        ),
                                        Text(
                                          '0.4 km • Open Now',
                                          style: TextStyle(fontSize: 11, color: Color(0xFF8C7A70)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.shield, color: Color(0xFF4A5D4E), size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Full Screen Emergency Triggered Overlay
          if (_isSosActive)
            Container(
              color: const Color(0xFFB8321B).withOpacity(0.96),
              padding: const EdgeInsets.all(24),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '🔴 LIVE EMERGENCY BROADCAST',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 28),
                          onPressed: _cancelSos,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'SOS',
                              style: TextStyle(
                                color: Color(0xFFB8321B),
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'MADAD RAHI HAI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Aapka live location, roommate ka status aur medical details hostel security aur warden ke paas bhej diye gaye hain.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFB8321B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _cancelSos,
                        child: const Text(
                          'MAIN THEEK HOON - CANCEL',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrganicCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEFECE6)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFF2C221E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorityCard({
    required String category,
    required String title,
    required String subtitle,
    required String buttonText,
    required Color buttonColor,
    required IconData iconData,
    IconData? badgeIcon,
    IconData? secondaryIcon,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2D0C9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C7A70),
                  letterSpacing: 0.5,
                ),
              ),
              if (badgeIcon != null)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBEBE8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(badgeIcon, color: const Color(0xFFD94E36), size: 16),
                )
              else
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF4EC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFF4A5D4E), size: 16),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C221E),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8C7A70),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: onPressed,
                  icon: Icon(iconData, size: 16),
                  label: Text(
                    buttonText,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
              if (secondaryIcon != null) ...[
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFECE6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(secondaryIcon, color: const Color(0xFF2C221E), size: 20),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening direct chat with Warden...')),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDialButton(String label, IconData icon, String action) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F6F0),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2D0C9)),
          ),
          child: Icon(icon, color: const Color(0xFF5C4A42), size: 22),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF5C4A42)),
        ),
      ],
    );
  }

  void _simulateHold() async {
    setState(() => _holdProgress = 0.0);
    for (int i = 1; i <= 30; i++) {
      if (!_isSosActive && _holdProgress == 0.0) break;
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        setState(() {
          _holdProgress = i / 30.0;
          if (_holdProgress >= 1.0) {
            _triggerSos();
          }
        });
      }
    }
  }

  void _showRoommateCareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF9F6F0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Roommate Care Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C221E)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Agar aapke roommate ki tabiyat kharab hai, toh kya aapko turant medical kit ya soup mangwana hai?',
              style: TextStyle(fontSize: 13, color: Color(0xFF5C4A42)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A5D4E),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mess aur Warden ko soup/medicine ke liye notify kar diya gaya hai!')),
                );
              },
              child: const Text('Send Medical Kit / Soup Request'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCalmingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF9F6F0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.self_improvement, size: 40, color: Color(0xFF5A6B7C)),
            const SizedBox(height: 12),
            const Text(
              'Deep Breathing Exercise',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C221E)),
            ),
            const SizedBox(height: 8),
            const Text(
              'Saans lijiye... Dheere se chhodiye. Aap bilkul surakshit hain.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Color(0xFF5C4A42)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showCustomActionDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFF9F6F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2C221E))),
        content: Text(message, style: const TextStyle(fontSize: 13, color: Color(0xFF5C4A42))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Theek hai', style: TextStyle(color: Color(0xFFB8321B), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SosScreen extends StatefulWidget {
//   const SosScreen({Key? key}) : super(key: key);

//   @override
//   State<SosScreen> createState() => _SosScreenState();
// }

// class _SosScreenState extends State<SosScreen> with TickerProviderStateMixin {
//   bool _isSosActive = false;
//   double _holdProgress = 0.0;
//   late AnimationController _pulseController;
//   late AnimationController _breatheController;

//   @override
//   void initState() {
//     super.initState();
//     _pulseController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _breatheController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 4),
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _pulseController.dispose();
//     _breatheController.dispose();
//     super.dispose();
//   }

//   void _triggerSos() {
//     HapticFeedback.heavyImpact();
//     setState(() {
//       _isSosActive = true;
//     });
//   }

//   void _cancelSos() {
//     setState(() {
//       _isSosActive = false;
//       _holdProgress = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F6F0), // Organic Warm Cream Background
//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Organic Custom Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Sanctuary',
//                             style: TextStyle(
//                               fontFamily: 'serif',
//                               fontSize: 28,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF2C221E),
//                             ),
//                           ),
//                           SizedBox(height: 2),
//                           Text(
//                             'Hostel Care & Safety System',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xFF8C7A70),
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFEFECE6),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.shield_outlined, color: Color(0xFF5C4A42)),
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('All safety loops are active & encrypted.')),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 28),

//                   // Roommate Health Status Widget (Organic Card)
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF2E6E2), // Soft terracotta tint
//                       borderRadius: BorderRadius.circular(28),
//                       border: Border.all(color: const Color(0xFFE2D0C9)),
//                     ),
//                     child: Row(
//                       children: [
//                         Stack(
//                           children: [
//                             const CircleAvatar(
//                               radius: 28,
//                               backgroundImage: NetworkImage(
//                                 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
//                               ),
//                             ),
//                             Positioned(
//                               bottom: 0,
//                               right: 0,
//                               child: Container(
//                                 width: 14,
//                                 height: 14,
//                                 decoration: BoxDecoration(
//                                   color: Colors.amber.shade700,
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: Colors.white, width: 2),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Aarti (Room 304)',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Color(0xFF3D2C24),
//                                 ),
//                               ),
//                               SizedBox(height: 2),
//                               Text(
//                                 'Tabiyat theek nahi lag rahi (Mild Fever)',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xFF8A5A4A),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.favorite_outline, color: Color(0xFF8A5A4A)),
//                           onPressed: () {
//                             _showRoommateCareModal(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 32),

//                   // Center Organic SOS Core Button
//                   Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: 230,
//                           height: 230,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               // Breathing organic background ring
//                               ScaleTransition(
//                                 scale: Tween(begin: 1.0, end: 1.1).animate(_breatheController),
//                                 child: Container(
//                                   width: 220,
//                                   height: 220,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: const Color(0xFFD94E36).withOpacity(0.12),
//                                   ),
//                                 ),
//                               ),
//                               // Progress Ring
//                               SizedBox(
//                                 width: 190,
//                                 height: 190,
//                                 child: CircularProgressIndicator(
//                                   value: _holdProgress,
//                                   strokeWidth: 6,
//                                   backgroundColor: const Color(0xFFE2D0C9),
//                                   valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD94E36)),
//                                 ),
//                               ),
//                               // Organic Touch Button
//                               GestureDetector(
//                                 onTapDown: (_) {
//                                   HapticFeedback.mediumImpact();
//                                   _simulateHold();
//                                 },
//                                 onTapUp: (_) => _cancelSos(),
//                                 onTapCancel: _cancelSos,
//                                 child: Container(
//                                   width: 150,
//                                   height: 150,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     gradient: const LinearGradient(
//                                       colors: [Color(0xFFE05638), Color(0xFFB8321B)],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: const Color(0xFFD94E36).withOpacity(0.4),
//                                         blurRadius: 25,
//                                         offset: const Offset(0, 10),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       Text(
//                                         'SOS',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 38,
//                                           fontWeight: FontWeight.w800,
//                                           letterSpacing: 2,
//                                         ),
//                                       ),
//                                       SizedBox(height: 4),
//                                       Text(
//                                         'PRESS & HOLD',
//                                         style: TextStyle(
//                                           color: Colors.white70,
//                                           fontSize: 9,
//                                           fontWeight: FontWeight.bold,
//                                           letterSpacing: 1.5,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text(
//                           'Apni suraksha ke liye 3 second press karke rakhein',
//                           style: TextStyle(
//                             color: Color(0xFF8C7A70),
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 36),

//                   // Hostel Specific Practical Emergency Grid (Organic Style)
//                   const Text(
//                     'Instant Emergency Assistance',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2C221E),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   GridView.count(
//                     crossAxisCount: 2,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     mainAxisSpacing: 14,
//                     crossAxisSpacing: 14,
//                     childAspectRatio: 2.3,
//                     children: [
//                       _buildOrganicCard('Roommate Tabiyat', Icons.medical_services_outlined, const Color(0xFFD94E36), () {
//                         _showCustomActionDialog(context, 'Roommate Medical Alert', 'Roommate ki tabiyat kharab hone ka alert Warden aur Doctor ko bhej diya gaya hai.');
//                       }),
//                       _buildOrganicCard('Midnight Security', Icons.nightlight_outlined, const Color(0xFF4A5D4E), () {
//                         _showCustomActionDialog(context, 'Midnight Security Guard', 'Gate guard ko aapke room ki taraf bheja ja raha hai.');
//                       }),
//                       _buildOrganicCard('Room Lock Issue', Icons.key_outlined, const Color(0xFF8C6D4F), () {
//                         _showCustomActionDialog(context, 'Maintenance Support', 'Hostel electrician/carpenter ko notify kar diya hai.');
//                       }),
//                       _buildOrganicCard('Anti-Panic Space', Icons.self_improvement_outlined, const Color(0xFF5A6B7C), () {
//                         _showCalmingModal(context);
//                       }),
//                     ],
//                   ),
//                   const SizedBox(height: 32),

//                   // Warden & Direct Help Contacts
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(24),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.03),
//                           blurRadius: 15,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Quick Direct Dial',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF2C221E),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _buildQuickDialButton('Hostel Warden', Icons.person_pin, 'Call'),
//                             _buildQuickDialButton('Hostel Doctor', Icons.local_hospital, 'Doctor'),
//                             _buildQuickDialButton('Ambulance', Icons.emergency, '102'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ),

//           // Full Screen Emergency Triggered Overlay
//           if (_isSosActive)
//             Container(
//               color: const Color(0xFFB8321B).withOpacity(0.96),
//               padding: const EdgeInsets.all(24),
//               child: SafeArea(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Text(
//                             '🔴 LIVE EMERGENCY BROADCAST',
//                             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.close, color: Colors.white, size: 28),
//                           onPressed: _cancelSos,
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: 110,
//                           height: 110,
//                           decoration: const BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'SOS',
//                               style: TextStyle(
//                                 color: Color(0xFFB8321B),
//                                 fontSize: 42,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         const Text(
//                           'MADAD RAHI HAI',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Aapka live location, roommate ka status aur medical details hostel security aur warden ke paas bhej diye gaye hain.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: const Color(0xFFB8321B),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 0,
//                         ),
//                         onPressed: _cancelSos,
//                         child: const Text(
//                           'MAIN THEEK HOON - CANCEL',
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrganicCard(String title, IconData icon, Color color, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(18),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: const Color(0xFFEFECE6)),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, color: color, size: 18),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 12,
//                   color: Color(0xFF2C221E),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickDialButton(String label, IconData icon, String action) {
//     return Column(
//       children: [
//         Container(
//           width: 54,
//           height: 54,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF9F6F0),
//             shape: BoxShape.circle,
//             border: Border.all(color: const Color(0xFFE2D0C9)),
//           ),
//           child: Icon(icon, color: const Color(0xFF5C4A42), size: 22),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF5C4A42)),
//         ),
//       ],
//     );
//   }

//   void _simulateHold() async {
//     setState(() => _holdProgress = 0.0);
//     for (int i = 1; i <= 30; i++) {
//       if (!_isSosActive && _holdProgress == 0.0) break;
//       await Future.delayed(const Duration(milliseconds: 100));
//       if (mounted) {
//         setState(() {
//           _holdProgress = i / 30.0;
//         });
//       }
//     }
//   }

//   void _showRoommateCareModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFFF9F6F0),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Roommate Care Support',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C221E)),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Agar aapke roommate ki tabiyat kharab hai, toh kya aapko turant medical kit ya soup mangwana hai?',
//               style: TextStyle(fontSize: 13, color: Color(0xFF5C4A42)),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4A5D4E),
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(double.infinity, 48),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 elevation: 0,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Mess aur Warden ko soup/medicine ke liye notify kar diya gaya hai!')),
//                 );
//               },
//               child: const Text('Send Medical Kit / Soup Request'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCalmingModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFFF9F6F0),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
//       ),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(Icons.self_improvement, size: 40, color: Color(0xFF5A6B7C)),
//             const SizedBox(height: 12),
//             const Text(
//               'Deep Breathing Exercise',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C221E)),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Saans lijiye... Dheere se chhodiye. Aap bilkul surakshit hain.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 13, color: Color(0xFF5C4A42)),
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCustomActionDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: const Color(0xFFF9F6F0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         content: Text(message, style: const TextStyle(fontSize: 13)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Theek hai', style: TextStyle(color: Color(0xFFB8321B))),
//           ),
//         ],
//       ),
//     );
//   }
// }
