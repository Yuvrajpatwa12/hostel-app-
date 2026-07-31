import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Form States
  String selectedCategory = "Social";
  String selectedVenue = "Select Location";
  String selectedAudience = "All Blocks";
  bool isLimitCapacity = true;
  bool isApprovalRequired = false;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController(text: "50");
  final TextEditingController _descriptionController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {"name": "Social", "icon": Icons.stars_outlined},
    {"name": "Workshop", "icon": Icons.build_outlined},
    {"name": "Sports", "icon": Icons.sports_basketball_outlined},
    {"name": "Academic", "icon": Icons.school_outlined},
  ];

  final List<String> venues = [
    "Select Location",
    "Common Room, Block B",
    "Main Auditorium",
    "Sports Field",
    "Cafeteria Hall"
  ];

  final List<String> audiences = [
    "All Blocks",
    "Block A Only",
    "Block B Only",
    "Block C Only"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create New Event",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text(
                  "DRAFT AUTO-\nSAVED",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. EVENT VISUALS
            _buildSectionTitle("EVENT VISUALS"),
            const SizedBox(height: 8),
            _buildImageUploadBox(),
            const SizedBox(height: 20),

            // 2. EVENT IDENTITY
            _buildSectionCard(
              children: [
                _buildSectionTitle("EVENT IDENTITY"),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "e.g., Annual Hostel Night 2026",
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Select Category",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: categories.map((cat) {
                    final isSelected = selectedCategory == cat["name"];
                    return InkWell(
                      onTap: () => setState(() => selectedCategory = cat["name"]),
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 76) / 2,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFFCBD5E1),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              cat["icon"],
                              size: 18,
                              color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF475569),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              cat["name"],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                color: isSelected ? const Color(0xFF1E3A8A) : const Color(0xFF475569),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
            const SizedBox(height: 16),

            // 3. SCHEDULE
            _buildSectionCard(
              children: [
                _buildSectionTitle("SCHEDULE"),
                const SizedBox(height: 12),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      setState(() {
                        _dateController.text = "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}";
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "mm/dd/yyyy",
                    prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF334155)),
                    suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF334155)),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _startTimeController,
                        readOnly: true,
                        onTap: () => _selectTime(_startTimeController),
                        decoration: InputDecoration(
                          hintText: "--:-- --",
                          prefixIcon: const Icon(Icons.access_time, size: 18, color: Color(0xFF334155)),
                          suffixIcon: const Icon(Icons.access_time, size: 18, color: Color(0xFF334155)),
                          filled: true,
                          fillColor: const Color(0xFFF1F5F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _endTimeController,
                        readOnly: true,
                        onTap: () => _selectTime(_endTimeController),
                        decoration: InputDecoration(
                          hintText: "--:-- --",
                          prefixIcon: const Icon(Icons.more_time_outlined, size: 18, color: Color(0xFF334155)),
                          suffixIcon: const Icon(Icons.access_time, size: 18, color: Color(0xFF334155)),
                          filled: true,
                          fillColor: const Color(0xFFF1F5F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            // 4. VENUE
            _buildSectionCard(
              children: [
                _buildSectionTitle("VENUE"),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedVenue,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFF334155)),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: venues.map((v) {
                    return DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 14)));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedVenue = val);
                  },
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    color: const Color(0xFFE2E8F0),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1524661135-423995f22d0b?w=600",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.map_outlined, color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // 5. EVENT DESCRIPTION
            _buildSectionCard(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle("EVENT DESCRIPTION"),
                    Row(
                      children: const [
                        Icon(Icons.format_bold, size: 18, color: Color(0xFF334155)),
                        SizedBox(width: 12),
                        Icon(Icons.format_italic, size: 18, color: Color(0xFF334155)),
                        SizedBox(width: 12),
                        Icon(Icons.format_list_bulleted, size: 18, color: Color(0xFF334155)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Provide details about what students should expect...",
                      hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            // 6. REGISTRATION SETTINGS
            _buildSectionCard(
              children: [
                _buildSectionTitle("REGISTRATION SETTINGS"),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Limit Capacity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("Set a maximum number of participants", style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                      ],
                    ),
                    Switch(
                      value: isLimitCapacity,
                      activeColor: const Color(0xFF1E3A8A),
                      onChanged: (val) => setState(() => isLimitCapacity = val),
                    )
                  ],
                ),
                if (isLimitCapacity) ...[
                  const SizedBox(height: 8),
                  TextField(
                    controller: _capacityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.people_outline, size: 18, color: Color(0xFF334155)),
                      filled: true,
                      fillColor: const Color(0xFFF1F5F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Approval Required", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("Manual approval for each entry", style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                      ],
                    ),
                    Switch(
                      value: isApprovalRequired,
                      activeColor: const Color(0xFF1E3A8A),
                      onChanged: (val) => setState(() => isApprovalRequired = val),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 7. TARGET AUDIENCE
            _buildSectionCard(
              children: [
                _buildSectionTitle("TARGET AUDIENCE"),
                const SizedBox(height: 8),
                const Text(
                  "Control which residential blocks can view and register for this event.",
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedAudience,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.business_outlined, color: Color(0xFF334155)),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: audiences.map((a) {
                    return DropdownMenuItem(value: a, child: Text(a, style: const TextStyle(fontSize: 14)));
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedAudience = val);
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildBlockBadge("A", const Color(0xFFDBEAFE), const Color(0xFF1E40AF)),
                    const SizedBox(width: 6),
                    _buildBlockBadge("B", const Color(0xFFD1FAE5), const Color(0xFF065F46)),
                    const SizedBox(width: 6),
                    _buildBlockBadge("C", const Color(0xFFFEF3C7), const Color(0xFF92400E)),
                    const SizedBox(width: 10),
                    const Text(
                      "3 Residential Blocks Selected",
                      style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),

            // 8. ACTION BUTTONS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF003399), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Draft Saved!")),
                      );
                    },
                    child: const Text(
                      "Save as Draft",
                      style: TextStyle(color: Color(0xFF003399), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003399),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Event Published Successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send_rounded, size: 16, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          "Publish Event",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helpers
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Color(0xFF475569),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
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
        children: children,
      ),
    );
  }

  Widget _buildImageUploadBox() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_photo_alternate_outlined, color: Color(0xFF1E3A8A), size: 28),
            ),
            const SizedBox(height: 8),
            const Text(
              "Click to upload banner",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 2),
            const Text(
              "Optimal size: 1200 × 480px (PNG, JPG)",
              style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlockBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        controller.text = time.format(context);
      });
    }
  }
}