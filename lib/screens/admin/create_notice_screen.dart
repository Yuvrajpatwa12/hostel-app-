import 'package:flutter/material.dart';

class CreateNoticeScreen extends StatefulWidget {
  const CreateNoticeScreen({super.key});

  @override
  State<CreateNoticeScreen> createState() => _CreateNoticeScreenState();
}

class _CreateNoticeScreenState extends State<CreateNoticeScreen> {
  String _selectedNoticeType = 'Event';
  String _selectedTargetAudience = 'All Blocks';
  bool _isUrgent = false;
  bool _pushNotification = true;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final List<Map<String, dynamic>> _noticeTypes = [
    {"label": "General", "icon": Icons.campaign_outlined},
    {"label": "Event", "icon": Icons.calendar_today_outlined},
    {"label": "Alert", "icon": Icons.warning_amber_rounded},
    {"label": "Maintenance", "icon": Icons.build_outlined},
  ];

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
          "Create New Notice",
          style: TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1E3A8A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notice Type Horizontal Selector
            _buildSectionHeader("NOTICE TYPE"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _noticeTypes.map((type) {
                  bool isSelected = _selectedNoticeType == type["label"];
                  return GestureDetector(
                    onTap: () => setState(() => _selectedNoticeType = type["label"]),
                    child: Container(
                      width: 95,
                      height: 85,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            type["icon"],
                            color: const Color(0xFF1E293B),
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            type["label"],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Form Container Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notice Title
                  const Text(
                    "Notice Title",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "e.g., Annual Sports Meet 2024",
                      hintStyle: const TextStyle(
                        color: Color(0xFFCBD5E1),
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description / Details
                  const Text(
                    "Description / Details",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Rich Text Toolbar Row
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: const [
                              Text("B",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              SizedBox(width: 16),
                              Text("I",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 16),
                              Icon(Icons.format_list_bulleted, size: 18),
                              SizedBox(width: 16),
                              Icon(Icons.link, size: 18),
                            ],
                          ),
                        ),
                        const Divider(height: 1, color: Color(0xFFE2E8F0)),
                        const TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Share more details about the announcement...",
                            hintStyle: TextStyle(
                              color: Color(0xFFCBD5E1),
                              fontSize: 13,
                            ),
                            contentPadding: EdgeInsets.all(12),
                            border: InputBorder.none,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.filter_list,
                            size: 12,
                            color: Color(0xFFCBD5E1),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Schedule Date
                  const Text(
                    "Schedule Date",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() {
                          _dateController.text =
                              "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "mm/dd/yyyy",
                      hintStyle: const TextStyle(
                          color: Color(0xFF475569), fontSize: 13),
                      prefixIcon: const Icon(Icons.calendar_today_outlined,
                          size: 18, color: Color(0xFF94A3B8)),
                      suffixIcon: const Icon(Icons.calendar_month_outlined,
                          size: 18, color: Color(0xFF1E293B)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Schedule Time
                  const Text(
                    "Schedule Time",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          _timeController.text = picked.format(context);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "--:-- --",
                      hintStyle: const TextStyle(
                          color: Color(0xFF475569), fontSize: 13),
                      prefixIcon: const Icon(Icons.access_time,
                          size: 18, color: Color(0xFF94A3B8)),
                      suffixIcon: const Icon(Icons.access_time,
                          size: 18, color: Color(0xFF1E293B)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Target Audience
                  const Text(
                    "Target Audience",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedTargetAudience,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.groups_outlined,
                          size: 20, color: Color(0xFF94A3B8)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: ['All Blocks', 'Block A', 'Block B', 'Block C']
                        .map((block) => DropdownMenuItem(
                              value: block,
                              child: Text(block,
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xFF1E293B))),
                            ))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => _selectedTargetAudience = val!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Media & Attachments
            _buildSectionHeader("MEDIA & ATTACHMENTS"),
            Row(
              children: [
                Expanded(
                  child: _buildDashedAttachmentBox(
                    icon: Icons.add_a_photo_outlined,
                    label: "Add Poster",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDashedAttachmentBox(
                    icon: Icons.picture_as_pdf_outlined,
                    label: "Attach PDF",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Toggle Switches Cards
            _buildToggleCard(
              icon: Icons.priority_high,
              iconBg: const Color(0xFFFEE2E2),
              iconColor: const Color(0xFFDC2626),
              title: "Mark as Urgent",
              subtitle: "Bypass silence settings for students",
              value: _isUrgent,
              onChanged: (val) => setState(() => _isUrgent = val),
            ),
            const SizedBox(height: 12),
            _buildToggleCard(
              icon: Icons.notifications_none,
              iconBg: const Color(0xFFDCFCE7),
              iconColor: const Color(0xFF166534),
              title: "Push Notification",
              subtitle: "Notify all target students instantly",
              value: _pushNotification,
              onChanged: (val) => setState(() => _pushNotification = val),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Save Draft",
                      style: TextStyle(
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003893),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.send_outlined,
                        size: 18, color: Colors.white),
                    label: const Text(
                      "Post Notice",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF475569),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDashedAttachmentBox({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFCBD5E1),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF475569), size: 26),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF1E3A8A),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}