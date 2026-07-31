import 'package:flutter/material.dart';

class ReportsAnalyticsScreen extends StatelessWidget {
  const ReportsAnalyticsScreen({super.key});

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
            const Text(
              "Reports & Analytics",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              "Performance metrics for Academic Year 2023-24",
              style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            // Filter Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("Last 30 Days", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF0F172A)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 1. ACTIVE USERS DAILY CHART
            _buildChartCard(
              title: "ACTIVE USERS DAILY",
              subtitle: "+12% vs last week",
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: CustomPaint(painter: AnalyticsLinePainter()),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Mon", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Tue", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Wed", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Thu", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Fri", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Sat", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Sun", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. MESS SATISFACTION DONUT CHART
            _buildChartCard(
              title: "MESS SATISFACTION",
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 130,
                      width: 130,
                      child: CustomPaint(painter: MessSatisfactionDonutPainter()),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF003399), shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          const Text("Excellent (45%)", style: TextStyle(fontSize: 11, color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Row(
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF047857), shape: BoxShape.circle)),
                          const SizedBox(width: 6),
                          const Text("Good (30%)", style: TextStyle(fontSize: 11, color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. HOSTEL CAPACITY GROWTH
            _buildChartCard(
              title: "HOSTEL CAPACITY GROWTH",
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: CustomPaint(painter: CapacityGrowthPainter()),
              ),
            ),
            const SizedBox(height: 16),

            // 4. MONTHLY COMPLAINT VOLUME (Y-Axis Numbers थपिएको)
            _buildChartCard(
              title: "MONTHLY COMPLAINT VOLUME",
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: CustomPaint(painter: ComplaintVolumePainter()),
              ),
            ),
            const SizedBox(height: 16),

            // 5. WEEKLY PEAK OCCUPANCY HOURS
            _buildChartCard(
              title: "WEEKLY PEAK OCCUPANCY\nHOURS",
              subtitleWidget: Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text("Low", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                  const SizedBox(width: 8),
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: const Color(0xFF003399), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  const Text("High", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Mon", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Tue", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Wed", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Thu", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Fri", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Sat", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                      Text("Sun", style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildOccupancyGrid(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF003399),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {},
        child: const Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildChartCard({required String title, String? subtitle, Widget? subtitleWidget, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B), letterSpacing: 0.5)),
              if (subtitle != null) Text(subtitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF047857))),
              if (subtitleWidget != null) subtitleWidget,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildOccupancyGrid() {
    final List<List<Color>> gridColors = [
      [const Color(0xFFE0E7FF), const Color(0xFF1D4ED8), const Color(0xFF2563EB), const Color(0xFF3B82F6), const Color(0xFF2563EB), const Color(0xFF93C5FD), const Color(0xFFBFDBFE)],
      [const Color(0xFF1D4ED8), const Color(0xFF93C5FD), const Color(0xFFBFDBFE), const Color(0xFFE0E7FF), const Color(0xFFE0E7FF), const Color(0xFF2563EB), const Color(0xFF93C5FD)],
      [const Color(0xFFEEF2FF), const Color(0xFFEEF2FF), const Color(0xFF3B82F6), const Color(0xFFBFDBFE), const Color(0xFF1E40AF), const Color(0xFF93C5FD), const Color(0xFF1E40AF)],
      [const Color(0xFFBFDBFE), const Color(0xFF3B82F6), const Color(0xFFBFDBFE), const Color(0xFFBFDBFE), const Color(0xFF1E40AF), const Color(0xFF003399), const Color(0xFF93C5FD)],
      [const Color(0xFFEEF2FF), const Color(0xFF1D4ED8), const Color(0xFF93C5FD), const Color(0xFFBFDBFE), const Color(0xFFBFDBFE), const Color(0xFFBFDBFE), const Color(0xFF1D4ED8)],
    ];

    return Column(
      children: gridColors.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: row.map((color) {
              return Container(
                width: 38,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.grid_view_rounded, color: Color(0xFF003399)),
          const SizedBox(width: 8),
          const Text(
            "HostelMate",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_none_outlined, color: Color(0xFF003399), size: 20),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150'),
        ),
        const SizedBox(width: 16),
      ],
      iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.grid_view_rounded, "Dashboard", false, () => Navigator.pop(context)),
          _buildNavItem(Icons.check_box_outlined, "Manage", false, () {}),
          _buildNavItem(Icons.insert_chart_outlined, "Reports", true, () {}),
          _buildNavItem(Icons.person_outline, "Profile", false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFA7F3D0) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF065F46) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFF065F46) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

// Line Chart Painter
class AnalyticsLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = const Color(0xFF003399)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF003399).withValues(alpha: 0.15),
          const Color(0xFF003399).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path();
    path.moveTo(0, size.height * 0.9);
    path.cubicTo(size.width * 0.15, size.height * 0.3, size.width * 0.25, size.height * 0.6, size.width * 0.35, size.height * 0.7);
    path.cubicTo(size.width * 0.45, size.height * 0.1, size.width * 0.55, size.height * 0.0, size.width * 0.65, size.height * 0.4);
    path.cubicTo(size.width * 0.75, size.height * 0.7, size.width * 0.85, size.height * 0.75, size.width, size.height * 0.6);

    Path fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Donut Chart Painter
class MessSatisfactionDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 22.0;
    Rect rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth);

