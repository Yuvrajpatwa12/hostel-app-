import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class FoodFeedbackScreen extends StatefulWidget {
  const FoodFeedbackScreen({super.key});

  @override
  State<FoodFeedbackScreen> createState() => _FoodFeedbackScreenState();
}

class _FoodFeedbackScreenState extends State<FoodFeedbackScreen> {
  bool _isScanned = false; // Tracks whether QR code has been scanned

  @override
  Widget build(BuildContext context) {
    // Phase 1: If QR is not scanned yet, open Real Camera Scanner with custom UI
    if (!_isScanned) {
      return QRScanScreen(
        onScanSuccess: (String code) {
          setState(() {
            _isScanned = true;
          });
        },
      );
    }

    // Phase 2: After successful scan, show the Tabbed Food Review Screen
    return const TabbedFoodReviewScreen();
  }
}

// ==========================================
// 1. REAL CAMERA QR SCANNER SCREEN
// ==========================================
class QRScanScreen extends StatefulWidget {
  final Function(String) onScanSuccess;

  const QRScanScreen({super.key, required this.onScanSuccess});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _hasScanned = false;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _handleDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        _hasScanned = true;
        widget.onScanSuccess(barcode.rawValue!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR Code Scanned & Attendance Marked Successfully! ✅'),
            backgroundColor: Color(0xFF16A34A),
          ),
        );
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Real Camera View
          MobileScanner(
            controller: _cameraController,
            onDetect: _handleDetect,
          ),

          // Custom Dark Overlay with Scanner Box Finder Frame
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: const SizedBox.expand(),
          ),

          // Top App Bar & Flash Control
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const Text(
                    'Scan Canteen QR',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => _cameraController.toggleTorch(),
                    icon: const Icon(Icons.flash_on, color: Colors.white, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Instructions
          Positioned(
            bottom: 50,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, color: Color(0xFF3B82F6), size: 22),
                  SizedBox(width: 12),
                  Text(
                    'Align canteen QR code inside the frame',
                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw Scanner Target Box overlay
class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6);

    final Paint borderPaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final double scanAreaSize = size.width * 0.7;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;

    final Rect scanRect = Rect.fromLTWH(left, top, scanAreaSize, scanAreaSize);

    // Draw dark background around scan window
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(24))),
      ),
      backgroundPaint,
    );

    // Draw gorgeous corner borders for scanner frame
    final double cornerLength = 30.0;
    final Path cornerPath = Path();

    // Top-Left
    cornerPath.moveTo(left, top + cornerLength);
    cornerPath.lineTo(left, top);
    cornerPath.lineTo(left + cornerLength, top);

    // Top-Right
    cornerPath.moveTo(left + scanAreaSize - cornerLength, top);
    cornerPath.lineTo(left + scanAreaSize, top);
    cornerPath.lineTo(left + scanAreaSize, top + cornerLength);

    // Bottom-Left
    cornerPath.moveTo(left, top + scanAreaSize - cornerLength);
    cornerPath.lineTo(left, top + scanAreaSize);
    cornerPath.lineTo(left + cornerLength, top + scanAreaSize);

    // Bottom-Right
    cornerPath.moveTo(left + scanAreaSize - cornerLength, top + scanAreaSize);
    cornerPath.lineTo(left + scanAreaSize, top + scanAreaSize);
    cornerPath.lineTo(left + scanAreaSize, top + scanAreaSize - cornerLength);

    canvas.drawPath(cornerPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 2. TABBED FOOD REVIEW SCREEN (Give Review & See Reviews)
// ==========================================
class TabbedFoodReviewScreen extends StatefulWidget {
  const TabbedFoodReviewScreen({super.key});

  @override
  State<TabbedFoodReviewScreen> createState() => _TabbedFoodReviewScreenState();
}

class _TabbedFoodReviewScreenState extends State<TabbedFoodReviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Food Review & Feedback', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF2563EB),
              unselectedLabelColor: const Color(0xFF64748B),
              indicatorColor: const Color(0xFF2563EB),
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'Give Review'),
                Tab(text: 'See Reviews'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          GiveReviewTab(),
          SeeReviewsTab(),
        ],
      ),
    );
  }
}

// ==========================================
// TAB 1: GIVE REVIEW
// ==========================================
class GiveReviewTab extends StatefulWidget {
  const GiveReviewTab({super.key});

  @override
  State<GiveReviewTab> createState() => _GiveReviewTabState();
}

class _GiveReviewTabState extends State<GiveReviewTab> {
  String _mealSession = 'Lunch';
  double _rating = 4.0;
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    if (_feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write a short comment about today’s food!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 28),
            SizedBox(width: 10),
            Text('Review Submitted', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Your food feedback has been successfully submitted and shared with management and parents.',
          style: TextStyle(fontSize: 13, color: Color(0xFF475569)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to profile
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: const [
                Icon(Icons.verified, color: Color(0xFF16A34A), size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'QR Verified Successfully! You can now rate your meal and write your feedback below.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF14532D), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'SELECT MEAL SESSION',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
          ),
          const SizedBox(height: 10),
          Row(
            children: ['Breakfast', 'Lunch', 'Dinner'].map((session) {
              bool isSelected = _mealSession == session;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _mealSession = session),
                  child: Container(
                    margin: EdgeInsets.only(right: session != 'Dinner' ? 8 : 0),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      session,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : const Color(0xFF64748B)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'RATE FOOD QUALITY',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    double star = index + 1.0;
                    return GestureDetector(
                      onTap: () => setState(() => _rating = star),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          _rating >= star ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: const Color(0xFFF59E0B),
                          size: 38,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Text(
                  _rating >= 4 ? 'Delicious & Fresh! ⭐' : (_rating >= 3 ? 'Average Quality' : 'Needs Improvement'),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'YOUR COMMENTS',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B), letterSpacing: 0.8),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _feedbackController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your thoughts about taste, hygiene, or quality...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Submit Review', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// TAB 2: SEE REVIEWS (Hostel Feed)
// ==========================================
class SeeReviewsTab extends StatelessWidget {
  const SeeReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyReviews = [
      {'name': 'Aakash Sharma', 'session': 'Lunch', 'rating': 5.0, 'comment': 'Paneer curry and rice today were exceptionally good and fresh!', 'time': '2 hours ago'},
      {'name': 'Rohan Gupta', 'session': 'Breakfast', 'rating': 4.0, 'comment': 'Poha and tea were warm and nicely prepared.', 'time': '7 hours ago'},
      {'name': 'Manish Verma', 'session': 'Dinner', 'rating': 3.0, 'comment': 'Dal was a bit too watery today. Needs improvement.', 'time': 'Yesterday'},
      {'name': 'Sanjay Yadav', 'session': 'Lunch', 'rating': 4.5, 'comment': 'Salad and curd quality was very satisfying.', 'time': 'Yesterday'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: dummyReviews.length,
      itemBuilder: (context, index) {
        final review = dummyReviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.1),
                        child: Text(
                          review['name'][0],
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                          Text('Meal: ${review['session']}', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: Color(0xFFD97706)),
                        const SizedBox(width: 4),
                        Text('${review['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF92400E))),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                review['comment'],
                style: const TextStyle(fontSize: 13, color: Color(0xFF334155), height: 1.4),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(review['time'], style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
              ),
            ],
          ),
        );
      },
    );
  }
}