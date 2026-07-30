import 'package:flutter/material.dart';

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  int _currentStep = 0; // 0: Student Profile, 1: Guardian & Extra Info, 2: Rules & Regulations

  // Controllers - Student Profile
  final TextEditingController _nameEngController = TextEditingController();
  final TextEditingController _nameNepController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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

  // Controllers - Guardian Profile
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherContactController = TextEditingController();
  final TextEditingController _fatherOccController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherContactController = TextEditingController();
  final TextEditingController _motherOccController = TextEditingController();
  final TextEditingController _localGuardianController = TextEditingController();
  final TextEditingController _localGuardianAddressController = TextEditingController();
  final TextEditingController _localGuardianContactController = TextEditingController();

  // Dropdowns & Selections
  String _selectedFood = 'Vegetarian';
  bool _agreedToRules = false;

  final List<String> _nehaRules = [
    "1. विद्यार्थीले अनिवार्य रूपमा अभिभावकको उपस्थितिमा भर्ना फारम भर्नुपर्नेछ । (कार्यालयको लागि फोटो र परिचय खुल्ने Citizenship/License/ID-Card फोटोकपी संलग्न हुनुपर्नेछ)",
    "2. कलेज/इन्ституटको समयबाहेक बाहेकको सम्पूर्ण समयको व्यवस्थापक/प्रशासनले तोके अनुसार हुनेछ ।",
    "3. विद्यार्थीहरूले होस्टेलदेखि बाहिर जानु परेमा होस्टेल व्यवस्थापन/प्रशासनको अनुमति लिई سجل (Logbook) भर्नुपर्नेछ ।",
    "4. विद्यार्थीहरू जाडो महिनामा बेलुका ६:३० बजे र गर्मी महिनामा बेलुकी ७:३० बजेसम्म भित्र होस्टेल प्रवेश गरिसक्नु पर्नेछ ।",
    "5. फारममा उल्लेखित नरहेका स्थानीय अभिभावक तथा बुबा/आमालाई मात्र विद्यार्थी भेट्न अनुमति दिइनेछ ।",
    "6. पहिलो पटक विद्यार्थी भर्ना गर्दा बाहेक कुनै पनि अभिभावक तथा आगन्तुकहरूलाई सीधा कोठामा लैजान पाइने छैन ।",
    "7. विद्यार्थीहरूले मदिरा नर-नहवा, नगद तथा अन्य बहुमूल्य सामानहरू होस्टेलमा राख्न पाइने छैन ।",
    "8. होस्टेलमा विद्यार्थीहरूले मद्यपान, धूम्रपान, मादक पदार्थ, लागु औषध सेवन तथा फोहोर मैला र कानूनले निषेध गरेका गैरकानूनी क्रियाकलाप गर्न/गराउन पाइने छैन ।",
    "9. होस्टेलको भौतिक सम्पत्ति तोडफोड गरेमा वा हानि नोक्सानी गरेको Pajma हो भने महिनाको शुल्क र किमो अनुरूपको जरिवाना शुल्क लिई निष्कासन समेत गर्न सकिनेछ ।",
    "10. विद्यार्थीले अग्रिम मासिक शुल्क प्रत्येक महिनाको ५ गते भित्र बुझਾਈ सक्नु पर्नेछ । अन्यथा दैनिक रू ५०/- का दरले जरिवाना थप गरी ७ दिन भित्र बुझाउनु पर्नेछ ।",
    "11. होस्टेलमा हो-हल्ला, झगडा, अर्को कोठामा जाने, अर्को सामान चलाउने र अरू कसैलाई बाँधा हुने कार्य गर्न र कराउन पाइने छैन ।",
    "12. बुदा नं ८, ९, १० र ११ अनुरूप निष्कासित विद्यार्थीहरूले तिरेका कुनै पनि शुल्क र धріटी रकम फिर्ता हुने छैन ।",
    "13. विद्यार्थीहरूलाई खानाको तालिका (Time and Menu) अनुसार मात्र खुवाइनेछ तर बिरामी भएको अवस्थामा केही सुविधा दिन सकिनेछ ।",
    "14. होस्टेल प्रशासन मार्फत अनुमति लिई यदि विद्यार्थी लगातार १५ दिनभन्दा बढी होस्टेलमा नरहेको खण्डमा (छुट्टिमा बस्मा) एक तेस्रो मासिक शुल्क घटाइने छ ।",
    "15. दशैंदेखि छठसम्म होस्टेल बिदा हुनेछ । तर होस्टेल व्यवस्थापन/प्रशासन होस्टेल संचालन गर्न बाध्य हुने छैनन् ।",
    "16. विद्यार्थीले होस्टेल व्यवस्थापन/प्रशासनलाई होस्टेल छोड्नु भन्दा १५ दिनअघि नै जानकारी गराउनु पर्ने छ ।",
    "17. कुनै पनि भविष्यवत् घटना जस्तै : आत्महत्या, होस्टेल बाहिर भएको समयमा वेपत्ता, सम्पर्क विहीन, सडक दुर्घटना, विद्यार्थीले हानि विवाह समायत अप्रिय घटना भएको खण्डमा होस्टेल संचालक जवाफदेही हुने छैन ।",
    "18. विद्यार्थीलाई माथि उल्लेखित बाहेक केही समस्या परेमा होस्टेल व्यवस्थापन/प्रशासनसँग समन्वय गरी समाधानको उपाय अवलम्बन गर्न सकिनेछ ।",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0B1C30)),
        title: const Text(
          "Student Admission Form",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step Indicator Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStepIndicator(0, "Student Profile"),
                      _buildStepIndicator(1, "Guardian & Info"),
                      _buildStepIndicator(2, "Rules & Submit"),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Form Card Container based on Step
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0B1C30).withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: _buildCurrentStepContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int stepIndex, String title) {
    bool isActive = _currentStep == stepIndex;
    bool isPassed = _currentStep > stepIndex;
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: isActive || isPassed ? const Color(0xFF22C55E) : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isPassed
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text("${stepIndex + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isActive ? const Color(0xFF006E2F) : Colors.grey)),
      ],
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStudentProfileStep();
      case 1:
        return _buildGuardianProfileStep();
      case 2:
        return _buildRulesAndSubmitStep();
      default:
        return _buildStudentProfileStep();
    }
  }

  // STEP 0: Student Profile Form
  Widget _buildStudentProfileStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Student's Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
        const SizedBox(height: 16),
        _buildTextField("Student's Name (IN CAPITAL)", _nameEngController, Icons.person_outline),
        const SizedBox(height: 12),
        _buildTextField("Student's Name (IN NEPALI)", _nameNepController, Icons.language),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Date of Birth", _dobController, Icons.calendar_today)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Contact No.", _contactController, Icons.phone, keyboardType: TextInputType.phone)),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField("E-mail Address", _emailController, Icons.mail_outline, keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("District", _districtController, Icons.location_city)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Municipality/Rural", _municipalityController, Icons.map)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Ward No.", _wardController, Icons.pin_drop, keyboardType: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Street/Tole/Chowk", _streetController, Icons.streetview)),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField("Citizenship No. / Date of Issue / Place", _citizenshipController, Icons.badge),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Educational Institute", _instituteController, Icons.school)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Class Time", _classTimeController, Icons.access_time)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Level of Study", _levelOfStudyController, Icons.book)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Stay Duration", _stayDurationController, Icons.timer)),
          ],
        ),
        const SizedBox(height: 16),
        const Text("Food Preference", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
        const SizedBox(height: 8),
        Row(
          children: ['Vegetarian', 'Only Egg', 'Non-Vegetarian'].map((food) {
            return Expanded(
              child: RadioListTile<String>(
                title: Text(food, style: const TextStyle(fontSize: 11)),
                value: food,
                groupValue: _selectedFood,
                activeColor: const Color(0xFF006E2F),
                contentPadding: EdgeInsets.zero,
                onChanged: (val) => setState(() => _selectedFood = val!),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        _buildTextField("Mention any disease (if any)", _diseaseController, Icons.medical_services_outlined),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => setState(() => _currentStep = 1),
            child: const Text("Next: Guardian Profile", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  // STEP 1: Guardian's Profile Form
  Widget _buildGuardianProfileStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Guardian's Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
        const SizedBox(height: 16),
        _buildTextField("Father's Name", _fatherNameController, Icons.person),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Contact No.", _fatherContactController, Icons.phone, keyboardType: TextInputType.phone)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Occupation", _fatherOccController, Icons.work)),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField("Mother's Name", _motherNameController, Icons.person),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField("Contact No.", _motherContactController, Icons.phone, keyboardType: TextInputType.phone)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField("Occupation", _motherOccController, Icons.work)),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 10),
        const Text("Local Guardian Details", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF006E2F))),
        const SizedBox(height: 12),
        _buildTextField("Name of the Local Guardian", _localGuardianController, Icons.person_pin),
        const SizedBox(height: 12),
        _buildTextField("Address", _localGuardianAddressController, Icons.location_on),
        const SizedBox(height: 12),
        _buildTextField("Contact No.", _localGuardianContactController, Icons.phone, keyboardType: TextInputType.phone),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => setState(() => _currentStep = 0),
                child: const Text("Back", style: TextStyle(color: Color(0xFF006E2F))),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => setState(() => _currentStep = 2),
                child: const Text("Next: Rules & Submit", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // STEP 2: Rules & Regulations Agreement Form
  Widget _buildRulesAndSubmitStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("NeHA Rules & Regulations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
        const SizedBox(height: 4),
        const Text("Nepal Hostel Association (NeHA) Guidelines", style: TextStyle(fontSize: 12, color: Color(0xFF3D4A3D))),
        const SizedBox(height: 16),

        // Scrollable Rules Box matching image_640058.jpg
        Container(
          height: 250,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListView.builder(
            itemCount: _nehaRules.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _nehaRules[index],
                  style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B), height: 1.4),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Declaration text
        const Text(
          "I hereby declare that I am fully satisfied with the terms and conditions of the hostel. I agree every rule and regulation of the hostel and would like to get admission.",
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Color(0xFF3D4A3D)),
        ),
        const SizedBox(height: 12),

        CheckboxListTile(
          title: const Text(
            "I agree to all the hostel rules and regulations mentioned above.",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
          ),
          value: _agreedToRules,
          activeColor: const Color(0xFF006E2F),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (val) => setState(() => _agreedToRules = val!),
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => setState(() => _currentStep = 1),
                child: const Text("Back", style: TextStyle(color: Color(0xFF006E2F))),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _agreedToRules
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Student Application Submitted Successfully!')),
                  );
                  Navigator.pop(context);
                }
                    : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please agree to hostel rules to submit application.')),
                  );
                },
                child: const Text("Submit Application", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF3D4A3D)),
        prefixIcon: Icon(icon, color: const Color(0xFF006E2F), size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}