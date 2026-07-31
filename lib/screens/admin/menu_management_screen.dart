import 'package:flutter/material.dart';
import '../auth/role_selection_screen.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  // Selected Day Track garna
  String selectedDay = "Mon";

  // Sabai 7-din ko Menu Data Structure (Sunday & Saturday Food Added)
  final Map<String, Map<String, List<Map<String, String>>>> weeklyMenuData = {
    "Sun": {
      "Breakfast": [
        {
          "name": "Hot Puri Tarkari & Masala Tea",
          "desc": "Crispy fried puris served with spiced potato curry",
          "time": "8:00 AM",
          "img": "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Special Mutton Curry / Paneer Special",
          "desc": "Rich gravy meal served with aromatic basmati rice",
          "time": "1:00 PM",
          "img": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Butter Naan & Dal Makhani",
          "desc": "Slow-cooked black lentils with buttery naan bread",
          "time": "8:00 PM",
          "img": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500"
        }
      ]
    },
    "Mon": {
      "Breakfast": [
        {
          "name": "Avocado Poached Egg Toast",
          "desc": "High protein, vegetarian option",
          "time": "7:30 AM",
          "img": "https://images.unsplash.com/photo-1525351484163-7529414344d8?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Mediterranean Power Bowl",
          "desc": "Balanced nutrition, gluten-free",
          "time": "12:30 PM",
          "img": "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500"
        },
        {
          "name": "Wild Mushroom Risotto",
          "desc": "Chef's special, slow cooked",
          "time": "1:15 PM",
          "img": "https://images.unsplash.com/photo-1633964913295-ceb43826e7c9?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Pan-Seared Salmon",
          "desc": "Omega-3 rich, locally sourced",
          "time": "7:30 PM",
          "img": "https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=500"
        }
      ]
    },
    "Tue": {
      "Breakfast": [
        {
          "name": "Pancake Stack with Syrup",
          "desc": "Fluffy pancakes, sweet start",
          "time": "7:30 AM",
          "img": "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Paneer Butter Masala & Naan",
          "desc": "Rich gravy with fresh cottage cheese",
          "time": "12:45 PM",
          "img": "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Grilled Chicken Salad",
          "desc": "Low carb, lean protein dinner",
          "time": "8:00 PM",
          "img": "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500"
        }
      ]
    },
    "Wed": {
      "Breakfast": [
        {
          "name": "Oatmeal Bowl with Berries",
          "desc": "Heart-healthy fibre rich meal",
          "time": "7:15 AM",
        "img": "https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Chicken Biryani Deluxe",
          "desc": "Aromatic basmati rice & spices",
          "time": "1:00 PM",
          "img": "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Vegetable Stir-Fry Noodle",
          "desc": "Fresh veggies & asian sauce",
          "time": "7:45 PM",
          "img": "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500"
        }
      ]
    },
    "Thu": {
      "Breakfast": [
        {
          "name": "French Toast with Honey",
          "desc": "Golden fried bread with fruits",
          "time": "7:30 AM",
          "img": "https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Rajma Chawal Special",
          "desc": "North Indian comfort food staple",
          "time": "12:30 PM",
          "img": "https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Creamy Pasta Alfredo",
          "desc": "Rich garlic cream white sauce",
          "time": "8:00 PM",
          "img": "https://images.unsplash.com/photo-1612874742237-6526221588e3?w=500"
        }
      ]
    },
    "Fri": {
      "Breakfast": [
        {
          "name": "Aloo Paratha with Curd",
          "desc": "Stuffed potato flatbread",
          "time": "7:30 AM",
          "img": "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Fish Curry Meal",
          "desc": "Coastal spices cooked tenderly",
          "time": "1:00 PM",
          "img": "https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Veg Cheese Pizza Slice",
          "desc": "Weekend eve special treat",
          "time": "8:15 PM",
          "img": "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500"
        }
      ]
    },
    "Sat": {
      "Breakfast": [
        {
          "name": "Cornflakes & Fresh Fruit Platter",
          "desc": "Light, energetic start with cold milk",
          "time": "8:00 AM",
          "img": "https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=500"
        }
      ],
      "Lunch": [
        {
          "name": "Veg Fried Rice & Veg Manchurian",
          "desc": "Indo-Chinese style delicious lunch combo",
          "time": "1:15 PM",
          "img": "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500"
        }
      ],
      "Dinner": [
        {
          "name": "Grilled Cheese Sandwich & Hot Tomato Soup",
          "desc": "Soothing & light weekend comfort dinner",
          "time": "7:45 PM",
          "img": "https://images.unsplash.com/photo-1525351484163-7529414344d8?w=500"
        }
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    // Selected Day Ko Menu Fetch Garne
    final currentDayMenu = weeklyMenuData[selectedDay] ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Weekly Menu Management",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            const Text(
              "Manage the nutritional plan for students and faculty.",
              style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 16),

            // 7 Days Horizontal Interactive List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((day) {
                  return _buildDayTab(day, selectedDay == day);
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Breakfast Section
            if (currentDayMenu.containsKey("Breakfast")) ...[
              _buildSectionHeader("Breakfast", Icons.rice_bowl_outlined),
              ...currentDayMenu["Breakfast"]!.map((dish) => _buildDishCard(
                    dish["name"]!,
                    dish["desc"]!,
                    dish["time"]!,
                    dish["img"]!,
                  )),
              const SizedBox(height: 20),
            ],

            // Lunch Section
            if (currentDayMenu.containsKey("Lunch")) ...[
              _buildSectionHeader("Lunch", Icons.lunch_dining_outlined),
              ...currentDayMenu["Lunch"]!.map((dish) => _buildDishCard(
                    dish["name"]!,
                    dish["desc"]!,
                    dish["time"]!,
                    dish["img"]!,
                  )),
              const SizedBox(height: 20),
            ],

            // Dinner Section
            if (currentDayMenu.containsKey("Dinner")) ...[
              _buildSectionHeader("Dinner", Icons.dinner_dining_outlined),
              ...currentDayMenu["Dinner"]!.map((dish) => _buildDishCard(
                    dish["name"]!,
                    dish["desc"]!,
                    dish["time"]!,
                    dish["img"]!,
                  )),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  // 🖱️ Clickable Day Tab Widget
  Widget _buildDayTab(String day, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = day; // Day Change and UI update
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? null : Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF475569),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline, size: 16, color: Color(0xFF1D4ED8)),
          label: const Text(
            "Add Dish",
            style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _buildDishCard(String name, String desc, String time, String imgUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imgUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFEEF2FF),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF1D4ED8)),
                        label: const Text(
                          "Edit",
                          style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 20),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
        onPressed: () {
          _handleBackNavigation(context);
        },
      ),
      title: Row(
        children: const [
          Icon(Icons.grid_view_rounded, color: Color(0xFF1E3A8A)),
          SizedBox(width: 8),
          Text(
            "HostelMate",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.notifications_none_outlined, color: Color(0xFF0F172A)),
            Positioned(
              top: 14,
              right: 2,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xFFE2E8F0),
          child: Text(
            "AD",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
          ),
        ),
        const SizedBox(width: 16),
      ],
      iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
    );
  }

  // Safe Back Navigation Logic
  void _handleBackNavigation(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RoleSelectionScreen(),
        ),
      );
    }
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF047857)),
            onPressed: () => _handleBackNavigation(context),
          ),
          IconButton(
            icon: const Icon(Icons.account_tree_outlined, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.insert_chart_outlined, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Color(0xFF64748B)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}