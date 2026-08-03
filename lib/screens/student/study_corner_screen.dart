// ==========================================
// FILE: study_corner_screen.dart
// Path: lib/screens/student/study_corner_screen.dart
// ==========================================

import 'package:flutter/material.dart';
import 'focus_session_screen.dart'; // FocusSessionScreen import garnu hos

class StudyCornerScreen extends StatefulWidget {
  const StudyCornerScreen({super.key});

  @override
  State<StudyCornerScreen> createState() => _StudyCornerScreenState();
}

class _StudyCornerScreenState extends State<StudyCornerScreen> {
  // Recent notes list
  final List<Map<String, dynamic>> recentNotes = [
    {'title': 'Algo_Final_Re...', 'info': '4.2 MB • Oct 12', 'icon': Icons.insert_drive_file_outlined},
    {'title': 'Physics_Lab_...', 'info': '128 MB • Oct 11', 'icon': Icons.video_library_outlined},
    {'title': 'Ethics_Case_S...', 'info': '12.0 MB • Oct 10', 'icon': Icons.folder_outlined},
    {'title': 'Midterm_Note...', 'info': '85 KB • Oct 09', 'icon': Icons.description_outlined},
  ];

  // Dynamic Today's Schedule list for user additions
  final List<Map<String, String>> todaysSchedule = [
    {
      'time': '09:00 AM - 10:30 AM',
      'title': 'Algorithms Lecture',
      'subtitle': 'Room 302 • Prof. Smith',
    },
    {
      'time': '02:00 PM - 04:00 PM',
      'title': 'Physics Workshop',
      'subtitle': 'Lab B • Dr. Ray',
    },
  ];

  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteInfoController = TextEditingController();

  final TextEditingController _scheduleTimeController = TextEditingController();
  final TextEditingController _scheduleTitleController = TextEditingController();
  final TextEditingController _scheduleSubController = TextEditingController();

  void _showAddNoteDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Note / Library Item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _noteTitleController,
                decoration: InputDecoration(
                  labelText: 'Note Title (e.g. Math_Notes)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _noteInfoController,
                decoration: InputDecoration(
                  labelText: 'File Size & Date (e.g. 5.1 MB • Today)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_noteTitleController.text.isNotEmpty) {
                      setState(() {
                        recentNotes.insert(0, {
                          'title': _noteTitleController.text,
                          'info': _noteInfoController.text.isNotEmpty ? _noteInfoController.text : '1.0 MB • Today',
                          'icon': Icons.insert_drive_file_outlined,
                        });
                      });
                      _noteTitleController.clear();
                      _noteInfoController.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Note added successfully!')),
                      );
                    }
                  },
                  child: const Text('Save Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddScheduleDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Today\'s Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _scheduleTimeController,
                decoration: InputDecoration(
                  labelText: 'Time (e.g. 04:00 PM - 05:00 PM)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _scheduleTitleController,
                decoration: InputDecoration(
                  labelText: 'Subject / Title (e.g. Database Lab)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _scheduleSubController,
                decoration: InputDecoration(
                  labelText: 'Location & Instructor (e.g. Lab A • Er. John)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_scheduleTitleController.text.isNotEmpty && _scheduleTimeController.text.isNotEmpty) {
                      setState(() {
                        todaysSchedule.add({
                          'time': _scheduleTimeController.text,
                          'title': _scheduleTitleController.text,
                          'subtitle': _scheduleSubController.text.isNotEmpty ? _scheduleSubController.text : 'Room 101',
                        });
                      });
                      _scheduleTimeController.clear();
                      _scheduleTitleController.clear();
                      _scheduleSubController.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Schedule added successfully!')),
                      );
                    }
                  },
                  child: const Text('Add Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
          ),
        ),
        title: const Text(
          'HostelMate',
          style: TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1E3A8A)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            const Text(
              'Study Corner',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Manage your academic productivity efficiently.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),

            // Focus Mode Timer Card (Clickable to open FocusSessionScreen)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FocusSessionScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E0365),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Focus Mode',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.timer_outlined, color: Colors.white54, size: 28),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 6),
                        ),
                        child: const Center(
                          child: Text(
                            '25:00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FocusSessionScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1E0365),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Start', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FocusSessionScreen()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white30),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Reset', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Deadlines Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Deadlines',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                Text(
                  'View All',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDeadlineCard('Data Structures Paper', 'Due: Today, 11:59 PM', 'Critical', const Color(0xFFB91C1C), const Color(0xFFFEF2F2)),
            const SizedBox(height: 10),
            _buildDeadlineCard('Physics Lab Report', 'Due: 3 Days', 'Ongoing', const Color(0xFF3B82F6), const Color(0xFFEFF6FF)),
            const SizedBox(height: 10),
            _buildDeadlineCard('Ethics Reflection', 'Due: Next Week', 'Planned', const Color(0xFF64748B), const Color(0xFFF1F5F9)),

            const SizedBox(height: 24),

            // Today's Schedule Section with Add Option
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Schedule",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                GestureDetector(
                  onTap: _showAddScheduleDialog,
                  child: const Text(
                    '+ Add Schedule',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 8, offset: const Offset(0, 3))],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todaysSchedule.length,
                separatorBuilder: (context, index) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final schedule = todaysSchedule[index];
                  return _buildScheduleItem(
                    schedule['time']!,
                    schedule['title']!,
                    schedule['subtitle']!,
                    index == 0,
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Recent Notes Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Notes',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                GestureDetector(
                  onTap: _showAddNoteDialog,
                  child: const Text(
                    'Browse Library →',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: recentNotes.length,
              itemBuilder: (context, index) {
                final note = recentNotes[index];
                return _buildNoteCard(note['title'], note['info'], note['icon']);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadlineCard(String title, String dueDate, String tag, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              Text(dueDate, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
            child: Text(tag, style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String title, String subtitle, bool isFirst) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: isFirst ? const Color(0xFF1E3A8A) : Colors.grey.shade400)),
            Container(width: 2, height: 35, color: Colors.grey.shade200),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF3B82F6))),
              const SizedBox(height: 2),
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoteCard(String title, String info, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF3B82F6), size: 24),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)), overflow: TextOverflow.ellipsis),
          const SizedBox(height: 2),
          Text(info, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
        ],
      ),
    );
  }
}