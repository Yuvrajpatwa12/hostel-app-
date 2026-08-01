import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReviewsScreen(),
    );
  }
}

class ReviewModel {
  final String avatarUrl;
  final String name;
  final String info;
  final int rating;
  final String comment;
  final String category; // 'All Reviews', 'Newest', 'Breakfast', 'Lunch', 'Dinner'
  final String mealTag; // 'LUNCH', 'BREAKFAST', 'DINNER'
  final String? imageUrl;
  final String replyText;
  final bool isAcknowledged;
  final bool isNewest;

  ReviewModel({
    required this.avatarUrl,
    required this.name,
    required this.info,
    required this.rating,
    required this.comment,
    required this.category,
    required this.mealTag,
    this.imageUrl,
    this.replyText = "Reply",
    this.isAcknowledged = false,
    this.isNewest = false,
  });
}

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String selectedFilter = "All Reviews";
  int bottomNavIndex = 2;

  final List<ReviewModel> allReviews = [
    ReviewModel(
      avatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100",
      name: "Arjun Mehta",
      info: "Room 304 • Today, 2:15 PM",
      rating: 5,
      comment: "\"The Paneer Makhani today was exceptional! Perfectly spiced and the quantity was just right. The rice was fluffy too. Keep it up kitchen team!\"",
      category: "Lunch",
      mealTag: "LUNCH",
      imageUrl: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600",
      isNewest: true,
    ),
    ReviewModel(
      avatarUrl: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=500",
      name: "Sarah Jenkins",
      info: "Room 112 • Today, 8:45 AM",
      rating: 4,
      comment: "\"Oats and healthy berry breakfast bowl were a bit too salty this morning. Everything else was fine, but please watch the salt content.\"",
      category: "Breakfast",
      mealTag: "BREAKFAST",
      imageUrl: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=500",
      isAcknowledged: true,
      isNewest: true,
    ),
    ReviewModel(
      avatarUrl: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=100",
      name: "Kevin Zhang",
      info: "Room 502 • Oct 24, 9:20 PM",
      rating: 5,
      comment: "\"The grilled fish was cooked to perfection. Would have liked a bit more salad on the side, but flavor-wise it's a 10/10.\"",
      category: "Dinner",
      mealTag: "DINNER",
      imageUrl: "https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600",
      isNewest: false,
    ),
  ];

  // Export Report Bottom Sheet Show garne function
  void _showExportReportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            String selectedDateRange = "Last 7 Days";
            String selectedReportType = "Summary PDF (Visual Dashboard)";

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Title & Close Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Export Review Report",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F2C59),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Date Range Section
                  const Text(
                    "DATE RANGE",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4ED8),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _dateRangeChip("Last 7 Days", selectedDateRange, (val) {
                        setModalState(() => selectedDateRange = val);
                      }),
                      const SizedBox(width: 8),
                      _dateRangeChip("Last 30 Days", selectedDateRange, (val) {
                        setModalState(() => selectedDateRange = val);
                      }),
                      const SizedBox(width: 8),
                      _dateRangeChip("Custom", selectedDateRange, (val) {
                        setModalState(() => selectedDateRange = val);
                      }),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Start and End Date Fields
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Start Date", style: TextStyle(color: Colors.grey, fontSize: 10)),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text("Oct 12, 2023", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("End Date", style: TextStyle(color: Colors.grey, fontSize: 10)),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text("Oct 19, 2023", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Report Type Section
                  const Text(
                    "REPORT TYPE",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D4ED8),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Report Type Options
                  _reportTypeCard(
                    title: "Summary PDF (Visual Dashboard)",
                    subtitle: "Includes charts, performance trends, and highlights.",
                    icon: Icons.picture_as_pdf_outlined,
                    isSelected: selectedReportType == "Summary PDF (Visual Dashboard)",
                    onTap: () {
                      setModalState(() => selectedReportType = "Summary PDF (Visual Dashboard)");
                    },
                  ),
                  const SizedBox(height: 10),
                  _reportTypeCard(
                    title: "Detailed Excel (Raw Data)",
                    subtitle: "CSV format with every student review and score.",
                    icon: Icons.table_chart_outlined,
                    isSelected: selectedReportType == "Detailed Excel (Raw Data)",
                    onTap: () {
                      setModalState(() => selectedReportType = "Detailed Excel (Raw Data)");
                    },
                  ),
                  const SizedBox(height: 10),
                  _reportTypeCard(
                    title: "Quality Analysis (Comments only)",
                    subtitle: "Focused qualitative feedback for staff meetings.",
                    icon: Icons.comment_outlined,
                    isSelected: selectedReportType == "Quality Analysis (Comments only)",
                    onTap: () {
                      setModalState(() => selectedReportType = "Quality Analysis (Comments only)");
                    },
                  ),
                  const SizedBox(height: 20),

                  // Generate & Export Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Report Generated Successfully!")),
                        );
                      },
                      icon: const Icon(Icons.upload, color: Colors.white),
                      label: const Text(
                        "Generate & Export Report",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0038A8),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Estimated size: 2.4 MB • Format: PDF",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _dateRangeChip(String label, String currentGroup, Function(String) onTap) {
    bool isSelected = currentGroup == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFEEF2F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _reportTypeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              activeColor: const Color(0xFF2563EB),
              onChanged: (_) => onTap(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
            Icon(icon, color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ReviewModel> filteredReviews = allReviews;
    
    if (selectedFilter == "Newest") {
      filteredReviews = allReviews.where((r) => r.isNewest).toList();
    } else if (selectedFilter != "All Reviews") {
      filteredReviews = allReviews.where((r) => r.category == selectedFilter).toList();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "HostelMate Kitchen",
                style: TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Color(0xFF0F2C59)),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall Satisfaction Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Text("4.6", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8))),
                          Row(
                            children: List.generate(5, (_) => const Icon(Icons.star, color: Color(0xFF16A34A), size: 14)),
                          ),
                          const SizedBox(height: 4),
                          const Text("128 Reviews", style: TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _StatItem(title: "TASTE", score: "4.8"),
                              _StatItem(title: "HYGIENE", score: "4.9"),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              _StatItem(title: "QUANTITY", score: "4.2"),
                              _StatItem(title: "QUALITY", score: "4.5"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showExportReportSheet(context), // <--- Yeta call gareko xu modal open huna ko lagi
                    icon: const Icon(Icons.download, size: 18, color: Colors.white),
                    label: const Text("EXPORT REPORT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Rating Trends Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.trending_up, size: 16, color: Colors.black87),
                    SizedBox(width: 6),
                    Text("RATING TRENDS (LAST 7 DAYS)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _BarChartItem(day: "Mon", height: 80),
                    _BarChartItem(day: "Tue", height: 85),
                    _BarChartItem(day: "Wed", height: 60),
                    _BarChartItem(day: "Thu", height: 85),
                    _BarChartItem(day: "Fri", height: 95),
                    _BarChartItem(day: "Sat", height: 75),
                    _BarChartItem(day: "Sun", height: 90),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Most Loved / Least Loved Section
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite_border, color: Color(0xFF16A34A), size: 16),
                    SizedBox(width: 6),
                    Text("MOST LOVED", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network("https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=100", width: 40, height: 40, fit: BoxFit.cover)),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Butter Chicken Special", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF166534))),
                          Text("4.9 ★ (42 votes)", style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Icon(Icons.thumb_down_outlined, color: Colors.red, size: 16),
                    SizedBox(width: 6),
                    Text("LEAST LOVED", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network("https://images.unsplash.com/photo-1540420773420-3366772f4999?w=100", width: 40, height: 40, fit: BoxFit.cover)),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Boiled Veggie Mix", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF991B1B))),
                          Text("2.1 ★ (12 votes)", style: TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Filter Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip("All Reviews"),
                const SizedBox(width: 8),
                _filterChip("Newest"),
                const SizedBox(width: 8),
                _filterChip("Breakfast"),
                const SizedBox(width: 8),
                _filterChip("Lunch"),
                const SizedBox(width: 8),
                _filterChip("Dinner"),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Review Cards List
          if (filteredReviews.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(child: Text("No reviews found for this filter.", style: TextStyle(color: Colors.grey, fontSize: 13))),
            )
          else
            ...filteredReviews.map((review) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _reviewCard(review),
                )),

          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Text("LOAD OLDER REVIEWS", style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, fontSize: 12)),
              label: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF2563EB), size: 18),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF16A34A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) => setState(() => bottomNavIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.warning_amber_rounded), label: "Complaints"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F2C59) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _reviewCard(ReviewModel review) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(review.avatarUrl),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(review.info, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(review.mealTag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (_) => const Icon(Icons.star, color: Color(0xFF16A34A), size: 14)),
          ),
          if (review.imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(review.imageUrl!, height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
          ],
          const SizedBox(height: 10),
          Text(review.comment, style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.black87, fontStyle: FontStyle.italic)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.reply, size: 14, color: Color(0xFF1E3A8A)),
                  label: const Text("REPLY", style: TextStyle(color: Color(0xFF1E3A8A), fontSize: 11, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFEEF2FF),
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    review.isAcknowledged ? Icons.check_circle_outline : Icons.check,
                    size: 14,
                    color: review.isAcknowledged ? const Color(0xFF166534) : const Color(0xFF1E293B),
                  ),
                  label: Text(
                    review.isAcknowledged ? "ACKNOWLEDGED" : "MARK AS REVIEWED",
                    style: TextStyle(
                      color: review.isAcknowledged ? const Color(0xFF166534) : const Color(0xFF1E293B),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: review.isAcknowledged ? const Color(0xFFDCFCE7) : Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String score;

  const _StatItem({required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(score, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8))),
      ],
    );
  }
}

class _BarChartItem extends StatelessWidget {
  final String day;
  final double height;

  const _BarChartItem({required this.day, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF047857),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
      ],
    );
  }
}