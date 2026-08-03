import 'package:flutter/material.dart';
import 'api_service.dart';
import 'add_new_student_screen.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  List<dynamic> _allStudents = [];
  bool _isLoading = true;
  String _searchQuery = "";
  String _selectedFilterStatus = "ALL"; // ALL, ACTIVE, INACTIVE, VACANT

  @override
  void initState() {
    super.initState();
    _fetchStudentsData();
  }

  // Use ApiService to fetch students from Hostinger database
  Future<void> _fetchStudentsData() async {
    setState(() => _isLoading = true);
    try {
      final students = await ApiService.fetchStudents();
      setState(() {
        _allStudents = students;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching students: $e");
      setState(() => _isLoading = false);
    }
  }

  // Filter aur Search Logic (Case-insensitive status check)
  List<dynamic> get _filteredStudents {
    return _allStudents.where((student) {
      final name = student['name']?.toLowerCase() ?? '';
      final id = student['id'].toString().toLowerCase();
      final room = student['room_no']?.toLowerCase() ?? '';
      final status = student['status']?.toString().toUpperCase() ?? 'ACTIVE';

      final matchesSearch = name.contains(_searchQuery.toLowerCase()) ||
          id.contains(_searchQuery.toLowerCase()) ||
          room.contains(_searchQuery.toLowerCase());

      bool matchesStatus = true;
      if (_selectedFilterStatus == "ACTIVE") {
        matchesStatus = status == "ACTIVE";
      } else if (_selectedFilterStatus == "INACTIVE") {
        matchesStatus = status == "INACTIVE";
      } else if (_selectedFilterStatus == "VACANT") {
        matchesStatus = status == "VACANT";
      }

      return matchesSearch && matchesStatus;
    }).toList();
  }

  // Counts Calculation from Hostinger Data (Case-insensitive)
  int get _totalCount => _allStudents.length;
  int get _activeCount => _allStudents.where((s) => (s['status']?.toString().toUpperCase() ?? 'ACTIVE') == "ACTIVE").length;
  int get _inactiveCount => _allStudents.where((s) => (s['status']?.toString().toUpperCase() ?? '') == "INACTIVE").length;
  int get _vacantCount => _allStudents.where((s) => (s['status']?.toString().toUpperCase() ?? '') == "VACANT").length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchStudentsData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: "Search student by name, ID or room..",
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Filters Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                onPressed: _showFilterBottomSheet,
                icon: const Icon(Icons.tune, size: 18, color: Color(0xFF0F172A)),
                label: Text(
                  "FILTERS (${_selectedFilterStatus})",
                  style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(height: 20),

              // Interactive Summary Cards (Hostinger Real Counts)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _buildSummaryCard("TOTAL", "$_totalCount", Icons.groups, const Color(0xFF2563EB), "ALL"),
                  _buildSummaryCard("ACTIVE", "$_activeCount", Icons.check_circle_outline, const Color(0xFF10B981), "ACTIVE"),
                  _buildSummaryCard("INACTIVE", "$_inactiveCount", Icons.cancel_outlined, const Color(0xFFEF4444), "INACTIVE"),
                  _buildSummaryCard("VACANT", "$_vacantCount", Icons.king_bed_outlined, const Color(0xFFF59E0B), "VACANT"),
                ],
              ),
              const SizedBox(height: 24),

              // Filter Title Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_getFilterTitle()}\nResidents (Hostinger DB)",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A), height: 1.1),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Dynamic Student Cards List from Hostinger
              _filteredStudents.isEmpty
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text("No students found in database.", style: TextStyle(color: Color(0xFF64748B))),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return _buildStudentCard(student);
                },
              ),
            ],
          ),
        ),
      ),

      // FAB Navigation to Add Student
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewStudentScreen()),
          );
          if (result == true) {
            _fetchStudentsData();
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  String _getFilterTitle() {
    switch (_selectedFilterStatus) {
      case "ACTIVE": return "Active";
      case "INACTIVE": return "Inactive";
      case "VACANT": return "Vacant";
      default: return "All";
    }
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, String filterType) {
    final bool isSelected = _selectedFilterStatus == filterType;
    return InkWell(
      onTap: () => setState(() => _selectedFilterStatus = filterType),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? color : const Color(0xFFE2E8F0), width: isSelected ? 2.0 : 1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 16, backgroundColor: color.withValues(alpha: 0.15), child: Icon(icon, color: color, size: 18)),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filter Students By Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: ["ALL", "ACTIVE", "INACTIVE", "VACANT"].map((status) {
                  final isSelected = _selectedFilterStatus == status;
                  return ChoiceChip(
                    label: Text(status),
                    selected: isSelected,
                    selectedColor: const Color(0xFF2563EB),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilterStatus = status);
                        Navigator.pop(context);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    bool isActive = (student['status']?.toString().toUpperCase() ?? 'ACTIVE') == "ACTIVE";
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(student['image_url'] ?? 'https://i.pravatar.cc/100?img=12')
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(student['name'] ?? 'Unknown', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  Text("ID: ${student['id']}", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("ROOM", style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                Text(student['room_no'] ?? 'N/A', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("COURSE", style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold)),
                Text(student['course'] ?? 'N/A', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              ]),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              student['status'] ?? 'Active',
              style: TextStyle(
                fontSize: 11,
                color: isActive ? const Color(0xFF166534) : const Color(0xFF64748B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: const [
          Icon(Icons.grid_view_rounded, color: Color(0xFF2563EB)),
          SizedBox(width: 8),
          Text(
            "Student Management",
            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Color(0xFF2563EB)),
          onPressed: _fetchStudentsData,
          tooltip: "Refresh Data",
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF047857)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.account_tree_outlined, color: Color(0xFF64748B)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.insert_chart_outlined, color: Color(0xFF64748B)), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline, color: Color(0xFF64748B)), onPressed: () {}),
        ],
      ),
    );
  }
}