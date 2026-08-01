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
      home: IngredientsScreen(),
    );
  }
}

class IngredientModel {
  final String name;
  final String categoryName;
  final String subtitle;
  final String qty;
  final String expiryOrStockText;
  final String thresholdText;
  final double progressValue;
  final String supplier;
  final bool isLowStock;
  final bool isOutOfStock;
  final String imageUrl;
  final String buttonText;
  final List<Color> buttonGradient;
  final IconData buttonIcon;

  IngredientModel({
    required this.name,
    required this.categoryName,
    required this.subtitle,
    required this.qty,
    required this.expiryOrStockText,
    required this.thresholdText,
    required this.progressValue,
    required this.supplier,
    required this.isLowStock,
    required this.isOutOfStock,
    required this.imageUrl,
    required this.buttonText,
    required this.buttonGradient,
    required this.buttonIcon,
  });
}

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({super.key});

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  String selectedCategory = "All Stock";

  final List<IngredientModel> allIngredients = [
    IngredientModel(
      name: "Fresh Tomatoes",
      categoryName: "Vegetables",
      subtitle: "Vegetable • Grade A",
      qty: "4.5 kg",
      expiryOrStockText: "Expiry: 12 Oct 2023",
      thresholdText: "Threshold: 10 kg",
      progressValue: 0.45,
      supplier: "GreenHarvest Ltd.",
      isLowStock: true,
      isOutOfStock: false,
      imageUrl: "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=600",
      buttonText: "Update Stock",
      buttonGradient: [const Color(0xFF0F2C59), const Color(0xFF1E3A8A)],
      buttonIcon: Icons.edit_outlined,
    ),
    IngredientModel(
      name: "Whole Milk",
      categoryName: "Dairy & Egg",
      subtitle: "Dairy • Pasteurized",
      qty: "82 L",
      expiryOrStockText: "Expiry: 05 Oct 2023",
      thresholdText: "Threshold: 20 L",
      progressValue: 0.8,
      supplier: "PureDairy Co.",
      isLowStock: false,
      isOutOfStock: false,
      imageUrl: "https://images.unsplash.com/photo-1563636619-e9143da7973b?w=600",
      buttonText: "Update Stock",
      buttonGradient: [const Color(0xFF0F2C59), const Color(0xFF1E3A8A)],
      buttonIcon: Icons.edit_outlined,
    ),
    IngredientModel(
      name: "Basmati Rice",
      categoryName: "Grains",
      subtitle: "Grains • Long Grain",
      qty: "0 kg",
      expiryOrStockText: "Stock Needed",
      thresholdText: "Threshold: 50 kg",
      progressValue: 0.0,
      supplier: "Global Grains Inc.",
      isLowStock: false,
      isOutOfStock: true,
      imageUrl: "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=600",
      buttonText: "Reorder Now",
      buttonGradient: [const Color(0xFF2563EB), const Color(0xFF1D4ED8)],
      buttonIcon: Icons.shopping_cart_outlined,
    ),
    IngredientModel(
      name: "Red Chili Powder",
      categoryName: "Spices",
      subtitle: "Spices • Extra Spicy",
      qty: "12.2 kg",
      expiryOrStockText: "Expiry: 20 Dec 2024",
      thresholdText: "Threshold: 5 kg",
      progressValue: 0.9,
      supplier: "Spiceroute Exports",
      isLowStock: false,
      isOutOfStock: false,
      imageUrl: "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=600",
      buttonText: "Update Stock",
      buttonGradient: [const Color(0xFF0F2C59), const Color(0xFF1E3A8A)],
      buttonIcon: Icons.edit_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<IngredientModel> filteredList = allIngredients.where((item) {
      if (selectedCategory == "All Stock") return true;
      return item.categoryName == selectedCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "HostelMate Kitchen",
              style: TextStyle(color: Color(0xFF0F2C59), fontSize: 18, fontWeight: FontWeight.bold),
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 24),
                ),
                const SizedBox(height: 8),
                const Text(
                  "TOTAL INGREDIENTS",
                  style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                const Text(
                  "248 Items",
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF7A45), Color(0xFFEA580C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "LOW STOCK",
                        style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "12 Categories",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.cancel_outlined, color: Colors.white, size: 20),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "OUT OF STOCK",
                        style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "4 Essentials",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)),
              ),
              Row(
                children: const [
                  Icon(Icons.tune, size: 16, color: Color(0xFF1D4ED8)),
                  SizedBox(width: 4),
                  Text(
                    "Filter",
                    style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _filterChip("All Stock"),
                const SizedBox(width: 8),
                _filterChip("Vegetables"),
                const SizedBox(width: 8),
                _filterChip("Dairy & Egg"),
                const SizedBox(width: 8),
                _filterChip("Grains"),
                const SizedBox(width: 8),
                _filterChip("Spices"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...filteredList.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.network(
                              item.imageUrl,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (item.isLowStock)
                            Positioned(
                              top: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [Color(0xFFFB923C), Color(0xFFEA580C)]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.error_outline, color: Colors.white, size: 12),
                                    SizedBox(width: 4),
                                    Text("Low Stock", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          if (item.isOutOfStock)
                            Positioned(
                              top: 12,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFB91C1C)]),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.cancel, color: Colors.white, size: 14),
                                      SizedBox(width: 6),
                                      Text("OUT OF STOCK", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)),
                                ),
                                Text(
                                  item.qty,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: item.isOutOfStock ? const Color(0xFFDC2626) : const Color(0xFF0F2C59),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.subtitle,
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.expiryOrStockText, style: const TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500)),
                                Text(item.thresholdText, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: item.progressValue,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  item.isOutOfStock ? Colors.red : const Color(0xFF2563EB),
                                ),
                                minHeight: 6,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                const Icon(Icons.local_shipping_outlined, size: 14, color: Colors.grey),
                                const SizedBox(width: 6),
                                Text(
                                  "Supplier: ${item.supplier}",
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: item.buttonGradient,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (item.isOutOfStock) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ReorderItemScreen()),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => UpdateStockScreen(itemName: item.name)),
                                    );
                                  }
                                },
                                icon: Icon(item.buttonIcon, color: Colors.white, size: 18),
                                label: Text(
                                  item.buttonText,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewItemScreen()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00A859),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: "Complaints"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)])
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 1. ADD NEW ITEM SCREEN
// -------------------------------------------------------------
class AddNewItemScreen extends StatelessWidget {
  const AddNewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2C59)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Add New Item", style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF0F2C59)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: const [
                Icon(Icons.camera_alt_outlined, color: Color(0xFF2563EB), size: 36),
                SizedBox(height: 8),
                Text("UPLOAD ITEM PHOTO", style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 4),
                Text("JPEG, PNG up to 5MB", style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionCard(
            title: "Basic Information",
            icon: Icons.inventory_2_outlined,
            children: [
              const Text("Item Name", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 6),
              TextField(decoration: InputDecoration(hintText: "e.g., Basmati Rice", filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
              const SizedBox(height: 12),
              const Text("Category", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: "Grains",
                items: ["Grains", "Vegetables", "Spices", "Dairy & Egg"].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                onChanged: (val) {},
                decoration: InputDecoration(filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _sectionCard(
            title: "Stock & Price",
            icon: Icons.bar_chart,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Initial Qty", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54)),
                        const SizedBox(height: 6),
                        TextField(decoration: InputDecoration(hintText: "0", filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Unit", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: "kg",
                          items: ["kg", "L", "pcs", "packets"].map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
                          onChanged: (val) {},
                          decoration: InputDecoration(filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text("Price per Unit (₹)", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 6),
              TextField(decoration: InputDecoration(hintText: "₹ 0.00", filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("ADD TO INVENTORY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("CANCEL", style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static Widget _sectionCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF2563EB)),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F2C59))),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 2. UPDATE STOCK SCREEN
// -------------------------------------------------------------
class UpdateStockScreen extends StatelessWidget {
  final String itemName;
  const UpdateStockScreen({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2C59)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Update Stock", style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold, fontSize: 18)),
            Text(itemName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100")),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network("https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=200", width: 70, height: 70, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(itemName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F2C59))),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(10)),
                          child: const Text("Current", style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text("4.5 kg", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Enter New Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F2C59))),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: "e.g., 10.0",
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("SAVE CHANGES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. REORDER ITEM SCREEN
// -------------------------------------------------------------
class ReorderItemScreen extends StatelessWidget {
  const ReorderItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F2C59)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Reorder Item", style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_checkout, size: 64, color: Color(0xFF2563EB)),
            const SizedBox(height: 16),
            const Text("Place Supplier Order", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
            const SizedBox(height: 8),
            const Text("Submit a restock request directly to the assigned supplier.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("CONFIRM ORDER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
class InventoryScreen {
}
