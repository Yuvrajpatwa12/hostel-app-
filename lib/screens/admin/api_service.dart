import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Yahan apna Hostinger domain aur folder path dalein
  static const String baseUrl = "https://startupsgo.tech/api";

  // 1. Dashboard Stats
  static Future<Map<String, dynamic>> fetchDashboardStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_dashboard_stats.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['data'] : {};
      }
    } catch (e) {
      // avoid_print handled by not using it in production, but keeping it for now as per user code style
      print("Error Stats: $e");
    }
    return {};
  }

  // 2. Students List
  static Future<List<dynamic>> fetchStudents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_students.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['students'] : [];
      }
    } catch (e) {
      print("Error Students: $e");
    }
    return [];
  }

  // 3. Complaints List
  static Future<List<dynamic>> fetchComplaints() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_complaints.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['complaints'] : [];
      }
    } catch (e) {
      print("Error Complaints: $e");
    }
    return [];
  }

  // 4. Recent Activities
  static Future<List<dynamic>> fetchActivities() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_activities.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['activities'] : [];
      }
    } catch (e) {
      print("Error Activities: $e");
    }
    return [];
  }

  // 5. Rooms List
  static Future<List<dynamic>> fetchRooms() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_rooms.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['rooms'] : [];
      }
    } catch (e) {
      print("Error Rooms: $e");
    }
    return [];
  }

  // 6. Notices List
  static Future<List<dynamic>> fetchNotices() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_notices.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['notices'] : [];
      }
    } catch (e) {
      print("Error Notices: $e");
    }
    return [];
  }

  // 7. Weekly Menu
  static Future<List<dynamic>> fetchMenu() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_menu.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['menu'] : [];
      }
    } catch (e) {
      print("Error Menu: $e");
    }
    return [];
  }

  // 8. Events List
  static Future<List<dynamic>> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_events.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['events'] : [];
      }
    } catch (e) {
      print("Error Events: $e");
    }
    return [];
  }

  // 9. Recipes List
  static Future<List<dynamic>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_recipes.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['recipes'] : [];
      }
    } catch (e) {
      print("Error Recipes: $e");
    }
    return [];
  }

  // 10. Add New Room
  static Future<Map<String, dynamic>> addRoom(Map<String, dynamic> roomData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_room.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(roomData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Add Room: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 11. Update Room
  static Future<Map<String, dynamic>> updateRoom(Map<String, dynamic> roomData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_room.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(roomData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Update Room: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 12. Delete Room
  static Future<Map<String, dynamic>> deleteRoom(String roomNo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_room.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"room_no": roomNo}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Delete Room: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 13. Submit Detailed Booking (User)
  static Future<Map<String, dynamic>> bookRoom(Map<String, dynamic> bookingData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/book_room.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bookingData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Book Room: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 14. Fetch User's Booking Status
  static Future<Map<String, dynamic>> fetchBookingStatus(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_booking_status.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Fetch Status: $e");
    }
    return {"success": false, "status": "None"};
  }

  // 15. Fetch All Bookings (Admin)
  static Future<List<dynamic>> fetchAllBookings() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_all_bookings.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['bookings'] : [];
      }
    } catch (e) {
      print("Error Fetch Bookings: $e");
    }
    return [];
  }

  // 16. Update Booking Status (Admin)
  static Future<Map<String, dynamic>> updateBookingStatus(int bookingId, String status, String roomNo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_booking_status.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "booking_id": bookingId,
          "status": status,
          "room_no": roomNo,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Update Status: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 17. Fetch Referral Info (User)
  static Future<Map<String, dynamic>> fetchReferralInfo(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_referral_info.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Fetch Referral: $e");
    }
    return {"success": false, "code": "ERROR", "points": 0};
  }

  // 18. Redeem Reward (User)
  static Future<Map<String, dynamic>> redeemReward(String userId, int points) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/redeem_reward.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "points": points,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Redeem: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 19. Invite Friend (Referral System)
  static Future<Map<String, dynamic>> inviteFriend(String userId, String email, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/invite_friend.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "friend_email": email,
          "friend_phone": phone,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Invite: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 20. Apply Referral Code (User)
  static Future<Map<String, dynamic>> applyReferralCode(String userId, String code) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/apply_referral_code.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "referral_code": code,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Apply Code: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 21. Fetch Pending Referrals (Admin)
  static Future<List<dynamic>> fetchPendingReferrals() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_pending_referrals.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true ? data['referrals'] : [];
      }
    } catch (e) {
      print("Error Fetch Referrals: $e");
    }
    return [];
  }

  // 22. Approve Referral Reward (Admin)
  static Future<Map<String, dynamic>> approveReferralReward(int referralId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/approve_referral_reward.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"referral_id": referralId}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Approve Referral: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 23. Fetch Fee Status (Student)
  static Future<Map<String, dynamic>> fetchFeeStatus(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_fee_status.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"user_id": userId}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Fetch Fee: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 24. Collect Fee (Admin)
  static Future<Map<String, dynamic>> collectFee(Map<String, dynamic> feeData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin_collect_fee.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(feeData),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Collect Fee: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }

  // 25. Search Student by Email (Admin)
  static Future<Map<String, dynamic>> searchStudentByEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/search_student.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error Search Student: $e");
    }
    return {"success": false, "message": "Connection Error"};
  }
}
