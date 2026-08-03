import 'package:flutter/material.dart';
import '../admin/api_service.dart';

class RoomStatusScreen extends StatefulWidget {
  final String userId;
  const RoomStatusScreen({super.key, required this.userId});

  @override
  State<RoomStatusScreen> createState() => _RoomStatusScreenState();
}

class _RoomStatusScreenState extends State<RoomStatusScreen> {
  List<dynamic> _rooms = [];
  Map<String, dynamic>? _myBooking;
  bool _isLoading = true;
  String _selectedBlock = 'All';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    await Future.wait([
      _fetchRooms(),
      _fetchMyStatus(),
    ]);
    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _fetchRooms() async {
    try {
      final rooms = await ApiService.fetchRooms();
      _rooms = rooms;
    } catch (e) {
      debugPrint("Error fetching rooms: $e");
    }
  }

  Future<void> _fetchMyStatus() async {
    try {
      final statusData = await ApiService.fetchBookingStatus(widget.userId);
      if (statusData['has_booking'] == true) {
        _myBooking = statusData;
      } else {
        _myBooking = null;
      }
    } catch (e) {
      debugPrint("Error fetching status: $e");
    }
  }

  void _openBookingForm(dynamic room) {
    final nameController = TextEditingController();
    final relationController = TextEditingController(text: 'Self');
    final phoneController = TextEditingController();
    final parentController = TextEditingController();
    final addressController = TextEditingController();
    final schoolController = TextEditingController();
    final purposeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Room Booking Form", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const Text("Please fill all details correctly to request a room.", style: TextStyle(color: Colors.grey, fontSize: 13)),
              const Divider(height: 32),
              
              _formField("Full Name of Student", nameController, Icons.person_outline),
              _formField("Applicant Relation (Self/Parent)", relationController, Icons.people_outline),
              _formField("Contact Number", phoneController, Icons.phone_android_outlined, isPhone: true),
              _formField("Parent/Guardian Name", parentController, Icons.family_restroom_outlined),
              _formField("Permanent Address", addressController, Icons.home_outlined),
              _formField("Current School/College", schoolController, Icons.school_outlined),
              _formField("Purpose of Stay", purposeController, Icons.assignment_outlined, maxLines: 2),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () async {
                    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Name and Phone are required!")));
                      return;
                    }
                    
                    Navigator.pop(context); // Close form
                    _submitBooking({
                      "user_id": widget.userId,
                      "room_no": room['room_no'].toString(),
                      "student_name": nameController.text,
                      "relation": relationController.text,
                      "phone": phoneController.text,
                      "parent_name": parentController.text,
                      "address": addressController.text,
                      "school": schoolController.text,
                      "purpose": purposeController.text,
                    });
                  },
                  child: const Text("Submit Request", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formField(String label, TextEditingController controller, IconData icon, {bool isPhone = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: 20, color: const Color(0xFF1E3A8A)),
              hintText: "Enter $label",
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitBooking(Map<String, dynamic> data) async {
    setState(() => _isLoading = true);
    final result = await ApiService.bookRoom(data);
    if (mounted) {
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Submitted Successfully! 🎉"), backgroundColor: Colors.green));
        _loadInitialData(); // Refresh everything
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${result['message']}"), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20), onPressed: () => Navigator.pop(context)),
        title: const Text("Select Your Room", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [IconButton(icon: const Icon(Icons.refresh_rounded), onPressed: _loadInitialData)],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (_myBooking != null) _buildStatusHeader(),
                _buildHeader(),
                _buildBlockFilter(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredRooms.length,
                    itemBuilder: (context, index) => _buildRoomCard(_filteredRooms[index]),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatusHeader() {
    Color statusColor = const Color(0xFFF59E0B); // Pending
    if (_myBooking!['status'] == 'Approved') statusColor = const Color(0xFF10B981);
    if (_myBooking!['status'] == 'Rejected') statusColor = const Color(0xFFEF4444);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: statusColor, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Booking: Room ${_myBooking!['room_no']}", style: TextStyle(fontWeight: FontWeight.bold, color: statusColor)),
                Text("Status: ${_myBooking!['status']}", style: TextStyle(fontSize: 12, color: statusColor.withValues(alpha: 0.8))),
              ],
            ),
          ),
          if (_myBooking!['status'] == 'Pending')
            const Text("Processing...", style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Available Space", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text("${_filteredRooms.length} Rooms match your choice", style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBlockFilter() {
    final blocks = ['All', 'Block A', 'Block B', 'Block C'];
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: blocks.length,
        itemBuilder: (context, index) {
          bool isSel = _selectedBlock == blocks[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedBlock = blocks[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isSel ? const Color(0xFF1E3A8A) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Text(blocks[index], style: TextStyle(color: isSel ? Colors.white : const Color(0xFF475569), fontWeight: FontWeight.bold, fontSize: 11)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRoomCard(dynamic room) {
    final int capacity = int.tryParse(room['capacity']?.toString() ?? '4') ?? 4;
    final int occupied = int.tryParse(room['occupied_count']?.toString() ?? '0') ?? 0;
    final int available = capacity - occupied;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(backgroundColor: const Color(0xFFEEF2FF), child: const Icon(Icons.meeting_room, color: Color(0xFF4F46E5))),
            title: Text("Room ${room['room_no']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("${room['block']} • ${room['floor']}"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("\$${room['rent']}", style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF166534))),
                Text("$available beds", style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                onPressed: () => _openBookingForm(room),
                child: const Text("Book Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> get _filteredRooms {
    return _rooms.where((room) {
      bool isAvailable = room['status']?.toString().toUpperCase() == 'AVAILABLE';
      bool matchesBlock = _selectedBlock == 'All' || room['block'] == _selectedBlock;
      return isAvailable && matchesBlock;
    }).toList();
  }
}
