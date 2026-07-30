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
                  const SizedBox(height: 28),

                  // Roommate Health Status Widget (Organic Card)
                  Container(
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
                  const SizedBox(height: 32),

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
                              // Breathing organic background ring
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
                              // Progress Ring
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
                              // Organic Touch Button
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
                  const SizedBox(height: 36),

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
                  const SizedBox(height: 32),

                  // Warden & Direct Help Contacts
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildQuickDialButton('Hostel Warden', Icons.person_pin, 'Call'),
                            _buildQuickDialButton('Hostel Doctor', Icons.local_hospital, 'Doctor'),
                            _buildQuickDialButton('Ambulance', Icons.emergency, '102'),
                          ],
                        ),
                      ],
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
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Text(message, style: const TextStyle(fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Theek hai', style: TextStyle(color: Color(0xFFB8321B))),
          ),
        ],
      ),
    );
  }
}