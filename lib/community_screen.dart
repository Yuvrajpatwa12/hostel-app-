import 'package:flutter/material.dart';
import 'chatroom_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  String _selectedCategory = "All";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _myCreatedGroups = [];

  final List<Map<String, dynamic>> _allPublicGroups = [
    {
      "title": "Late Night Coders",
      "admin": "Alex",
      "desc": "Study and code together till late night.",
      "tag": "Programming",
      "members": "1.2k members",
      "limit": "2000",
      "isJoined": false,
      "isCreatedByMe": false,
    },
    {
      "title": "Pixel Warriors",
      "admin": "David",
      "desc": "Gaming squad for weekend tournaments.",
      "tag": "Gaming",
      "members": "856 members",
      "limit": "1000",
      "isJoined": false,
      "isCreatedByMe": false,
    },
    {
      "title": "Hostel Melodies",
      "admin": "Sam",
      "desc": "Sharing the best acoustic sessions and guitar riffs.",
      "tag": "Music",
      "members": "420 members",
      "limit": "500",
      "isJoined": false,
      "isCreatedByMe": false,
    },
    {
      "title": "Weekend Strikers",
      "admin": "John",
      "desc": "Weekly football and basketball matches.",
      "tag": "Sports",
      "members": "310 members",
      "limit": "400",
      "isJoined": false,
      "isCreatedByMe": false,
    },
  ];

  void _showCreateGroupDialog(BuildContext context) {
    if (_myCreatedGroups.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can only create one group as per guidelines!")),
      );
      return;
    }

    final TextEditingController userNameController = TextEditingController();
    final TextEditingController groupNameController = TextEditingController();
    final TextEditingController motiveController = TextEditingController();
    final TextEditingController limitController = TextEditingController(text: "50");
    String selectedCategory = "Study";

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(labelText: "Your Name", hintText: "Enter your name"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(labelText: "Group Name", hintText: "e.g., Physics Hackers"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: motiveController,
                      decoration: const InputDecoration(labelText: "Motive / Description", hintText: "What is this group about?"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: limitController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Member Limit", hintText: "Max members allowed"),
                    ),
                    const SizedBox(height: 16),
                    const Text("Select Character / Category:", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF414754))),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ["Study", "Programming", "Gaming", "Music", "Sports"].map((cat) {
                        bool isSelected = selectedCategory == cat;
                        return ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: const Color(0xFF8B5CF6),
                          labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xFF414754)),
                          onSelected: (selected) {
                            setDialogState(() {
                              selectedCategory = cat;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6)),
                  onPressed: () {
                    if (groupNameController.text.isNotEmpty && userNameController.text.isNotEmpty) {
                      setState(() {
                        _myCreatedGroups.add({
                          "title": groupNameController.text,
                          "admin": userNameController.text,
                          "desc": motiveController.text.isNotEmpty ? motiveController.text : "Discussion group",
                          "tag": selectedCategory,
                          "members": "1 member",
                          "limit": limitController.text,
                          "isJoined": true,
                          "isCreatedByMe": true,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Create Group", style: TextStyle(color: Colors.white)),
                ),
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
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Explore & Join Groups",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Join unlimited public groups to start chatting.",
                    style: TextStyle(fontSize: 12, color: Color(0xFF414754)),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _allPublicGroups.length,
                      itemBuilder: (context, index) {
                        final group = _allPublicGroups[index];
                        bool isJoined = group["isJoined"] ?? false;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(Icons.groups, color: Color(0xFF8B5CF6), size: 26),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(group["title"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                                    const SizedBox(height: 2),
                                    Text(group["desc"], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF414754))),
                                    const SizedBox(height: 6),
                                    Text("Admin: ${group["admin"]} • ${group["members"]}", style: const TextStyle(fontSize: 10, color: Color(0xFF8B5CF6), fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isJoined ? const Color(0xFF00C853) : const Color(0xFF8B5CF6),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                ),
                                onPressed: () {
                                  setState(() {
                                    group["isJoined"] = !isJoined;
                                  });
                                  setModalState(() {});
                                },
                                child: Text(
                                  isJoined ? "Joined" : "Join",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
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
      },
    );
  }

  void _openChatRoom(BuildContext context, String groupName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomPage(groupName: groupName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool matchesFilter(Map<String, dynamic> group) {
      bool matchesCategory = _selectedCategory == "All" || group["tag"] == _selectedCategory;
      bool matchesSearch = _searchQuery.isEmpty ||
          group["title"].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          group["desc"].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          group["tag"].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }

    List<Map<String, dynamic>> filteredCreatedGroups = _myCreatedGroups.where(matchesFilter).toList();
    List<Map<String, dynamic>> joinedPublicGroups = _allPublicGroups.where((g) => g["isJoined"] == true).toList();
    List<Map<String, dynamic>> filteredJoinedGroups = joinedPublicGroups.where(matchesFilter).toList();
    List<Map<String, dynamic>> filteredExploreGroups = _allPublicGroups.where(matchesFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuAbX5xhVcHns3u3ZBM7F8kIW8VUYob51Y3ET-K1fLZjtnlUG05Wmh2Zvld_LRSpDuFIR-cq4x4pcbulRsKe2pSPmplPmVue92_PM3_jf19tmTaQJXmNeDaUVWJtfc7MuB0f66JHaAVTK46Wi0PIul9bc3vg7WrwEOALGBXK-q5FOc3B5lp_Q9ApKOWMmHoTfOm9kq5yUZL83UIUM-jISz7OQOf2kePcy8AIhnS5GEnKtjg0MCNh_qGM',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF191C1D)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Discover, Chat & Connect",
                            style: TextStyle(fontSize: 12, color: Color(0xFF414754), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF414754)),
                            onPressed: () {},
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBA1A1A),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4)),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search groups by name, tag or topic...",
                    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF414754)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF8B5CF6)),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear, color: Color(0xFF414754)),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = "";
                        });
                      },
                    )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Top Gradient Banner (Height choti kardi gayi hai: 120)
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFC084FC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 4)),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Stack(
                  children: [
                    Positioned(
                      right: -10,
                      top: -10,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome to Hostel Community",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Join discussions, meet new students & explore.",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                    const Positioned(
                      right: 12,
                      bottom: 4,
                      child: Icon(Icons.forum, size: 55, color: Colors.white24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Actions Row
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      context,
                      "Create Group",
                      "Only one group can be created by each student.",
                      Icons.group_add,
                      const Color(0xFF8B5CF6),
                          () => _showCreateGroupDialog(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildQuickActionCard(
                      context,
                      "Join Groups",
                      "Join unlimited public and private groups.",
                      Icons.groups,
                      const Color(0xFF06B6D4),
                          () => _showJoinGroupsBottomSheet(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Categories Horizontal Scroll Filter
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip("All"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Study"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Programming"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Gaming"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Music"),
                    const SizedBox(width: 8),
                    _buildCategoryChip("Sports"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 1. Created Group Section
              if (filteredCreatedGroups.isNotEmpty) ...[
                const Text(
                  "Created Group",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
                ),
                const SizedBox(height: 12),
                ...filteredCreatedGroups.map((group) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.admin_panel_settings, color: Color(0xFF8B5CF6), size: 26),
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
                                      color: const Color(0xFF8B5CF6).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: Text(group["tag"]!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("Admin: ${group["admin"]!}", style: const TextStyle(fontSize: 10, color: Color(0xFF414754))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(group["title"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                              const SizedBox(height: 2),
                              Text(group["desc"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF414754))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          onPressed: () => _openChatRoom(context, group["title"]!),
                          child: const Text("Enter", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 20),
              ],

              // 2. Joined Groups Section
              if (filteredJoinedGroups.isNotEmpty) ...[
                const Text(
                  "Joined Groups",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
                ),
                const SizedBox(height: 12),
                ...filteredJoinedGroups.map((group) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C853).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.forum, color: Color(0xFF00C853), size: 26),
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
                                      color: const Color(0xFF00C853).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(99),
                                    ),
                                    child: Text(group["tag"]!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("Admin: ${group["admin"]!}", style: const TextStyle(fontSize: 10, color: Color(0xFF414754))),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(group["title"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                              const SizedBox(height: 2),
                              Text(group["desc"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF414754))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C853),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          ),
                          onPressed: () => _openChatRoom(context, group["title"]!),
                          child: const Text("Enter", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                )),
                const SizedBox(height: 20),
              ],

              // 3. Explore Communities Section
              const Text(
                "Explore Communities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
              ),
              const SizedBox(height: 12),
              filteredExploreGroups.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text("No groups found matching your search.", style: TextStyle(color: Color(0xFF414754))),
                ),
              )
                  : Column(
                children: filteredExploreGroups.map((group) {
                  bool isJoined = group["isJoined"] ?? false;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B5CF6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.groups, color: Color(0xFF8B5CF6), size: 26),
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
                                        color: const Color(0xFF8B5CF6).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                      child: Text(group["tag"]!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
                                    ),
                                    const SizedBox(width: 8),
                                    Text("Admin: ${group["admin"]!}", style: const TextStyle(fontSize: 10, color: Color(0xFF414754))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(group["title"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
                                const SizedBox(height: 2),
                                Text(group["desc"]!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF414754))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isJoined ? Colors.grey : const Color(0xFF8B5CF6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            ),
                            onPressed: () {
                              setState(() {
                                group["isJoined"] = !isJoined;
                              });
                            },
                            child: Text(
                              isJoined ? "Joined" : "Join",
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Community Guidelines Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.1), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8B5CF6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.gavel, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Community Guidelines",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF191C1D)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _buildGuidelineItem("01", "Each student can create only one group"),
                    const SizedBox(height: 10),
                    _buildGuidelineItem("02", "Students can join unlimited groups"),
                    const SizedBox(height: 10),
                    _buildGuidelineItem("03", "Respect all members & foster positive chat"),
                    const SizedBox(height: 10),
                    _buildGuidelineItem("04", "No spam or abusive content allowed"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(BuildContext context, String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 125,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF191C1D))),
            const SizedBox(height: 2),
            Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Color(0xFF414754), height: 1.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4)),
          ],
          border: isSelected ? null : Border.all(color: const Color(0xFFC1C6D7).withOpacity(0.3)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF414754),
          ),
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String number, String text) {
    const Color primaryPurple = Color(0xFF8B5CF6);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: primaryPurple)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13, color: Color(0xFF414754), height: 1.3)),
        ),
      ],
    );
  }
}