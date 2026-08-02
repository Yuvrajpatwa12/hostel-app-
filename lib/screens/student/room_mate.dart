import 'package:flutter/material.dart';

class RoomMateScreen extends StatefulWidget {
  const RoomMateScreen({super.key});

  @override
  State<RoomMateScreen> createState() => _RoomMateScreenState();
}

class RoommateModel {
  String name;
  String phone;
  String email;
  String dob;
  String emergencyContact;
  String course;
  String roomNumber;

  RoommateModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.dob,
    required this.emergencyContact,
    required this.course,
    required this.roomNumber,
  });
}

class _RoomMateScreenState extends State<RoomMateScreen> {
  // Initial list of roommates
  final List<RoommateModel> _roommates = [
    RoommateModel(
      name: "Aakash Gupta",
      phone: "+977 9822222222",
      email: "aakash.gupta@example.com",
      dob: "12 Nov 2005",
      emergencyContact: "+977 9811122233 (Father)",
      course: "Class 12 Science (NEB)",
      roomNumber: "Block B - 304",
    ),
    RoommateModel(
      name: "Rohan Sharma",
      phone: "+977 9844444444",
      email: "rohan.sharma@example.com",
      dob: "20 Jan 2005",
      emergencyContact: "+977 9833333333 (Mother)",
      course: "Class 12 Science (NEB)",
      roomNumber: "Block B - 304",
    ),
  ];

  // Function to show Add or Edit Roommate Bottom Sheet
  void _showRoommateFormModal(BuildContext context, {RoommateModel? roommateToEdit, int? editIndex}) {
    final bool isEditing = roommateToEdit != null;

    final TextEditingController nameController = TextEditingController(text: isEditing ? roommateToEdit.name : '');
    final TextEditingController phoneController = TextEditingController(text: isEditing ? roommateToEdit.phone : '');
    final TextEditingController emailController = TextEditingController(text: isEditing ? roommateToEdit.email : '');
    final TextEditingController dobController = TextEditingController(text: isEditing ? roommateToEdit.dob : '');
    final TextEditingController emergencyController = TextEditingController(text: isEditing ? roommateToEdit.emergencyContact : '');
    final TextEditingController courseController = TextEditingController(text: isEditing ? roommateToEdit.course : '');
    final TextEditingController roomController = TextEditingController(text: isEditing ? roommateToEdit.roomNumber : 'Block B - 304');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).viewInsets.bottom + 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  isEditing ? 'Edit Roommate Details' : 'Add New Roommate',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('Full Name', nameController, Icons.person_outline),
                const SizedBox(height: 12),
                _buildTextField('Phone Number', phoneController, Icons.phone_outlined, keyboardType: TextInputType.phone),
                const SizedBox(height: 12),
                _buildTextField('Email Address', emailController, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 12),
                _buildTextField('Date of Birth', dobController, Icons.cake_outlined),
                const SizedBox(height: 12),
                _buildTextField('Course / Study', courseController, Icons.school_outlined),
                const SizedBox(height: 12),
                _buildTextField('Emergency Contact', emergencyController, Icons.emergency_outlined),
                const SizedBox(height: 12),
                _buildTextField('Room Number', roomController, Icons.meeting_room_outlined),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                        setState(() {
                          if (isEditing && editIndex != null) {
                            _roommates[editIndex] = RoommateModel(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text.isNotEmpty ? emailController.text : "N/A",
                              dob: dobController.text.isNotEmpty ? dobController.text : "N/A",
                              emergencyContact: emergencyController.text.isNotEmpty ? emergencyController.text : "N/A",
                              course: courseController.text.isNotEmpty ? courseController.text : "General",
                              roomNumber: roomController.text,
                            );
                          } else {
                            _roommates.add(
                              RoommateModel(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text.isNotEmpty ? emailController.text : "N/A",
                                dob: dobController.text.isNotEmpty ? dobController.text : "N/A",
                                emergencyContact: emergencyController.text.isNotEmpty ? emergencyController.text : "N/A",
                                course: courseController.text.isNotEmpty ? courseController.text : "General",
                                roomNumber: roomController.text,
                              ),
                            );
                          }
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(isEditing ? 'Roommate updated successfully!' : 'Roommate added successfully!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill Name and Phone number!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    child: Text(isEditing ? 'Save Changes' : 'Add Roommate'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show Warning Confirmation Dialog before Deleting
  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 26),
              SizedBox(width: 10),
              Text(
                'Delete Roommate',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to remove this roommate from your list? This action cannot be undone.',
            style: TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.4),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(dialogContext),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF64748B),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _roommates.removeAt(index);
                });
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Roommate successfully removed!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Yes, Delete', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Function to View Roommate Detailed Modal
  void _showRoommateDetails(BuildContext context, RoommateModel roommate, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150'),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roommate.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Room: ${roommate.roomNumber}',
                          style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Color(0xFFE2E8F0)),
              const SizedBox(height: 10),
              _buildDetailRow('Phone Number', roommate.phone, Icons.phone_outlined),
              _buildDetailRow('Email Address', roommate.email, Icons.email_outlined),
              _buildDetailRow('Date of Birth', roommate.dob, Icons.cake_outlined),
              _buildDetailRow('Course / Study', roommate.course, Icons.school_outlined),
              _buildDetailRow('Emergency Contact', roommate.emergencyContact, Icons.emergency_outlined, isRed: true),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showRoommateFormModal(context, roommateToEdit: roommate, editIndex: index);
                      },
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2563EB),
                        side: const BorderSide(color: Color(0xFF2563EB)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showDeleteConfirmationDialog(context, index);
                      },
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF64748B)),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 13, color: isRed ? const Color(0xFFDC2626) : const Color(0xFF0F172A), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 20),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF2563EB), width: 1.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Roommates Directory',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE2E8F0), height: 1),
        ),
      ),
      body: _roommates.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group_off_outlined, size: 50, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            const Text(
              'No Roommates Added Yet',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap the + button below to add your roommates.',
              style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            ),
          ],
        ),
      )
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: _roommates.length,
        itemBuilder: (context, index) {
          final roommate = _roommates[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              leading: const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150'),
              ),
              title: Text(
                roommate.name,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Room: ${roommate.roomNumber} • ${roommate.phone}',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _showRoommateDetails(context, roommate, index),
                    icon: const Icon(Icons.visibility_outlined, size: 20, color: Color(0xFF2563EB)),
                    tooltip: 'View Details',
                  ),
                  IconButton(
                    onPressed: () => _showDeleteConfirmationDialog(context, index),
                    icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFFDC2626)),
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRoommateFormModal(context),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
        elevation: 2,
        icon: const Icon(Icons.add),
        label: const Text('Add Roommate', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}