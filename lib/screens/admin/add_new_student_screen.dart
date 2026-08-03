import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewStudentScreen extends StatefulWidget {
  const AddNewStudentScreen({super.key});

  @override
  State<AddNewStudentScreen> createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {
  // Hostinger API Base URL with CORS Proxy for Web testing
  static const String baseUrl = "https://corsproxy.io/?https://startupsgo.tech/api";

  String selectedGender = 'Male';
  String selectedBlock = 'Block A';
  String? selectedCourse;
  String selectedSemester = 'Year 1 / Sem 1';
  String? selectedRoom;
  bool _isSaving = false;

  // Controllers for fetching data from text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _guardianPhoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _admissionDateController = TextEditingController();

  final List<String> blocksList = [
    'Block A',
    'Block B',
    'Block C',
    'Block D',
    'Block E',
  ];

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  // Hostinger Database par Student Register karne ka function
  Future<void> _registerStudent() async {
    if (_nameController.text.isEmpty || _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in Name and Student ID")),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_student.php'),
        body: {
          'name': _nameController.text,
          'student_id': _idController.text,
          'dob': _dobController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'gender': selectedGender,
          'course': selectedCourse ?? 'N/A',
          'semester': selectedSemester,
          'college': _collegeController.text,
          'block': selectedBlock,
          'room_no': selectedRoom ?? 'Unassigned',
          'admission_date': _admissionDateController.text,
          'guardian_name': _guardianNameController.text,
          'guardian_phone': _guardianPhoneController.text,
          'status': 'Active',
        },
      );

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Student Registered Successfully!")),
        );
        Navigator.pop(context, true); // List refresh karne ke liye true bhej rahe hain
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Failed to register student")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add New Student (Hostinger)",
          style: TextStyle(
            color: Color(0xFF1D2939),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Photo Upload UI
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEF2FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          size: 56,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFF2563EB),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "UPLOAD PHOTO",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                      color: Color(0xFF1D4ED8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal Details Section
            _buildSectionCard(
              title: "Personal Details",
              icon: Icons.badge_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Full Name"),
                  _buildTextField(controller: _nameController, hint: "e.g. Johnathan Doe", prefixIcon: Icons.person_outline),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Student ID"),
                            _buildTextField(controller: _idController, hint: "ID-2024-001"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Date of Birth"),
                            _buildDateField(_dobController, "YYYY-MM-DD"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildLabel("Email Address"),
                  _buildTextField(
                    controller: _emailController,
                    hint: "student@university.edu",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),

                  _buildLabel("Phone Number"),
                  _buildTextField(
                    controller: _phoneController,
                    hint: "9800000000",
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 14),

                  _buildLabel("Gender"),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: ['Male', 'Female', 'Other'].map((gender) {
                        bool isSelected = selectedGender == gender;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedGender = gender),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF86EFAC) : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                gender,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected ? const Color(0xFF065F46) : const Color(0xFF475569),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Academic Info Section
            _buildSectionCard(
              title: "Academic Info",
              icon: Icons.school_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Course"),
                            DropdownButtonFormField<String>(
                              value: selectedCourse,
                              hint: const Text("Select Course", style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
                              decoration: _inputDecoration(),
                              items: ['B.Sc CS', 'B.A Economics', 'M.B.A Finance', 'B.Tech IT']
                                  .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13))))
                                  .toList(),
                              onChanged: (val) => setState(() => selectedCourse = val),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Semester"),
                            DropdownButtonFormField<String>(
                              value: selectedSemester,
                              decoration: _inputDecoration(),
                              items: ['Year 1 / Sem 1', 'Year 1 / Sem 2', 'Year 2 / Sem 1', 'Year 2 / Sem 2']
                                  .map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(fontSize: 12))))
                                  .toList(),
                              onChanged: (val) => setState(() => selectedSemester = val!),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _buildLabel("University/College"),
                  _buildTextField(controller: _collegeController, hint: "e.g. State University of Technology"),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Hostel Allocation Section
            _buildSectionCard(
              title: "Hostel Allocation",
              icon: Icons.domain_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Select Block"),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blocksList.map((block) {
                          bool isSelected = selectedBlock == block;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: GestureDetector(
                              onTap: () => setState(() => selectedBlock = block),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF86EFAC) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  block,
                                  style: TextStyle(
                                    color: isSelected ? const Color(0xFF065F46) : const Color(0xFF475569),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Room Number"),
                            DropdownButtonFormField<String>(
                              value: selectedRoom,
                              hint: const Text("Select Room", style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
                              decoration: _inputDecoration(),
                              items: ['Room 101', 'Room 102', 'Room 205', 'Room 304', 'Room 402']
                                  .map((r) => DropdownMenuItem(value: r, child: Text(r, style: const TextStyle(fontSize: 13))))
                                  .toList(),
                              onChanged: (val) => setState(() => selectedRoom = val),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Admission Date"),
                            _buildDateField(_admissionDateController, "YYYY-MM-DD"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Emergency Contact Section
            _buildSectionCard(
              title: "Emergency Contact",
              icon: Icons.contact_phone_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Guardian Name"),
                  _buildTextField(controller: _guardianNameController, hint: "Legal Guardian Name"),
                  const SizedBox(height: 14),

                  _buildLabel("Guardian Phone"),
                  _buildTextField(
                    controller: _guardianPhoneController,
                    hint: "Guardian Phone Number",
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052CC),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isSaving ? null : _registerStudent,
                icon: _isSaving
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.person_add_alt_1_outlined, color: Colors.white, size: 18),
                label: Text(
                  _isSaving ? "Registering..." : "Register Student",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      width: double.infinity,
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
            children: [
              Icon(icon, color: const Color(0xFF166534), size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
      ),
    );
  }

  Widget _buildTextField({required String hint, TextEditingController? controller, IconData? prefixIcon, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(hint: hint, prefixIcon: prefixIcon),
    );
  }

  Widget _buildDateField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(controller),
      decoration: _inputDecoration(
        hint: hint,
        suffixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF1E293B), size: 18),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, IconData? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFF64748B), size: 18) : null,
      suffixIcon: suffixIcon,
      fillColor: const Color(0xFFF1F5F9),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
    );
  }
}