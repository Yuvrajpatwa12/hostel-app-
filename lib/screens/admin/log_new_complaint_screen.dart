import 'package:flutter/material.dart';

class LogNewComplaintScreen extends StatefulWidget {
  const LogNewComplaintScreen({super.key});

  @override
  State<LogNewComplaintScreen> createState() => _LogNewComplaintScreenState();
}

class _LogNewComplaintScreenState extends State<LogNewComplaintScreen> {
  String _selectedCategory = 'Electricity';
  String _selectedPriority = 'Medium';
  String? _selectedStaff;

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Urgent'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Log New Complaint",
          style: TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFF1E3A8A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student & Room Info
            _buildSectionHeader("STUDENT & ROOM INFO"),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search Student Name or ID",
                      hintStyle: const TextStyle(
                          color: Color(0xFF64748B), fontSize: 14),
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF64748B)),
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              const Color(0xFF2563EB).withValues(alpha: 0.15),
                          child: const Icon(Icons.person_outline,
                              color: Color(0xFF2563EB), size: 18),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select student to auto-fill room",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFF1E293B)),
                            ),
                            Text(
                              'E.g. "Alex Johnson (RM 402)"',
                              style: TextStyle(
                                  color: Color(0xFF64748B), fontSize: 11),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Complaint Category
            _buildSectionHeader("COMPLAINT CATEGORY"),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                          "Electricity", Icons.bolt, _selectedCategory == 'Electricity'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildCategoryCard(
                          "Water", Icons.water_drop_outlined, _selectedCategory == 'Water'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildCategoryCard(
                          "Furniture", Icons.chair_outlined, _selectedCategory == 'Furniture'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildCategoryCard(
                          "Cleaning", Icons.cleaning_services_outlined, _selectedCategory == 'Cleaning'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _buildCategoryCard(
                          "Other Issues", Icons.more_horiz, _selectedCategory == 'Other Issues'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Priority Level
            _buildSectionHeader("PRIORITY LEVEL"),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: _priorities.sublist(0, 3).map((priority) {
                      bool isSelected = _selectedPriority == priority;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedPriority = priority),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 4,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Text(
                              priority,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFF475569),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => setState(() => _selectedPriority = 'Urgent'),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedPriority == 'Urgent'
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Urgent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedPriority == 'Urgent'
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFF475569),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Problem Details
            _buildSectionHeader("PROBLEM DETAILS"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText:
                          "Describe the issue in detail (e.g., 'The ceiling fan in room 402 is making a loud clicking noise and stops occasionally')...",
                      hintStyle:
                          TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.4),
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: const Text(
                      "Min. 20 characters",
                      style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Evidence
            _buildSectionHeader("EVIDENCE"),
            Row(
              children: [
                Expanded(
                  child: _buildDashedBox(
                    icon: Icons.upload_file,
                    title: "Upload Photos",
                    subtitle: "Max 5 files (JPG, PNG)",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDashedBox(
                    icon: Icons.camera_alt_outlined,
                    title: "Take Photo",
                    subtitle: "Using device camera",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Assign To Staff
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader("ASSIGN TO STAFF"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("Optional",
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedStaff,
              hint: const Text("Search or select staff member",
                  style: TextStyle(fontSize: 13, color: Color(0xFF475569))),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.engineering_outlined,
                    color: Color(0xFF10B981)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              ),
              items: ['Sam Johnson (Electrician)', 'Alex Green (Plumber)']
                  .map((staff) => DropdownMenuItem(
                        value: staff,
                        child: Text(staff, style: const TextStyle(fontSize: 13)),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => _selectedStaff = val),
            ),
            const SizedBox(height: 24),

            // Register Complaint Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                icon: const Icon(Icons.check_box_outlined, color: Colors.white),
                label: const Text(
                  "Register Complaint",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "By registering, a notification will be sent to the student and assigned staff.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF1E293B),
                size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF1E293B),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashedBox(
      {required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF93C5FD),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF475569), size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}