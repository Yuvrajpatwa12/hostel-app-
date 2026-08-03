import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  final TextEditingController _nameEngController = TextEditingController();
  final TextEditingController _nameNepController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _citizenshipController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _classTimeController = TextEditingController();
  final TextEditingController _levelOfStudyController = TextEditingController();
  final TextEditingController _stayDurationController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherContactController = TextEditingController();
  final TextEditingController _fatherOccController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherContactController = TextEditingController();
  final TextEditingController _motherOccController = TextEditingController();
  final TextEditingController _localGuardianController = TextEditingController();
  final TextEditingController _localGuardianAddressController = TextEditingController();
  final TextEditingController _localGuardianContactController = TextEditingController();

  String _selectedFood = 'Vegetarian';
  bool _agreedToRules = false;

  final List<String> _nehaRules = [
    "1. विद्यार्थीले अनिवार्य रूपमा अभिभावकको उपस्थितिमा भर्ना फारम भर्नुपर्नेछ ।",
    "2. कलेज/इन्ституटको समयबाहेक बाहेकको सम्पूर्ण समयको व्यवस्थापक/प्रशासनले तोके अनुसार हुनेछ ।",
    "3. विद्यार्थीहरूले होस्टेलदेखि बाहिर जानु परेमा होस्टेल व्यवस्थापन/प्रशासनको अनुमति लिई Logbook भर्नुपर्नेछ ।",
    "4. विद्यार्थीहरू जाडो महिनामा बेलुका ६:३० बजे र गर्मी महिनामा बेलुकी ७:३० बजेसम्म भित्र होस्टेल प्रवेश गरिसक्नु पर्नेछ ।",
    "5. फारममा उल्लेखित नरहेका स्थानीय अभिभावक तथा बुबा/आमालाई मात्र विद्यार्थी भेट्न अनुमति दिइनेछ ।",
  ];

  void _fillDemoData() {
    setState(() {
      _nameEngController.text = "YUVRAJ PATWA";
      _nameNepController.text = "युवराज पटवा";
      _dobController.text = "2064/05/12";
      _contactController.text = "9812345678";
      _emailController.text = "yuvraj_${DateTime.now().millisecondsSinceEpoch}@gmail.com";
      _passwordController.text = "123456";
      _confirmPasswordController.text = "123456";
      _districtController.text = "Parsa";
      _municipalityController.text = "Birgunj";
      _wardController.text = "10";
      _streetController.text = "Main Road";
      _citizenshipController.text = "123-456";
      _instituteController.text = "Trinity";
      _classTimeController.text = "Morning";
      _levelOfStudyController.text = "+2";
      _stayDurationController.text = "1 Year";
      _diseaseController.text = "None";
      _fatherNameController.text = "Rajendra Patwa";
      _fatherContactController.text = "9823456789";
      _fatherOccController.text = "Business";
      _motherNameController.text = "Devi Patwa";
      _motherContactController.text = "9834567890";
      _motherOccController.text = "Housewife";
      _localGuardianController.text = "Ramesh Kumar";
      _localGuardianAddressController.text = "KTM";
      _localGuardianContactController.text = "9845678901";
      _agreedToRules = true;
    });
  }

  Future<void> _submitToHostinger() async {
    if (!_agreedToRules) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please agree to rules.')));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords mismatch!')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://startupsgo.tech/signup.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text,
          'student_name_eng': _nameEngController.text.trim(),
          'student_name_nep': _nameNepController.text.trim(),
          'dob': _dobController.text.trim(),
          'contact': _contactController.text.trim(),
          'district': _districtController.text.trim(),
          'municipality': _municipalityController.text.trim(),
          'ward': _wardController.text.trim(),
          'street': _streetController.text.trim(),
          'citizenship': _citizenshipController.text.trim(),
          'institute': _instituteController.text.trim(),
          'class_time': _classTimeController.text.trim(),
          'level_of_study': _levelOfStudyController.text.trim(),
          'stay_duration': _stayDurationController.text.trim(),
          'food_preference': _selectedFood,
          'disease': _diseaseController.text.trim(),
          'father_name': _fatherNameController.text.trim(),
          'father_contact': _fatherContactController.text.trim(),
          'father_occ': _fatherOccController.text.trim(),
          'mother_name': _motherNameController.text.trim(),
          'mother_contact': _motherContactController.text.trim(),
          'mother_occ': _motherOccController.text.trim(),
          'lg_name': _localGuardianController.text.trim(),
          'lg_address': _localGuardianAddressController.text.trim(),
          'lg_contact': _localGuardianContactController.text.trim(),
        }),
      );

      final resData = jsonDecode(response.body);
      if (response.statusCode == 200 && resData['status'] == 'success') {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup Success! 🎉'), backgroundColor: Colors.green));
          Navigator.pop(context);
        }
      } else {
        throw resData['message'] ?? 'Signup failed';
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        title: const Text("Admission Form", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006E2F))),
        actions: [IconButton(onPressed: _fillDemoData, icon: const Icon(Icons.auto_awesome, color: Colors.amber))],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildStep(0, "Profile"), _buildStep(1, "Guardian"), _buildStep(2, "Rules")]),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20)]),
                    child: _buildCurrentContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int idx, String title) {
    bool active = _currentStep == idx;
    return Column(children: [CircleAvatar(radius: 16, backgroundColor: active || _currentStep > idx ? const Color(0xFF22C55E) : Colors.grey[300], child: Text("${idx + 1}", style: const TextStyle(color: Colors.white, fontSize: 12))), Text(title, style: TextStyle(fontSize: 10, color: active ? const Color(0xFF006E2F) : Colors.grey))]);
  }

  Widget _buildCurrentContent() {
    if (_currentStep == 0) return _buildProfile();
    if (_currentStep == 1) return _buildGuardian();
    return _buildRules();
  }

  Widget _buildProfile() {
    return Column(children: [_field("Name (Eng)", _nameEngController, Icons.person), const SizedBox(height: 12), _field("Name (Nep)", _nameNepController, Icons.translate), const SizedBox(height: 12), Row(children: [Expanded(child: _field("DOB", _dobController, Icons.cake)), const SizedBox(width: 12), Expanded(child: _field("Contact", _contactController, Icons.phone))]), const SizedBox(height: 12), _field("Email", _emailController, Icons.email), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Password", _passwordController, Icons.lock, obscure: true)), const SizedBox(width: 12), Expanded(child: _field("Confirm", _confirmPasswordController, Icons.lock_reset, obscure: true))]), const SizedBox(height: 12), Row(children: [Expanded(child: _field("District", _districtController, Icons.map)), const SizedBox(width: 12), Expanded(child: _field("Municipality", _municipalityController, Icons.location_city))]), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Ward", _wardController, Icons.pin_drop)), const SizedBox(width: 12), Expanded(child: _field("Street", _streetController, Icons.alt_route))]), const SizedBox(height: 12), _field("Citizenship No", _citizenshipController, Icons.badge), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Institute", _instituteController, Icons.school)), const SizedBox(width: 12), Expanded(child: _field("Class Time", _classTimeController, Icons.timer))]), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Level", _levelOfStudyController, Icons.book)), const SizedBox(width: 12), Expanded(child: _field("Stay", _stayDurationController, Icons.hourglass_top))]), const SizedBox(height: 16), const Text("Food Preference", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Row(children: ['Vegetarian', 'Non-Vegetarian'].map((f) => Expanded(child: InkWell(onTap: () => setState(() => _selectedFood = f), child: Row(children: [Radio<String>(value: f, groupValue: _selectedFood, activeColor: const Color(0xFF006E2F), onChanged: (v) => setState(() => _selectedFood = v!)), Text(f, style: const TextStyle(fontSize: 9))])))).toList()), _field("Disease", _diseaseController, Icons.medical_services), const SizedBox(height: 24), ElevatedButton(onPressed: () => setState(() => _currentStep = 1), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E), minimumSize: const Size(double.infinity, 50)), child: const Text("Next", style: TextStyle(color: Colors.white)))]);
  }

  Widget _buildGuardian() {
    return Column(children: [_field("Father's Name", _fatherNameController, Icons.person), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Father Contact", _fatherContactController, Icons.phone)), const SizedBox(width: 12), Expanded(child: _field("Occupation", _fatherOccController, Icons.work))]), const SizedBox(height: 12), _field("Mother's Name", _motherNameController, Icons.person), const SizedBox(height: 12), Row(children: [Expanded(child: _field("Mother Contact", _motherContactController, Icons.phone)), const SizedBox(width: 12), Expanded(child: _field("Occupation", _motherOccController, Icons.work))]), const SizedBox(height: 20), const Text("Local Guardian", style: TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), _field("LG Name", _localGuardianController, Icons.person_outline), const SizedBox(height: 12), _field("LG Address", _localGuardianAddressController, Icons.location_on), const SizedBox(height: 12), _field("LG Contact", _localGuardianContactController, Icons.phone), const SizedBox(height: 24), Row(children: [Expanded(child: OutlinedButton(onPressed: () => setState(() => _currentStep = 0), child: const Text("Back"))), const SizedBox(width: 12), Expanded(flex: 2, child: ElevatedButton(onPressed: () => setState(() => _currentStep = 2), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)), child: const Text("Next", style: TextStyle(color: Colors.white))))])]);
  }

  Widget _buildRules() {
    return Column(children: [const Text("Rules", style: TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), Container(height: 200, color: Colors.grey[100], child: ListView.builder(itemCount: _nehaRules.length, itemBuilder: (c, i) => Padding(padding: const EdgeInsets.all(8), child: Text(_nehaRules[i], style: const TextStyle(fontSize: 11))))), CheckboxListTile(title: const Text("Agree", style: TextStyle(fontSize: 12)), value: _agreedToRules, onChanged: (v) => setState(() => _agreedToRules = v!)), const SizedBox(height: 24), Row(children: [Expanded(child: OutlinedButton(onPressed: () => setState(() => _currentStep = 1), child: const Text("Back"))), const SizedBox(width: 12), Expanded(flex: 2, child: ElevatedButton(onPressed: _isLoading ? null : _submitToHostinger, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)), child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Submit", style: TextStyle(color: Colors.white))))])]);
  }

  Widget _field(String l, TextEditingController c, IconData i, {bool obscure = false}) {
    return TextField(controller: c, obscureText: obscure, decoration: InputDecoration(labelText: l, prefixIcon: Icon(i, color: const Color(0xFF006E2F), size: 18), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)));
  }
}
