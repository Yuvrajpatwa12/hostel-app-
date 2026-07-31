import 'package:flutter/material.dart';
import 'add_new_room_screen.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  String _selectedBlock = 'All Blocks';
  String _searchQuery = '';
  int _currentIndex = 1;

  final List<String> _blocks = [
    'All Blocks',
    'Block A',
    'Block B',
    'Block C',
    'Block D',
    'Block E',
  ];

  final List<Map<String, dynamic>> _allRooms = [
    {
      "roomName": "Room 101",
      "block": "Block A",
      "details": "Block A • Ground Floor",
      "capacityText": "4 / 4",
      "progress": 1.0,
      "isFull": true,
    },
    {
      "roomName": "Room 102",
      "block": "Block A",
      "details": "Block A • Ground Floor",
      "capacityText": "2 / 4",
      "progress": 0.5,
      "isFull": false,
    },
    {
      "roomName": "Room 205",
      "block": "Block B",
      "details": "Block B • 2nd Floor",
      "capacityText": "0 / 4",
      "progress": 0.0,
      "isFull": false,
    },
    {
      "roomName": "Room 312",
      "block": "Block C",
      "details": "Block C • 3rd Floor",
      "capacityText": "3 / 4",
      "progress": 0.75,
      "isFull": false,
    },
    {
      "roomName": "Room 110",
      "block": "Block A",
      "details": "Block A • Ground Floor",
      "capacityText": "2 / 2",
      "progress": 1.0,
      "isFull": true,
    },
  ];

  List<Map<String, dynamic>> get _filteredRooms {
    return _allRooms.where((room) {
      bool matchesBlock = (_selectedBlock == 'All Blocks') ||
          (room['block'] == _selectedBlock);
      bool matchesSearch = room['roomName']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesBlock && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "HostelMate",
          style: TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none,
                color: Color(0xFF0F172A)),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundImage:
                  NetworkImage('https://i.pravatar.cc/100?img=5'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard("TOTAL ROOMS", "124", Icons.door_sliding_outlined,
                const Color(0xFF818CF8)),
            const SizedBox(height: 12),
            _buildSummaryCard("OCCUPIED", "98", Icons.person_outline,
                const Color(0xFF34D399)),
            const SizedBox(height: 12),
            _buildSummaryCard("AVAILABLE", "26", Icons.calendar_today_outlined,
                const Color(0xFFF87171)),
            const SizedBox(height: 20),

            TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: "Search room number...",
                hintStyle:
                    const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _blocks.map((block) {
                  bool isSelected = _selectedBlock == block;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(block),
                      selected: isSelected,
                      selectedColor: const Color(0xFF2563EB),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? Colors.transparent
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      onSelected: (selected) {
                        setState(() => _selectedBlock = block);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            ..._filteredRooms.map((room) {
              return _buildRoomCard(
                room["roomName"],
                room["details"],
                room["capacityText"],
                room["progress"],
                isFull: room["isFull"],
              );
            }),

            if (_filteredRooms.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Center(
                  child: Text("No rooms found.",
                      style: TextStyle(color: Color(0xFF64748B))),
                ),
              ),

            // 🚀 Add New Room Clickable Card (Navigates to Form Screen)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewRoomScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFCBD5E1),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Icon(Icons.add, color: Color(0xFF2563EB)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "ADD NEW ROOM",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: Color(0xFF1E293B),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.grid_view_rounded, "Dashboard"),
            _buildNavItem(1, Icons.check_box_outlined, "Manage"),
            _buildNavItem(2, Icons.insert_chart_outlined, "Reports"),
            _buildNavItem(3, Icons.person_outline, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color iconBg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconBg, size: 22),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B))),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
      String roomName, String details, String capacityText, double progress,
      {required bool isFull}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(roomName,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A))),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isFull
                      ? const Color(0xFFFEE2E2)
                      : const Color(0xFFA7F3D0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isFull ? "FULL" : "AVAILABLE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isFull
                        ? const Color(0xFF991B1B)
                        : const Color(0xFF065F46),
                  ),
                ),
              )
            ],
          ),
          Text(details,
              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Capacity",
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              Text(capacityText,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: const Color(0xFFEEF2FF),
            color: isFull ? const Color(0xFFB91C1C) : const Color(0xFF047857),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  onPressed: () {},
                  child: const Text("Edit",
                      style: TextStyle(
                          color: Color(0xFF334155),
                          fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text(
                    isFull ? "Assigned" : "Assign",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6EE7B7) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color:
                  isSelected ? const Color(0xFF047857) : const Color(0xFF64748B),
              size: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected
                  ? const Color(0xFF047857)
                  : const Color(0xFF64748B),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}