import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chatroom_screen.dart';

class CommunityScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const CommunityScreen({super.key, required this.userId, required this.userName});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedCategory = "All";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  Timer? _refreshTimer;

  List<dynamic> _allGroups = [];
  int _userCoins = 0;
  bool _isLoading = true;

  // Sahi Base URL jiske aage endpoints judege
  final String baseUrl = "https://startupsgo.tech/";

  @override
  void initState() {
    super.initState();
    _fetchCommunityData();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) _fetchCommunityData(silent: true);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCommunityData({bool silent = false}) async {
    if (!silent) setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}get_groups.php"),
        body: jsonEncode({"user_id": widget.userId}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          setState(() {
            _allGroups = data["groups"] ?? [];
            _userCoins = int.tryParse(data["coins"].toString()) ?? 0;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (!silent) setState(() => _isLoading = false);
    }
  }

  void _showCreateGroupDialog(BuildContext context) {
    final TextEditingController groupNameController = TextEditingController();
    final TextEditingController motiveController = TextEditingController();
    final TextEditingController limitController = TextEditingController(text: "50");
    String selectedCategory = "Study";
    bool isCreating = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              title: const Text("Create New Group", style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: groupNameController, decoration: const InputDecoration(labelText: "Group Name")),
                    const SizedBox(height: 12),
                    TextField(controller: motiveController, decoration: const InputDecoration(labelText: "Motive")),
                    const SizedBox(height: 12),
                    TextField(controller: limitController, decoration: const InputDecoration(labelText: "Member Limit"), keyboardType: TextInputType.number),
                    const SizedBox(height: 16),
                    const Text("Select Category:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Wrap(
                      spacing: 8,
                      children: ["Study", "Programming", "Gaming", "Music", "Sports"].map((cat) {
                        bool isSelected = selectedCategory == cat;
                        return ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: const Color(0xFF8B5CF6),
                          onSelected: (selected) => setDialogState(() => selectedCategory = cat),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
                  onPressed: isCreating ? null : () async {
                    if (groupNameController.text.isNotEmpty) {
                      setDialogState(() => isCreating = true);
                      try {
                        final response = await http.post(
                          Uri.parse("https://startupsgo.tech/create_group.php"),
                          headers: {"Content-Type": "application/json"},
                          body: jsonEncode({
                            "title": groupNameController.text.trim(),
                            "admin_name": widget.userName,
                            "admin_id": widget.userId,
                            "desc": motiveController.text.trim().isNotEmpty ? motiveController.text.trim() : "Discussion group",
                            "tag": selectedCategory,
                            "limit": int.tryParse(limitController.text) ?? 50,
                          }),
                        );

                        final resData = jsonDecode(response.body);
                        if (resData["status"] == "success") {
                          if (context.mounted) Navigator.pop(context);
                          _fetchCommunityData();
                        } else {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resData["message"] ?? "Error")));
                        }
                      } catch (e) {
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                      } finally {
                        setDialogState(() => isCreating = false);
                      }
                    }
                  },
                  child: isCreating ? const CircularProgressIndicator(color: Colors.white) : const Text("Create", style: TextStyle(color: Colors.white)),
                )
              ],
            );
          },
        );
      },
    );
  }

  void _showJoinGroupsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(color: Color(0xFFF8F9FA), borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Explore Communities", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _allGroups.length,
                  itemBuilder: (context, index) {
                    final group = _allGroups[index];
                    final bool isJoined = group["is_joined"] == true;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.groups_rounded, color: Color(0xFF8B5CF6), size: 26),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Text(
                                      group["tag"] ?? "Group",
                                      style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(group["title"] ?? "Unnamed Group", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                                Text(group["description"] ?? "", maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isJoined ? const Color(0xFF00C853) : const Color(0xFF8B5CF6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: isJoined ? null : () async {
                              try {
                                final response = await http.post(
                                  Uri.parse("${baseUrl}join_group.php"),
                                  headers: {"Content-Type": "application/json"},
                                  body: jsonEncode({
                                    "user_id": widget.userId,
                                    "group_id": group["id"].toString(),
                                  }),
                                );

                                final resData = jsonDecode(response.body);
                                if (resData["status"] == "success") {
                                  _fetchCommunityData();
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(resData["message"] ?? "Joined successfully!"),
                                        backgroundColor: const Color(0xFFF59E0B),
                                      ),
                                    );
                                  }
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error joining: $e")));
                                }
                              }
                            },
                            child: Text(isJoined ? "Joined" : "Join", style: const TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openChatRoom(BuildContext context, String groupId, String groupName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomPage(
          groupId: groupId,
          groupName: groupName,
          userId: widget.userId,
          userName: widget.userName,
        ),
      ),
    );
  }

  String _getRemainingTime(String? createdAtStr) {
    if (createdAtStr == null) return "24h 0m left";
    try {
      final DateTime createdAt = DateTime.parse(createdAtStr);
      final DateTime expiryTime = createdAt.add(const Duration(hours: 24));
      final Duration remaining = expiryTime.difference(DateTime.now());
      if (remaining.isNegative) return "Expired";
      return "${remaining.inHours}h ${remaining.inMinutes % 60}m left";
    } catch (_) {
      return "24h left";
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _allGroups.where((group) {
      final String? createdAtStr = group["created_at"];
      bool isAlive = true;
      if (createdAtStr != null) {
        try {
          final DateTime createdAt = DateTime.parse(createdAtStr);
          isAlive = DateTime.now().difference(createdAt).inHours < 24;
        } catch (_) {}
      }
      bool matchesCategory = _selectedCategory == "All" || group["tag"] == _selectedCategory;
      bool matchesSearch = _searchQuery.isEmpty || group["title"].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return isAlive && matchesCategory && matchesSearch;
    }).toList();

    final myGroups = filtered.where((group) => group["admin_id"].toString() == widget.userId.toString()).toList();
    final joinedGroups = filtered.where((group) => group["is_joined"] == true && group["admin_id"].toString() != widget.userId.toString()).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6)))
            : SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Community", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("Discover & Earn Coins", style: TextStyle(fontSize: 12, color: Colors.grey))
                      ]
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber.withValues(alpha: 0.3))
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text("$_userCoins", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: const InputDecoration(hintText: "Search active groups...", border: InputBorder.none, prefixIcon: Icon(Icons.search))
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ["All", "Study", "Programming", "Gaming", "Music", "Sports"].map((cat) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: _selectedCategory == cat,
                      selectedColor: const Color(0xFF8B5CF6),
                      labelStyle: TextStyle(color: _selectedCategory == cat ? Colors.white : Colors.black87),
                      onSelected: (selected) => setState(() => _selectedCategory = cat),
                    ),
                  )).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildActionCard("Create Group", Icons.group_add, const Color(0xFF8B5CF6), () => _showCreateGroupDialog(context)),
                  const SizedBox(width: 16),
                  _buildActionCard("Join Groups", Icons.groups, const Color(0xFF06B6D4), () => _showJoinGroupsBottomSheet(context))
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (myGroups.isNotEmpty) ...[
                    const Text("My Groups", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...myGroups.map((group) => _buildGroupTile(group))
                  ],
                  const SizedBox(height: 20),
                  if (joinedGroups.isNotEmpty) ...[
                    const Text("Joined Communities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...joinedGroups.map((group) => _buildGroupTile(group))
                  ],
                  if (myGroups.isEmpty && joinedGroups.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text("No groups found. Create or join one!", style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupTile(dynamic group) {
    final String timeLeft = _getRemainingTime(group["created_at"]);
    final String tag = group["tag"] ?? "Discussion";
    final String admin = group["admin_name"] ?? "HostelMate";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4)
            )
          ]
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.forum_rounded, color: Color(0xFF8B5CF6), size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
                    ),
                    const SizedBox(width: 8),
                    Text("Admin: $admin", style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(group["title"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF191C1D))),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 12, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(timeLeft, style: const TextStyle(fontSize: 11, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () => _openChatRoom(context, group["id"].toString(), group["title"] ?? "Chat"),
            child: const Text("Enter", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
            ],
          ),
        ),
      ),
    );
  }
}