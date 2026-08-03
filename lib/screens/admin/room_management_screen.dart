import 'package:flutter/material.dart';
import 'api_service.dart';
import 'add_new_room_screen.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  String _selectedBlock = 'All Blocks';
  String _searchQuery = '';
  List<dynamic> _allRooms = [];
  bool _isLoading = true;

  final List<String> _blocks = [
    'All Blocks',
    'Block A',
    'Block B',
    'Block C',
    'Block D',
    'Block E',
  ];

  @override
  void initState() {
    super.initState();
    _fetchRoomsData();
  }

  Future<void> _fetchRoomsData() async {
    setState(() => _isLoading = true);
    try {
      final rooms = await ApiService.fetchRooms();
      setState(() {
        _allRooms = rooms;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching rooms: $e");
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteRoom(String roomNo) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete Room $roomNo?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isLoading = true);
      final result = await ApiService.deleteRoom(roomNo);
      if (mounted) {
        if (result['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Room deleted!")));
          _fetchRoomsData();
        } else {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${result['message']}")));
        }
      }
    }
  }

  List<dynamic> get _filteredRooms {
    return _allRooms.where((room) {
      bool matchesBlock = (_selectedBlock == 'All Blocks') ||
          (room['block'] == _selectedBlock);
      bool matchesSearch = room['room_no']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesBlock && matchesSearch;
    }).toList();
  }

  int get _totalRooms => _allRooms.length;
  int get _occupiedRooms => _allRooms.where((r) => r['status']?.toString().toUpperCase() == 'FULL').length;
  int get _availableRooms => _allRooms.where((r) => r['status']?.toString().toUpperCase() == 'AVAILABLE').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Room Management",
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)), onPressed: _fetchRoomsData),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchRoomsData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard("TOTAL ROOMS", "$_totalRooms", Icons.door_sliding_outlined, const Color(0xFF818CF8)),
              const SizedBox(height: 12),
              _buildSummaryCard("OCCUPIED", "$_occupiedRooms", Icons.person_outline, const Color(0xFF34D399)),
              const SizedBox(height: 12),
              _buildSummaryCard("AVAILABLE", "$_availableRooms", Icons.calendar_today_outlined, const Color(0xFFF87171)),
              const SizedBox(height: 20),

              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: "Search room number...",
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8)),
                  filled: true,
                  fillColor: const Color(0xFFF1F5F9),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
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
                        labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF334155)),
                        onSelected: (selected) => setState(() => _selectedBlock = block),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              ..._filteredRooms.map((room) {
                final int capacity = int.tryParse(room['capacity']?.toString() ?? '4') ?? 4;
                final int occupied = int.tryParse(room['occupied_count']?.toString() ?? '0') ?? 0;
                final bool isFull = room['status']?.toString().toUpperCase() == "FULL";
                
                return _buildRoomCard(
                  room: room,
                  roomName: room["room_no"] ?? "N/A",
                  details: "${room['block']} • ${room['floor']}",
                  capacityText: "$occupied / $capacity",
                  progress: occupied / capacity,
                  isFull: isFull,
                );
              }),

              if (_filteredRooms.isEmpty)
                const Center(child: Padding(padding: EdgeInsets.all(40), child: Text("No rooms found."))),

              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewRoomScreen()));
                  if (result == true) _fetchRoomsData();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.add_circle_outline, color: Color(0xFF2563EB), size: 32),
                      SizedBox(height: 8),
                      Text("ADD NEW ROOM", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: color.withValues(alpha: 0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildRoomCard({
    required dynamic room,
    required String roomName,
    required String details,
    required String capacityText,
    required double progress,
    required bool isFull,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Room $roomName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              _buildStatusBadge(isFull),
            ],
          ),
          Text(details, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Capacity", style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              Text(capacityText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
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
                  onPressed: () => _showRoomDetails(room),
                  child: const Text("Details", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
                  onPressed: () async {
                    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewRoomScreen(editRoom: room)));
                    if (result == true) _fetchRoomsData();
                  },
                  child: const Text("Edit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _deleteRoom(roomName),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isFull) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isFull ? const Color(0xFFFEE2E2) : const Color(0xFFA7F3D0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isFull ? "FULL" : "AVAILABLE",
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isFull ? const Color(0xFF991B1B) : const Color(0xFF065F46)),
      ),
    );
  }

  void _showRoomDetails(dynamic room) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Room ${room['room_no']} Info", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            _infoRow("Block", room['block'] ?? "N/A"),
            _infoRow("Floor", room['floor'] ?? "N/A"),
            _infoRow("Rent", "\$${room['rent'] ?? '0.00'}"),
            _infoRow("Amenities", room['amenities'] ?? "Standard Features"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }
}
