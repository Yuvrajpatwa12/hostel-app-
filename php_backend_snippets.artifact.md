# PHP Backend Snippets for Kathmandu Hostel App

This artifact contains the complete set of 24 PHP backend files required for the Kathmandu Hostel management system, including dashboard statistics, room management, booking systems, referral programs, and fee management.

---

### 1. `api/db_connection.php`
```php
<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$host = "localhost";
$db_name = "hostel_db";
$username = "root";
$password = "";

$conn = new mysqli($host, $username, $password, $db_name);

if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}
?>
```

### 2. `api/get_dashboard_stats.php`
```php
<?php
include 'db_connection.php';

$stats = [];

$res = $conn->query("SELECT COUNT(*) as count FROM users WHERE role = 'student'");
$stats['total_students'] = $res->fetch_assoc()['count'];

$res = $conn->query("SELECT COUNT(*) as count FROM rooms");
$stats['total_rooms'] = $res->fetch_assoc()['count'];

$res = $conn->query("SELECT COUNT(*) as count FROM bookings WHERE status = 'Pending'");
$stats['pending_bookings'] = $res->fetch_assoc()['count'];

$res = $conn->query("SELECT COUNT(*) as count FROM complaints WHERE status = 'Open'");
$stats['open_complaints'] = $res->fetch_assoc()['count'];

echo json_encode($stats);
?>
```

### 3. `api/get_students.php`
```php
<?php
include 'db_connection.php';

$sql = "SELECT id, name, email, phone, reward_points FROM users WHERE role = 'student'";
$result = $conn->query($sql);

$students = [];
while($row = $result->fetch_assoc()) {
    $students[] = $row;
}

echo json_encode($students);
?>
```

### 4. `api/get_rooms.php`
```php
<?php
include 'db_connection.php';

$sql = "SELECT * FROM rooms";
$result = $conn->query($sql);

$rooms = [];
while($row = $result->fetch_assoc()) {
    $rooms[] = $row;
}

echo json_encode($rooms);
?>
```

### 5. `api/get_activities.php`
```php
<?php
include 'db_connection.php';

$sql = "SELECT * FROM activities ORDER BY date DESC LIMIT 10";
$result = $conn->query($sql);

$activities = [];
while($row = $result->fetch_assoc()) {
    $activities[] = $row;
}

echo json_encode($activities);
?>
```

### 6. `api/add_room.php`
```php
<?php
include 'db_connection.php';

$room_number = $_POST['room_number'];
$type = $_POST['type'];
$price = $_POST['price'];

$sql = "INSERT INTO rooms (room_number, type, price, status) VALUES ('$room_number', '$type', '$price', 'Available')";

if ($conn->query($sql)) {
    echo json_encode(["message" => "Room added successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
```

### 7. `api/update_room.php`
```php
<?php
include 'db_connection.php';

$id = $_POST['id'];
$room_number = $_POST['room_number'];
$type = $_POST['type'];
$price = $_POST['price'];
$status = $_POST['status'];

$sql = "UPDATE rooms SET room_number='$room_number', type='$type', price='$price', status='$status' WHERE id=$id";

if ($conn->query($sql)) {
    echo json_encode(["message" => "Room updated successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
```

### 8. `api/delete_room.php`
```php
<?php
include 'db_connection.php';

$id = $_POST['id'];
$sql = "DELETE FROM rooms WHERE id=$id";

if ($conn->query($sql)) {
    echo json_encode(["message" => "Room deleted successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
```

### 9. `api/book_room.php`
```php
<?php
include 'db_connection.php';

$user_id = $_POST['user_id'];
$room_id = $_POST['room_id'];
$booking_date = date('Y-m-d');

// Check for existing pending/approved booking
$check = $conn->query("SELECT id FROM bookings WHERE user_id=$user_id AND status != 'Cancelled'");
if ($check->num_rows > 0) {
    die(json_encode(["error" => "You already have an active booking"]));
}

$sql = "INSERT INTO bookings (user_id, room_id, status, booking_date) VALUES ($user_id, $room_id, 'Pending', '$booking_date')";

if ($conn->query($sql)) {
    echo json_encode(["message" => "Booking request submitted"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
```

### 10. `api/get_booking_status.php`
```php
<?php
include 'db_connection.php';

$user_id = $_GET['user_id'];
$sql = "SELECT b.*, r.room_number, r.type FROM bookings b JOIN rooms r ON b.room_id = r.id WHERE b.user_id = $user_id ORDER BY b.id DESC LIMIT 1";
$result = $conn->query($sql);

if ($row = $result->fetch_assoc()) {
    echo json_encode($row);
} else {
    echo json_encode(["status" => "No Booking"]);
}
?>
```

