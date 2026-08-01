import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BroadcastScreen(),
    );
  }
}

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  // State variables
  String selectedAudience = "All Students";
  bool appPush = true;
  bool email = false;
  String selectedPriority = "Standard Notification";
  int _currentIndex = 1;

  final TextEditingController _messageController = TextEditingController();

  void _showSnackBar(String message, {Color color = Colors.black87}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  // Formatting actions (Bold, Italic, etc.)
  void _applyFormatting(String formatType) {
    final text = _messageController.text;
    final selection = _messageController.selection;

    if (selection.isValid && !selection.isCollapsed) {
      String selectedText = selection.textInside(text);
      String formattedText = "";

      if (formatType == "B") {
        formattedText = "**$selectedText**";
      } else if (formatType == "I") {
        formattedText = "_${selectedText}_";
      } else if (formatType == "Link") {
        formattedText = "[$selectedText](https://hostelmate.com)";
      }

      final newText = text.replaceRange(selection.start, selection.end, formattedText);
      _messageController.text = newText;
      _showSnackBar("Applied $formatType formatting");
    } else {
      // If no text is highlighted, append at cursor or end
      String addition = "";
      if (formatType == "B") addition = "**Bold Text**";
      if (formatType == "I") addition = "_Italic Text_";
      if (formatType == "List") addition = "\n• List item";
      if (formatType == "Link") addition = "[Link Text](https://hostelmate.com)";
      if (formatType == "Emoji") addition = " 🍰🎉";
      if (formatType == "Image") addition = " [Attached Image]";

      _messageController.text += addition;
      _showSnackBar("Added $formatType");
    }
  }

  // Send Broadcast Action
  void _sendBroadcast() {
    if (_messageController.text.trim().isEmpty) {
      _showSnackBar("Please write a message content first!", color: Colors.red);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Broadcast"),
        content: Text("Send this message to '$selectedAudience' via ${appPush && email ? 'App Push & Email' : appPush ? 'App Push' : 'Email'}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar("Broadcast successfully sent to $selectedAudience!", color: Colors.green);
              _messageController.clear();
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2563EB)),
            child: const Text("Confirm & Send", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "HostelMate Kitchen",
                style: TextStyle(color: Color(0xFF0F2C59), fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black87),
              onPressed: () => _showSnackBar("Notification panel opened"),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Title & Description
          const Text(
            "Broadcast Announcement",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59)),
          ),
          const SizedBox(height: 4),
          const Text(
            "Update students about menu changes, delays, or special surprises instantly.",
            style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.3),
          ),
          const SizedBox(height: 16),

          // Main White Container Form
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Target Audience Section
                Row(
                  children: const [
                    Icon(Icons.people_outline, size: 14, color: Color(0xFF1E3A8A)),
                    SizedBox(width: 6),
                    Text("TARGET AUDIENCE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                  ],
                ),
                const SizedBox(height: 10),
                
                // Clickable Target Audience Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _audienceChip("All Students", Icons.check),
                    _audienceChip("Vegetarian Only", Icons.eco_outlined),
                    _audienceChip("Hostel Block A", Icons.apartment),
                    _audienceChip("Hostel Block B", Icons.apartment),
                  ],
                ),
                const SizedBox(height: 20),

                // Message Content Section
                Row(
                  children: const [
                    Icon(Icons.edit_outlined, size: 14, color: Color(0xFF1E3A8A)),
                    SizedBox(width: 6),
                    Text("MESSAGE CONTENT", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                  ],
                ),
                const SizedBox(height: 10),

                // Rich Text Area Container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: [
                      // Clickable Formatting Toolbar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FF),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => _applyFormatting("B"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("B", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => _applyFormatting("I"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("I", style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 14)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(height: 16, width: 1, color: Colors.grey.shade300),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => _applyFormatting("List"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.format_list_bulleted, size: 16, color: Colors.black87),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => _applyFormatting("Link"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.link, size: 16, color: Colors.black87),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => _applyFormatting("Emoji"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.sentiment_satisfied_outlined, size: 18, color: Colors.black54),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => _applyFormatting("Image"),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.image_outlined, size: 18, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text Field Input
                      TextField(
                        controller: _messageController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Write your announcement here...\n(e.g., 'Fresh chocolate lava cakes are being served now! 🍰')",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                          contentPadding: EdgeInsets.all(12),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Priority Level Section
                const Text("PRIORITY LEVEL", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedPriority,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: "Standard Notification", child: Text("Standard Notification", style: TextStyle(fontSize: 13))),
                        DropdownMenuItem(value: "High Priority", child: Text("High Priority", style: TextStyle(fontSize: 13))),
                        DropdownMenuItem(value: "Emergency Alert", child: Text("Emergency Alert", style: TextStyle(fontSize: 13))),
                      ],
                      onChanged: (val) {
                        setState(() {
                          selectedPriority = val!;
                        });
                        _showSnackBar("Priority set to: $selectedPriority");
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Notification Channel Section
                const Text("NOTIFICATION CHANNEL", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: appPush,
                          activeColor: const Color(0xFF2563EB),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) {
                            setState(() => appPush = val ?? true);
                            _showSnackBar("App Push channel: ${appPush ? 'Enabled' : 'Disabled'}");
                          },
                        ),
                        const Text("App Push", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: email,
                          activeColor: const Color(0xFF2563EB),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) {
                            setState(() => email = val ?? false);
                            _showSnackBar("Email channel: ${email ? 'Enabled' : 'Disabled'}");
                          },
                        ),
                        const Text("Email", style: TextStyle(fontSize: 13, color: Colors.black87)),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, thickness: 1, color: Color(0xFFF0F2F5)),
                ),

                // Discard & Send Broadcast Action Buttons
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _messageController.clear();
                        });
                        _showSnackBar("Form content cleared / discarded", color: Colors.red);
                      },
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                      label: const Text("Discard", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _sendBroadcast,
                        icon: const Icon(Icons.send, size: 16, color: Colors.white),
                        label: const Text("Send Broadcast", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Recent Broadcasts Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("RECENT BROADCASTS ($selectedAudience)", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F2C59), letterSpacing: 0.5)),
              GestureDetector(
                onTap: () => _showSnackBar("Opening full broadcast history report..."),
                child: const Text("View History", style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Clickable Recent Broadcast Card 1
          InkWell(
            onTap: () => _showSnackBar("Opening details for: Dinner Delay Broadcast"),
            borderRadius: BorderRadius.circular(16),
            child: _broadcastHistoryCard(
              icon: Icons.timer_outlined,
              iconBg: Colors.green.shade100,
              iconColor: Colors.green.shade800,
              title: "Dinner Delay: 30 Mins",
              time: "2h ago",
              desc: "Apologies, dinner will be served at 8:30 PM tonight due to a gas supply maintenance.",
              reads: "452 reads",
              target: "Target: $selectedAudience",
            ),
          ),
          const SizedBox(height: 12),

          // Clickable Recent Broadcast Card 2
          InkWell(
            onTap: () => _showSnackBar("Opening details for: Special Sunday Brunch Broadcast"),
            borderRadius: BorderRadius.circular(16),
            child: _broadcastHistoryCard(
              icon: Icons.celebration_outlined,
              iconBg: Colors.orange.shade100,
              iconColor: Colors.orange.shade800,
              title: "Special Sunday Brunch",
              time: "Yesterday",
              desc: "Get ready for Pancakes and Fresh Berry Compote tomorrow morning!",
              reads: "891 reads",
              target: "Target: $selectedAudience",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006E2F),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
          String tabName = ["Dashboard", "Menu", "Complaints", "Profile"][index];
          _showSnackBar("Navigated to $tabName tab");
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.report_problem_outlined), label: "Complaints"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _audienceChip(String label, IconData icon) {
    bool isSelected = selectedAudience == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAudience = label;
        });
        _showSnackBar("Target Audience changed to: $label");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2563EB) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check : icon, 
              size: 14, 
              color: isSelected ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _broadcastHistoryCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required String desc,
    required String reads,
    required String target,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 10),
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.black87, height: 1.3)),
          const SizedBox(height: 12),
          Row(
            children: [
              Row(
                children: [
                  const Icon(Icons.remove_red_eye_outlined, size: 14, color: Color(0xFF2563EB)),
                  const SizedBox(width: 4),
                  Text(reads, style: const TextStyle(color: Color(0xFF2563EB), fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(width: 16),
              Text(target, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}