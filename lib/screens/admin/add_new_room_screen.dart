import 'package:flutter/material.dart';
import 'api_service.dart';

class AddNewRoomScreen extends StatefulWidget {
  final dynamic editRoom;
  const AddNewRoomScreen({super.key, this.editRoom});

  @override
  State<AddNewRoomScreen> createState() => _AddNewRoomScreenState();
}

class _AddNewRoomScreenState extends State<AddNewRoomScreen> {
  final TextEditingController _roomNoController = TextEditingController();
  final TextEditingController _rentController = TextEditingController();

  String selectedBlock = 'Block A';
  String selectedFloor = 'Ground Floor';
  String selectedRoomType = 'Single Occupancy';
  int totalCapacity = 2;
  bool isAvailable = true;
  bool _isLoading = false;

  final Map<String, bool> amenities = {
    'AC': true,
    'Attached Washroom': true,
    'Balcony': false,
    'Wi-Fi': true,
    'Study Table': false,
    'Wardrobe': true,
  };

  @override
  void initState() {
    super.initState();
    if (widget.editRoom != null) {
      _roomNoController.text = widget.editRoom['room_no'].toString();
      _rentController.text = widget.editRoom['rent']?.toString() ?? '';
      selectedBlock = widget.editRoom['block'] ?? 'Block A';
      selectedFloor = widget.editRoom['floor'] ?? 'Ground Floor';
      totalCapacity = int.tryParse(widget.editRoom['capacity']?.toString() ?? '2') ?? 2;
      isAvailable = widget.editRoom['status']?.toString().toUpperCase() == 'AVAILABLE';

      if (widget.editRoom['amenities'] != null) {
        final List<String> savedList = widget.editRoom['amenities'].toString().split(', ');
        for (var key in amenities.keys) {
          amenities[key] = savedList.contains(key);
        }
      }
    }
  }

  @override
  void dispose() {
    _roomNoController.dispose();
    _rentController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_roomNoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Room number is required!")));
      return;
    }

    setState(() => _isLoading = true);

    final roomData = {
      "room_no": _roomNoController.text.trim(),
      "block": selectedBlock,
      "floor": selectedFloor,
      "room_type": selectedRoomType,
      "capacity": totalCapacity,
      "rent": _rentController.text.trim(),
      "amenities": amenities.entries.where((e) => e.value).map((e) => e.key).join(', '),
      "status": isAvailable ? "AVAILABLE" : "FULL",
    };

    final result = widget.editRoom == null
        ? await ApiService.addRoom(roomData)
        : await ApiService.updateRoom(roomData);

    if (mounted) {
      setState(() => _isLoading = false);
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.editRoom == null ? "Room Created! 🎉" : "Room Updated! ✨"), backgroundColor: Colors.green));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${result['message']}"), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.editRoom != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)), onPressed: () => Navigator.pop(context)),
        title: Text(isEdit ? "Edit Room Details" : "Add New Room", style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBanner(),
            const SizedBox(height: 16),

            _buildSectionCard(
              title: "Basic Information",
              icon: Icons.domain_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel("Room Number"),
                  TextField(
                    controller: _roomNoController,
                    enabled: !isEdit,
                    decoration: _inputDeco("e.g. 101", Icons.tag),
                  ),
                  const SizedBox(height: 14),
                  _fieldLabel("Hostel Block"),
                  _blockSelector(),
                  const SizedBox(height: 14),
                  _fieldLabel("Floor"),
                  _dropdown(selectedFloor, ['Ground Floor', '1st Floor', '2nd Floor', '3rd Floor'], (v) => setState(() => selectedFloor = v!)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              title: "Rent & Capacity",
              icon: Icons.payments_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel("Total Capacity"),
                  _capacityCounter(),
                  const SizedBox(height: 14),
                  _fieldLabel("Monthly Rent"),
                  TextField(
                    controller: _rentController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco("0.00", Icons.attach_money),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Color(0xFF166534), size: 24),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Room Availability", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Ready for immediate use", style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                  Switch(value: isAvailable, activeTrackColor: const Color(0xFF1E3A8A), onChanged: (val) => setState(() => isAvailable = val)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                onPressed: _handleSave,
                child: Text(isEdit ? "Update Changes" : "Create Room", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1555854877-bab0e564b8d5?q=80&w=600'), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        alignment: Alignment.bottomLeft,
        child: const Text("Housing Configuration", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: const Color(0xFF2563EB), size: 18), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))]),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }

  Widget _fieldLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))));

  InputDecoration _inputDeco(String hint, IconData icon) => InputDecoration(
    prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 18),
    hintText: hint,
    fillColor: const Color(0xFFF8FAFC),
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
  );

  Widget _blockSelector() {
    return Row(
      children: ['Block A', 'Block B', 'Block C'].map((block) {
        bool isSel = selectedBlock == block;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedBlock = block),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: isSel ? const Color(0xFF2563EB) : const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)),
              child: Text(block, textAlign: TextAlign.center, style: TextStyle(color: isSel ? Colors.white : const Color(0xFF475569), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _dropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
      onChanged: onChanged,
      decoration: _inputDeco("", Icons.layers),
    );
  }

  Widget _capacityCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => setState(() => totalCapacity = totalCapacity > 1 ? totalCapacity - 1 : 1)),
          Text("$totalCapacity", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => setState(() => totalCapacity++)),
        ],
      ),
    );
  }
}