    Paint paintBlue = Paint()
      ..color = const Color(0xFF003399)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint paintGreen = Paint()
      ..color = const Color(0xFF047857)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint paintPeach = Paint()
      ..color = const Color(0xFFFED7AA)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, -1.57, 2.8, false, paintBlue); // 45%
    canvas.drawArc(rect, 1.25, 1.9, false, paintGreen); // 30%
    canvas.drawArc(rect, 3.18, 1.5, false, paintPeach); // 25%
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Hostel Capacity Growth Line Chart Painter
class CapacityGrowthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.0;

    List<String> yLabels = ["750", "700", "650", "600", "550", "500", "450"];
    double stepY = size.height / (yLabels.length - 1);

    for (int i = 0; i < yLabels.length; i++) {
      double y = i * stepY;
      canvas.drawLine(Offset(30, y), Offset(size.width, y), gridPaint);

      TextPainter tp = TextPainter(
        text: TextSpan(text: yLabels[i], style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 6));
    }

    List<Offset> points = [
      Offset(35, size.height * 0.95),
      Offset(35 + (size.width - 35) * 0.2, size.height * 0.85),
      Offset(35 + (size.width - 35) * 0.4, size.height * 0.73),
      Offset(35 + (size.width - 35) * 0.6, size.height * 0.48),
      Offset(35 + (size.width - 35) * 0.8, size.height * 0.25),
      Offset(size.width - 10, size.height * 0.05),
    ];

    Paint linePaint = Paint()
      ..color = const Color(0xFF047857)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    Path path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    Paint dotPaint = Paint()..color = const Color(0xFF047857);
    for (var p in points) {
      canvas.drawCircle(p, 4, dotPaint);
    }

    List<String> xLabels = ["2019", "2020", "2021", "2022", "2023", "2024"];
    for (int i = 0; i < xLabels.length; i++) {
      TextPainter tp = TextPainter(
        text: TextSpan(text: xLabels[i], style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(points[i].dx - 10, size.height + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 🎯 FIXED: Monthly Complaint Volume Bar Chart Painter with Y-Axis Numbers (0-20)
class ComplaintVolumePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double leftMargin = 28.0;
    double bottomMargin = 20.0;
    double chartWidth = size.width - leftMargin;
    double chartHeight = size.height - bottomMargin;

    Paint gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 0.8;

    // Draw Y-Axis Labels (20, 18, 16, ..., 0) & Horizontal Lines
    List<String> yLabels = ["20", "18", "16", "14", "12", "10", "8", "6", "4", "2", "0"];
    double yStep = chartHeight / (yLabels.length - 1);

    for (int i = 0; i < yLabels.length; i++) {
      double y = i * yStep;

      // Subtle horizontal grid lines
      canvas.drawLine(Offset(leftMargin, y), Offset(size.width, y), gridPaint);

      // Y-axis numbers
      TextPainter tp = TextPainter(
        text: TextSpan(text: yLabels[i], style: const TextStyle(fontSize: 9, color: Color(0xFF94A3B8))),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(0, y - 5));
    }

    // Data values corresponding to 0-20 scale
    List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
    List<double> darkValues = [12, 19, 3, 5, 2, 3];
    List<double> lightValues = [5, 2, 8, 3, 10, 4];

    double gap = chartWidth / months.length;

    Paint paintDark = Paint()..color = const Color(0xFF003399);
    Paint paintLight = Paint()..color = const Color(0xFFE0E7FF);

    for (int i = 0; i < months.length; i++) {
      double x = leftMargin + (i * gap) + 12;

      // Dark Blue Bar
      double hDark = (darkValues[i] / 20.0) * chartHeight;
      RRect bar1 = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, chartHeight - hDark, 10, hDark),
        const Radius.circular(3),
      );
      canvas.drawRRect(bar1, paintDark);

      // Light Blue Bar
      double hLight = (lightValues[i] / 20.0) * chartHeight;
      RRect bar2 = RRect.fromRectAndRadius(
        Rect.fromLTWH(x + 12, chartHeight - hLight, 10, hLight),
        const Radius.circular(3),
      );
      canvas.drawRRect(bar2, paintLight);

      // Month Labels (X-Axis)
      TextPainter tp = TextPainter(
        text: TextSpan(text: months[i], style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x + 2, chartHeight + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}