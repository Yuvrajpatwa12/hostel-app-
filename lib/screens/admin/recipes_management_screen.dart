import 'package:flutter/material.dart';
import 'add_recipe_screen.dart'; // Add Recipe screen location
import '../auth/role_selection_screen.dart'; // Back click safe screen

class RecipesManagementScreen extends StatelessWidget {
  const RecipesManagementScreen({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Manage Recipes",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "Centralized culinary database for hostel mess.",
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                // Add Recipe Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddRecipeScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: const Text(
                    "Add Recipe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: "Search by name, ingredient, or category...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 1. Grilled Mediterranean Chicken Bowl
            _buildRecipeCard(
              "Grilled Mediterranean Chicken Bowl",
              "NON-VEG",
              "25m",
              "420 kcal",
              "4.9",
              "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500",
            ),

            // 2. Paneer Makhani Deluxe
            _buildRecipeCard(
              "Paneer Makhani Deluxe",
              "VEG",
              "35m",
              "380 kcal",
              "4.5",
              "https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=500",
            ),

            // 3. Superfood Quinoa Bowl
            _buildRecipeCard(
              "Superfood Quinoa Bowl",
              "VEG",
              "15m",
              "290 kcal",
              "4.2",
              "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500",
            ),

            // 4. Artisanal Pasta Carbonara
            _buildRecipeCard(
              "Artisanal Pasta Carbonara",
              "NON-VEG",
              "20m",
              "510 kcal",
              "4.9",
              "https://images.unsplash.com/photo-1612874742237-6526221588e3?w=500",
            ),

            // 5. Rainbow Vegetable Stir-fry
            _buildRecipeCard(
              "Rainbow Vegetable Stir-fry",
              "VEG",
              "12m",
              "210 kcal",
              "4.0",
              "https://images.unsplash.com/photo-1540420773420-3366772f4999?w=500",
            ),

            const SizedBox(height: 16),
            // Total Active Recipes Blue Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Total Active Recipes",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "128",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Manage Categories ->",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Mess Performance Green Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mess Performance",
                        style: TextStyle(
                          color: Color(0xFF166534),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "94%",
                        style: TextStyle(
                          color: Color(0xFF166534),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "+2%",
                    style: TextStyle(
                      color: Color(0xFF166534),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildRecipeCard(
    String title,
    String tag,
    String time,
    String cal,
    String rating,
    String img,
  ) {
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
                  img,
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
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 12),
                      const SizedBox(width: 2),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                  tag,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Color(0xFF64748B)),
                    Text(" $time", style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    const SizedBox(width: 12),
                    const Icon(Icons.local_fire_department_outlined, size: 12, color: Color(0xFF64748B)),
                    Text(" $cal", style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(Icons.edit_outlined, color: Color(0xFF334155), size: 18),
                    SizedBox(width: 12),
                    Icon(Icons.delete_outline, color: Color(0xFFEF4444), size: 18),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // 🛡️ SAFE BACK NAVIGATION: Black Screen Blocked Completely
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
          Icon(Icons.grid_view_rounded, color: Color(0xFF2563EB)),
          SizedBox(width: 8),
          Text(
            "HostelMate",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: const [
        Icon(Icons.notifications_none_outlined, color: Color(0xFF0F172A)),
        SizedBox(width: 12),
        CircleAvatar(
          radius: 14,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32'),
        ),
        SizedBox(width: 16),
      ],
      iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
    );
  }

  // Safe Navigation Handler
  void _handleBackNavigation(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // Yadi screen stack ritta chha bhane Black screen aawunu badla Role Selection ma safely ferauchha
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