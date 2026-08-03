import 'package:flutter/material.dart';
import 'api_service.dart';
import 'add_recipe_screen.dart';

class RecipesManagementScreen extends StatefulWidget {
  const RecipesManagementScreen({super.key});

  @override
  State<RecipesManagementScreen> createState() => _RecipesManagementScreenState();
}

class _RecipesManagementScreenState extends State<RecipesManagementScreen> {
  List<dynamic> _allRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipesData();
  }

  Future<void> _fetchRecipesData() async {
    setState(() => _isLoading = true);
    try {
      final recipes = await ApiService.fetchRecipes();
      setState(() {
        _allRecipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching recipes: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Recipe Management", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)), onPressed: _fetchRecipesData),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _allRecipes.length,
              itemBuilder: (context, index) {
                final recipe = _allRecipes[index];
                return _buildRecipeCard(recipe);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final res = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddRecipeScreen()));
          if (res == true) _fetchRecipesData();
        },
        backgroundColor: const Color(0xFF2563EB),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Add Recipe", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildRecipeCard(dynamic recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recipe['image_url'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(recipe['image_url'], height: 140, width: double.infinity, fit: BoxFit.cover),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe['tag'] ?? 'VEG', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                Text(recipe['title'] ?? 'No Title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Color(0xFF64748B)),
                    Text(" ${recipe['cooking_time'] ?? '20m'}", style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    const SizedBox(width: 12),
                    const Icon(Icons.local_fire_department_outlined, size: 12, color: Color(0xFF64748B)),
                    Text(" ${recipe['calories'] ?? '0 kcal'}", style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(" ${recipe['rating'] ?? '4.0'}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
