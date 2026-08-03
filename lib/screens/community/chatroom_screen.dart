import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatRoomPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userId;
  final String userName;

  const ChatRoomPage({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.userId,
    required this.userName,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController _messageController = TextEditingController();
  List<dynamic> _messages = [];
  int _memberCount = 0;
  bool _isLoading = true;
  Timer? _refreshTimer;
  final String baseUrl = "https://startupsgo.tech/";

  @override
  void initState() {
    super.initState();
    _fetchChatData();
    _refreshTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchChatData(silent: true);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchChatData({bool silent = false}) async {
    if (!silent) setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}get_messages.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"group_id": widget.groupId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          setState(() {
            _messages = data["messages"] ?? [];
            _memberCount = data["member_count"] ?? 1;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (!silent) setState(() => _isLoading = false);
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final String text = _messageController.text.trim();
      _messageController.clear();

      try {
        final response = await http.post(
          Uri.parse("${baseUrl}send_message.php"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "group_id": widget.groupId,
            "sender_id": widget.userId,
            "sender_name": widget.userName,
            "message": text,
          }),
        );

        final resData = jsonDecode(response.body);
        if (resData["status"] == "success") {
          _fetchChatData(silent: true);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resData["message"] ?? "Failed to send")));
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
        }
      }
    }
  }

  void _exitGroup() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit Group"),
        content: const Text("Are you sure you want to leave this group? You will need to join again to enter."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              try {
                final response = await http.post(
                  Uri.parse("${baseUrl}leave_group.php"),
                  headers: {"Content-Type": "application/json"},
                  body: jsonEncode({
                    "user_id": widget.userId,
                    "group_id": widget.groupId,
                  }),
                );
                final resData = jsonDecode(response.body);
                if (resData["status"] == "success") {
                  if (mounted) {
                    Navigator.pop(context, true); // Pop and signal to refresh community screen
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resData["message"] ?? "Could not leave")));
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              }
            },
            child: const Text("Exit", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8B5CF6);

    return Scaffold(
      backgroundColor: primaryPurple,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.groupName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("$_memberCount members joined", style: const TextStyle(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                    onPressed: _exitGroup,
                  ),
                ],
              ),
            ),

            // Chat Body
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "⚠️ This group and all messages will be automatically deleted 24 hours after creation.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(indent: 40, endIndent: 40, thickness: 0.5),

                    Expanded(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator(color: primaryPurple))
                          : _messages.isEmpty
                          ? const Center(child: Text("No messages yet. Say hello!", style: TextStyle(color: Colors.grey)))
                          : ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          bool isMe = msg["sender_id"].toString() == widget.userId.toString();

                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                              decoration: BoxDecoration(
                                color: isMe ? primaryPurple : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isMe)
                                    Text(msg["sender_name"] ?? "User", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryPurple)),
                                  Text(msg["message"] ?? "", style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Input Bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          FloatingActionButton(
                            onPressed: _sendMessage,
                            mini: true,
                            backgroundColor: primaryPurple,
                            child: const Icon(Icons.send, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}