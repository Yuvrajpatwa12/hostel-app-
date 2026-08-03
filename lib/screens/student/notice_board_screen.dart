import 'package:flutter/material.dart';

class NoticeBoardScreen extends StatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  State<NoticeBoardScreen> createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  // Dummy Notice Data with Categories
  final List<Map<String, dynamic>> _allNotices = [
    {
      'title': 'Fee Reminder',
      'category': 'Academic',
      'subtitle': 'Last date for Semester 2 mess fees installment is approaching.',
      'time': '2h ago',
      'icon': Icons.payment,
      'isPriority': false,
    },
    {
      'title': 'Revised Mess Menu',
      'category': 'Maintenance',
      'subtitle': 'Added new continental breakfast items from upcoming Monday.',
      'time': '5h ago',
      'icon': Icons.restaurant_menu,
      'isPriority': false,
    },
    {
      'title': 'Hostel Night RSVP',
      'category': 'Events',
      'subtitle': 'Submit your cultural performance entries before Wednesday.',
      'time': 'Yesterday',
      'icon': Icons.celebration,
      'isPriority': false,
    },
    {
      'title': 'Library Extended Hours',
      'category': 'Academic',
      'subtitle': 'Open till 2 AM for mid-term examination preparation.',
      'time': '2d ago',
      'icon': Icons.school_outlined,
      'isPriority': false,
    },
    {
      'title': 'Wi-Fi Maintenance',
      'category': 'Other',
      'subtitle': 'Router upgrades will happen on the 3rd floor tonight.',
      'time': '3d ago',
      'icon': Icons.wifi,
      'isPriority': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter notices based on Category and Search Query
    final filteredNotices = _allNotices.where((notice) {
      final matchesCategory = _selectedCategory == 'All' || notice['category'] == _selectedCategory;
      final matchesSearch = notice['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          notice['subtitle'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notice Board',
          style: TextStyle(
            color: Color(0xFF1E3A8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Search Action Workable
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0F172A)),
            onPressed: () {
              _showSearchBottomSheet(context);
            },
          ),
          // Notifications Action Workable
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF0F172A)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You are already on the Notice Board!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Categories Chips (All, Maintenance, Events, Academic, Other)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Maintenance', 'Events', 'Academic', 'Other'].map((category) {
                  bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      selectedColor: const Color(0xFF2563EB),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Priority Alerts Header
            Row(
              children: const [
                Text(
                  'Priority Alerts',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                SizedBox(width: 6),
                CircleAvatar(radius: 4, backgroundColor: Colors.red),
              ],
            ),
            const SizedBox(height: 12),

            // Urgent Notice Card (Fully Workable)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFB91C1C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'URGENT',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        '🕒 Today, 14:00 - 16:00',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Water Supply Interruption',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Scheduled maintenance for main tank cleaning. Residents are advised to store water beforehand.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        children: const [
                          Text('STARTS IN', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('01:42:05', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFB91C1C),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        _showNoticeDetails(
                          context,
                          'Water Supply Interruption',
                          'Scheduled maintenance for main tank cleaning. Residents are advised to store water beforehand.\n\nTime: Today, 14:00 - 16:00\nLocation: Entire Hostel Building',
                        );
                      },
                      child: const Text('Read More', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Official Documents Banner (Workable Button)
            GestureDetector(
              onTap: () {
                _showOfficialDocumentsDialog(context);
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Official Documents', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('Policies, Handbooks & Forms', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.folder_shared_outlined, color: Colors.white, size: 32),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Recent Updates Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Updates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'All';
                      _searchQuery = '';
                    });
                  },
                  child: const Text('View All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Dynamic & Filtered List of Updates
            filteredNotices.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Text('No notices found for this category.', style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredNotices.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final notice = filteredNotices[index];
                      return GestureDetector(
                        onTap: () {
                          _showNoticeDetails(context, notice['title'], notice['subtitle']);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                                child: Icon(notice['icon'], color: const Color(0xFF2563EB), size: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(notice['title'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                                        Text(notice['time'], style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(notice['subtitle'], style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // Notice Detail Dialog Popup
  void _showNoticeDetails(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        content: Text(description, style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Search Dialog Popup
  void _showSearchBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Search Notices', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter keyword...'),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Official Documents Dialog Popup
  void _showOfficialDocumentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Official Documents', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Hostel Rulebook & Policy'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloading Rulebook...')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.blue),
              title: const Text('Mess Committee Form'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloading Form...')));
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF2563EB))),
          ),
        ],
      ),
    );
  }
}