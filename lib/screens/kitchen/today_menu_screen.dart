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
      home: TodayMenuScreen(),
    );
  }
}

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  int selectedDayIndex = 3; // Wednesday Default
  
  final List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  // Weekly Menu Data (Sun to Sat)
  final Map<int, List<Map<String, dynamic>>> weeklyMenus = {
    0: [
      {
        "category": "Breakfast",
        "title": "Avocado & Egg Toast",
        "calories": "350 kcal",
        "desc": "Mashed avocado on sourdough with a poached egg and microgreens.",
        "time": "07:30 - 09:00 AM",
        "imgUrl": "https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600",
        "tags": ["HEALTHY FATS", "PROTEIN RICH"],
        "servings": 20,
        "isSoldOut": false,
      },
      {
        "category": "Lunch",
        "title": "Grilled Chicken Salad",
        "calories": "420 kcal",
        "desc": "Mixed greens, cherry tomatoes, cucumbers, and grilled chicken strips.",
        "time": "12:30 - 02:00 PM",
        "imgUrl": "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600",
        "tags": ["LOW CARB", "FRESH"],
        "servings": 15,
        "isSoldOut": false,
      },
    ],
    3: [ // Wednesday
      {
        "category": "BREAKFAST",
        "title": "Blueberry Yogurt Parfait",
        "calories": "320 kcal",
        "desc": "Fresh seasonal blueberries, low-fat Greek yogurt, honey-toasted oats, and a hint of mint. Contains dairy and gluten. Prepared in a facility that handles nuts.",
        "time": "08:00 AM",
        "imgUrl": "https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600",
        "tags": ["LACTOSE", "GLUTEN FREE", "VEGETARIAN"],
        "servings": 24,
        "isSoldOut": false,
      },
      {
        "category": "LUNCH",
        "title": "Herbed Chicken Grill",
        "calories": "540 kcal",
        "desc": "Tender grilled chicken breast seasoned with rosemary and thyme, served with roasted veggies.",
        "time": "01:00 PM",
        "imgUrl": "https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=600",
        "tags": ["HIGH PROTEIN", "NUT FREE"],
        "servings": 30,
        "isSoldOut": false,
      },
    ],
  };

  // 1. ADD NEW MEAL (First Image Screen)
  void _showAddMealBottomSheet() {
    final nameController = TextEditingController();
    final calController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = "Select Category";
    String selectedTime = "07:30 - 09:30";
    List<String> selectedDietary = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top Appbar like header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black87),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text("Add New Meal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0047AB)),
                          child: const Center(child: Text("KS", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Upload Photo Box
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FF),
                        borderRadius: BorderRadius.circular(16),
                        //border: Border.all(color: Colors.indigo.shade100, style: BorderStyle.dash),
                        border: Border.all(
  color: Colors.indigo.shade100,
  style: BorderStyle.solid,
),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.indigo.shade50, shape: BoxShape.circle),
                            child: const Icon(Icons.add_a_photo_outlined, color: Color(0xFF2563EB), size: 24),
                          ),
                          const SizedBox(height: 8),
                          const Text("Upload Photo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F2C59))),
                          const SizedBox(height: 2),
                          const Text("High-quality JPG or PNG (Max 5MB)", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Meal Name
                    const Text("MEAL NAME", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "e.g., Paneer Butter Masala",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        suffixIcon: const Icon(Icons.restaurant_menu, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category Dropdown
                    const Text("CATEGORY", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCategory == "Select Category" ? null : selectedCategory,
                          hint: const Text("Select Category", style: TextStyle(color: Colors.grey, fontSize: 14)),
                          isExpanded: true,
                          items: ["Breakfast", "Lunch", "Dinner", "Snacks"].map((String cat) {
                            return DropdownMenuItem(value: cat, child: Text(cat));
                          }).toList(),
                          onChanged: (val) {
                            setModalState(() {
                              selectedCategory = val!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Serving Time & Calories Row
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("SERVING TIME", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                              const SizedBox(height: 6),
                              TextField(
                                controller: TextEditingController(text: selectedTime),
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.access_time, color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("CALORIES (KCAL)", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                              const SizedBox(height: 6),
                              TextField(
                                controller: calController,
                                decoration: InputDecoration(
                                  hintText: "450",
                                  suffixIcon: const Icon(Icons.local_fire_department_outlined, color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Dietary Preferences Tags Chips
                    const Text("DIETARY PREFERENCES", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ["Veg", "Non-Veg", "Vegan", "Gluten-Free", "Nut-Free", "Spicy"].map((tag) {
                        bool isChosen = selectedDietary.contains(tag);
                        return ChoiceChip(
                          label: Text(tag, style: TextStyle(color: isChosen ? Colors.blue.shade900 : Colors.black87, fontSize: 12)),
                          selected: isChosen,
                          selectedColor: Colors.blue.shade50,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade300)),
                          onSelected: (bool selected) {
                            setModalState(() {
                              if (selected) {
                                selectedDietary.add(tag);
                              } else {
                                selectedDietary.remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Description
                    const Text("INGREDIENTS & DESCRIPTION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: descController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Briefly describe the meal and list key ingredients...",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Add Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            setState(() {
                              if (weeklyMenus[selectedDayIndex] == null) {
                                weeklyMenus[selectedDayIndex] = [];
                              }
                              weeklyMenus[selectedDayIndex]!.add({
                                "category": selectedCategory == "Select Category" ? "Breakfast" : selectedCategory.toUpperCase(),
                                "title": nameController.text,
                                "calories": "${calController.text.isEmpty ? '400' : calController.text} kcal",
                                "desc": descController.text.isEmpty ? "Freshly added item." : descController.text,
                                "time": "08:00 AM",
                                "imgUrl": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600",
                                "tags": selectedDietary.isEmpty ? ["FRESH"] : selectedDietary,
                                "servings": 20,
                                "isSoldOut": false,
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text("Add to Today's Menu", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8EEF9),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("SAVE AS DRAFT", style: TextStyle(color: Color(0xFF0F2C59), fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 2. UPDATE MEAL (Second Image Screen)
  void _showUpdateMealBottomSheet(Map<String, dynamic> item, int index) {
    final titleController = TextEditingController(text: item["title"]);
    final calController = TextEditingController(text: item["calories"].replaceAll(RegExp(r'[^0-9]'), ''));
    final descController = TextEditingController(text: item["desc"]);
    int servingsCount = item["servings"] ?? 24;
    bool isSoldOut = item["isSoldOut"] ?? false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.black87),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text("Update Meal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0047AB)),
                          child: const Center(child: Text("KS", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Meal Summary Card inside Update sheet
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.indigo.shade100),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(item["imgUrl"], width: 70, height: 70, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["title"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F2C59))),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.local_fire_department, color: Color(0xFF2563EB), size: 14),
                                    const SizedBox(width: 4),
                                    Text(item["calories"], style: const TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(6)),
                                  child: Text(item["category"], style: TextStyle(color: Colors.green.shade800, fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Availability Switch
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("AVAILABILITY", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                              SizedBox(height: 2),
                              Text("Mark as Sold Out", style: TextStyle(fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                          Switch(
                            value: isSoldOut,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setModalState(() {
                                isSoldOut = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Serving Management counter
                    const Text("SERVING MANAGEMENT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Servings Ready", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.blue),
                                onPressed: () {
                                  if (servingsCount > 0) {
                                    setModalState(() => servingsCount--);
                                  }
                                },
                              ),
                              Text("$servingsCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add_circle, color: Color(0xFF002255), size: 30),
                                onPressed: () {
                                  setModalState(() => servingsCount++);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description textfield
                    const Text("INGREDIENTS & DESCRIPTION", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59))),
                    const SizedBox(height: 6),
                    TextField(
                      controller: descController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Save Changes Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF002255),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          setState(() {
                            item["title"] = titleController.text;
                            item["calories"] = "${calController.text} kcal";
                            item["desc"] = descController.text;
                            item["servings"] = servingsCount;
                            item["isSoldOut"] = isSoldOut;
                          });
                          Navigator.pop(context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_outlined, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Delete Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFECEC),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          setState(() {
                            weeklyMenus[selectedDayIndex]?.removeAt(index);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Delete from Today", style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentMenuList = weeklyMenus[selectedDayIndex] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text("HostelMate Kitchen", style: TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Menu Management", style: TextStyle(color: Color(0xFF0F2C59), fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("ACTIVE DAY: ${weekDays[selectedDayIndex].toUpperCase()}", style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            
            // Day selection chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(weekDays.length, (index) {
                  bool isSelected = (selectedDayIndex == index);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedDayIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF75F9C4) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
                        ),
                        child: Text(weekDays[index], style: TextStyle(color: isSelected ? const Color(0xFF093824) : Colors.black87, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Menu Cards List
            currentMenuList.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text("No meals added yet.")))
                : ListView.separated(
                    itemCount: currentMenuList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = currentMenuList[index];
                      return Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(item["imgUrl"], height: 150, width: double.infinity, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item["title"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Text(item["calories"], style: const TextStyle(color: Color(0xFF006E2F), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(item["desc"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _showUpdateMealBottomSheet(item, index), // Opens Update Sheet
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002255)),
                                        child: const Text("Update", style: TextStyle(color: Colors.white, fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF006E2F),
        onPressed: _showAddMealBottomSheet, // Opens Add New Meal Sheet
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}