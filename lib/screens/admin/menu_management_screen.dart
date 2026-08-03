import 'package:flutter/material.dart';
import 'api_service.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  String selectedDay = "Mon";
  List<dynamic> _menuList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  Future<void> _fetchMenuData() async {
    setState(() => _isLoading = true);
    try {
      final menu = await ApiService.fetchMenu();
      setState(() {
        _menuList = menu;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching menu: $e");
      setState(() => _isLoading = false);
    }
  }

  Map<String, dynamic>? get _selectedDayMenu {
    try {
      return _menuList.firstWhere(
        (m) => m['day'].toString().toLowerCase().startsWith(selectedDay.toLowerCase()),
        orElse: () => null,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDayMenu = _selectedDayMenu;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Weekly Menu", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)), onPressed: _fetchMenuData),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Manage Nutritional Plan", style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((day) {
                        return _buildDayTab(day, selectedDay == day);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (currentDayMenu == null)
                    const Center(child: Text("No menu set for this day."))
                  else ...[
                    _buildMealSection("Breakfast", currentDayMenu['breakfast'] ?? "Not set", Icons.rice_bowl_outlined),
                    _buildMealSection("Lunch", currentDayMenu['lunch'] ?? "Not set", Icons.lunch_dining_outlined),
                    _buildMealSection("Dinner", currentDayMenu['dinner'] ?? "Not set", Icons.dinner_dining_outlined),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildDayTab(String day, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => selectedDay = day),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? null : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(day, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF475569), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildMealSection(String title, String details, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            ],
          ),
          const Divider(height: 24),
          Text(details, style: const TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.5)),
        ],
      ),
    );
  }
}