### 11. `api/get_all_bookings.php`
```php
<?php
include 'db_connection.php';

$sql = "SELECT b.*, u.name as student_name, r.room_number FROM bookings b
        JOIN users u ON b.user_id = u.id
        JOIN rooms r ON b.room_id = r.id
        ORDER BY b.booking_date DESC";
$result = $conn->query($sql);

$bookings = [];
while($row = $result->fetch_assoc()) {
    $bookings[] = $row;
}

echo json_encode($bookings);
?>
```

### 12. `api/update_booking_status.php`
```php
<?php
include 'db_connection.php';

$booking_id = $_POST['booking_id'];
$status = $_POST['status']; // e.g., 'Approved' or 'Rejected'

$sql = "UPDATE bookings SET status='$status' WHERE id=$booking_id";

if ($conn->query($sql)) {
    if ($status == 'Approved') {
        // Referral Step 4: Mark as Admitted
        $get_user = $conn->query("SELECT user_id FROM bookings WHERE id=$booking_id");
        $user_id = $get_user->fetch_assoc()['user_id'];

        $conn->query("UPDATE referrals SET status='Admitted' WHERE referee_id=$user_id AND status='Linked'");
    }
    echo json_encode(["message" => "Booking status updated"]);
} else {
    echo json_encode(["error" => $conn->error]);
}
?>
```

### 13. `api/get_referral_info.php`
```php
<?php
include 'db_connection.php';

$user_id = $_GET['user_id'];

// Get user points and code
$user_res = $conn->query("SELECT referral_code, reward_points FROM users WHERE id=$user_id");
$user_data = $user_res->fetch_assoc();

// Get referral history
$referrals_res = $conn->query("SELECT referee_email_or_phone, status FROM referrals WHERE referrer_id=$user_id");
$history = [];
while($row = $referrals_res->fetch_assoc()) {
    $history[] = $row;
}

echo json_encode([
    "referral_code" => $user_data['referral_code'],
    "reward_points" => $user_data['reward_points'],
    "history" => $history
]);
?>
```

### 14. `api/invite_friend.php`
```php
<?php
include 'db_connection.php';

$referrer_id = $_POST['referrer_id'];
$contact = $_POST['contact']; // Email or Phone

// Step 1: Create 'Invited' record
$sql = "INSERT INTO referrals (referrer_id, referee_email_or_phone, status) VALUES ($referrer_id, '$contact', 'Invited')";

if ($conn->query($sql)) {
    echo json_encode(["message" => "Invitation sent"]);
} else {
    echo json_encode(["error" => "Already invited or error"]);
}
?>
```

### 15. `api/apply_referral_code.php`
```php
<?php
include 'db_connection.php';

$user_id = $_POST['user_id'];
$code = $_POST['referral_code'];

// Find referrer
$res = $conn->query("SELECT id FROM users WHERE referral_code='$code'");
if ($res->num_rows > 0) {
    $referrer = $res->fetch_assoc();
    $referrer_id = $referrer['id'];

    // Step 3: Link referee and mark 'Linked'
    $update = "UPDATE referrals SET referee_id=$user_id, status='Linked'
               WHERE referrer_id=$referrer_id AND status='Joined'
               AND (referee_email_or_phone = (SELECT email FROM users WHERE id=$user_id)
                    OR referee_email_or_phone = (SELECT phone FROM users WHERE id=$user_id))";

    if ($conn->query($update) && $conn->affected_rows > 0) {
        echo json_encode(["message" => "Referral code applied successfully"]);
    } else {
        echo json_encode(["error" => "Invalid code or you were not invited by this user"]);
    }
} else {
    echo json_encode(["error" => "Invalid referral code"]);
}
?>
```

### 16. `api/get_pending_referrals.php`
```php
<?php
include 'db_connection.php';

// Admin view: Who reached 'Admitted' and needs reward points awarded
$sql = "SELECT r.id, u1.name as referrer_name, r.referee_email_or_phone as friend, r.status
        FROM referrals r
        JOIN users u1 ON r.referrer_id = u1.id
        WHERE r.status = 'Admitted' AND r.reward_awarded = 0";

$result = $conn->query($sql);
$pending = [];
while($row = $result->fetch_assoc()) {
    $pending[] = $row;
}

echo json_encode($pending);
?>
```

### 17. `api/approve_referral_reward.php`
```php
<?php
include 'db_connection.php';

$referral_id = $_POST['referral_id'];

// Award 100 points to the referrer
$res = $conn->query("SELECT referrer_id FROM referrals WHERE id=$referral_id");
$referrer_id = $res->fetch_assoc()['referrer_id'];

$conn->begin_transaction();
try {
    $conn->query("UPDATE users SET reward_points = reward_points + 100 WHERE id=$referrer_id");
    $conn->query("UPDATE referrals SET reward_awarded = 1 WHERE id=$referral_id");
    $conn->commit();
    echo json_encode(["message" => "100 Points awarded to referrer"]);
} catch (Exception $e) {
    $conn->rollback();
    echo json_encode(["error" => $e->getMessage()]);
}
?>
```

