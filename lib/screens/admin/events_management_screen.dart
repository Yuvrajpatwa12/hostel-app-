import 'package:flutter/material.dart';
import 'api_service.dart';
import 'create_event_screen.dart';

class EventsManagementScreen extends StatefulWidget {
  const EventsManagementScreen({super.key});

  @override
  State<EventsManagementScreen> createState() => _EventsManagementScreenState();
}

class _EventsManagementScreenState extends State<EventsManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _allEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchEventsData();
  }

  Future<void> _fetchEventsData() async {
    setState(() => _isLoading = true);
    try {
      final events = await ApiService.fetchEvents();
      setState(() {
        _allEvents = events;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching events: $e");
      setState(() => _isLoading = false);
    }
  }

  List<dynamic> _getEventsByStatus(String status) {
    return _allEvents.where((e) => e['status'].toString().toLowerCase() == status.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Events Management", style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Color(0xFF1E3A8A)), onPressed: _fetchEventsData),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF1E3A8A),
                  unselectedLabelColor: const Color(0xFF64748B),
                  indicatorColor: const Color(0xFF1E3A8A),
                  tabs: const [Tab(text: "Upcoming"), Tab(text: "Ongoing"), Tab(text: "Past")],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildEventList("Upcoming"),
                      _buildEventList("Ongoing"),
                      _buildEventList("Past"),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateEventScreen()));
          if (res == true) _fetchEventsData();
        },
        backgroundColor: const Color(0xFF003399),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEventList(String status) {
    final events = _getEventsByStatus(status);
    if (events.isEmpty) return const Center(child: Text("No events found."));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _buildEventCard(event);
      },
    );
  }

  Widget _buildEventCard(dynamic event) {
    final int joined = int.tryParse(event['joined_count']?.toString() ?? '0') ?? 0;
    final int max = int.tryParse(event['max_capacity']?.toString() ?? '100') ?? 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (event['image_url'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(event['image_url'], height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['event_date'] ?? '', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                const SizedBox(height: 4),
                Text(event['title'] ?? 'No Title', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                Text(event['location'] ?? 'No Location', style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: joined / max, backgroundColor: const Color(0xFFEEF2FF), color: const Color(0xFF1E3A8A), minHeight: 6, borderRadius: BorderRadius.circular(10)),
                const SizedBox(height: 4),
                Text("$joined / $max Joined", style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