### 18. `api/redeem_reward.php`
```php
<?php
include 'db_connection.php';

$user_id = $_POST['user_id'];
$points_to_redeem = $_POST['points'];

$res = $conn->query("SELECT reward_points FROM users WHERE id=$user_id");
$current_points = $res->fetch_assoc()['reward_points'];

if ($current_points >= $points_to_redeem) {
    $conn->query("UPDATE users SET reward_points = reward_points - $points_to_redeem WHERE id=$user_id");
    echo json_encode(["message" => "Redeemed successfully"]);
} else {
    echo json_encode(["error" => "Insufficient points"]);
}
?>
```

### 19. `signup.php`
```php
<?php
include 'api/db_connection.php';

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);
$referral_code = strtoupper(substr(md5(uniqid()), 0, 8));

$sql = "INSERT INTO users (name, email, phone, password, referral_code, role)
        VALUES ('$name', '$email', '$phone', '$password', '$referral_code', 'student')";

if ($conn->query($sql)) {
    // Step 2: Auto-mark 'Joined' if email/phone was invited
    $conn->query("UPDATE referrals SET status='Joined' WHERE (referee_email_or_phone='$email' OR referee_email_or_phone='$phone') AND status='Invited'");

    echo json_encode(["message" => "User registered successfully"]);
} else {
    echo json_encode(["error" => "Registration failed: " . $conn->error]);
}
?>
```

### 20. `login.php`
```php
<?php
include 'api/db_connection.php';

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email='$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        unset($user['password']); // Don't return password hash
        echo json_encode(["message" => "Login successful", "user" => $user]);
    } else {
        echo json_encode(["error" => "Invalid password"]);
    }
} else {
    echo json_encode(["error" => "User not found"]);
}
?>
```

### 21. `api/get_complaints.php`
```php
<?php
include 'db_connection.php';

$sql = "SELECT c.*, u.name as student_name FROM complaints c JOIN users u ON c.user_id = u.id ORDER BY c.id DESC";
$result = $conn->query($sql);

$complaints = [];
while($row = $result->fetch_assoc()) {
    $complaints[] = $row;
}

echo json_encode($complaints);
?>
```

### 22. `api/get_fee_status.php`
```php
<?php
include 'db_connection.php';

$user_id = $_GET['user_id'];

// Fetch joining_date from users
$user_res = $conn->query("SELECT joining_date FROM users WHERE id = $user_id");
$user = $user_res->fetch_assoc();
$joining_date = $user['joining_date'];

// Fetch all 'Paid' records from fees
$history_res = $conn->query("SELECT * FROM fees WHERE user_id = $user_id AND status = 'Paid' ORDER BY fee_month DESC");
$history = [];
while($row = $history_res->fetch_assoc()) {
    $history[] = $row;
}

// Calculate the current month's due status
$current_month = date('Y-m');
$is_paid_current = false;
foreach ($history as $fee) {
    if (substr($fee['fee_month'], 0, 7) == $current_month) {
        $is_paid_current = true;
        break;
    }
}

$is_warning = false;
if (!$is_paid_current && $joining_date) {
    $joining_day = (int)date('d', strtotime($joining_date));
    $today_day = (int)date('d');

    // Check if today is within 3 days of the monthly due date (joining_day)
    if (abs($joining_day - $today_day) <= 3) {
        $is_warning = true;
    }
}

echo json_encode([
    "history" => $history,
    "upcoming" => [],
    "is_warning" => $is_warning,
    "success" => true
]);
?>
```

### 23. `api/admin_collect_fee.php`
```php
<?php
include 'db_connection.php';

$user_id = $_POST['user_id'];
$amount = $_POST['amount'];
$fee_month = $_POST['fee_month'];
$payment_date = $_POST['payment_date'];

// Insert into fees table with status='Paid'
$sql = "INSERT INTO fees (user_id, amount, fee_month, payment_date, status) VALUES ($user_id, '$amount', '$fee_month', '$payment_date', 'Paid')";

if ($conn->query($sql)) {
    echo json_encode(["success" => true, "message" => "Fee collected successfully"]);
} else {
    echo json_encode(["success" => false, "error" => $conn->error]);
}
?>
```

### 24. `api/search_student.php`
```php
<?php
include 'db_connection.php';
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['email'])) {
    $email = $conn->real_escape_string($data['email']);

    // Returns ALL user details from users table where role='Student'
    $sql = "SELECT * FROM users WHERE email = '$email' AND role = 'Student' LIMIT 1";
    $result = $conn->query($sql);

    if ($res = $result->fetch_assoc()) {
        // Also fetch fee history for this student
        $u_id = $res['id'];
        $fee_res = $conn->query("SELECT * FROM fees WHERE user_id = $u_id ORDER BY id DESC");
        $history = [];
        while($f = $fee_res->fetch_assoc()) {
            $history[] = $f;
        }

        echo json_encode([
            "success" => true,
            "student" => $res,
            "fee_history" => $history
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "No student found with this email."]);
    }
}
$conn->close();
?>
```

