import 'package:flutter/material.dart';
import 'student_signup.dart';
import 'forgot_password_screen.dart';
import 'kitchen_staff_signup.dart';
import '../student/homepage.dart';
import '../admin/admin_dashboard_screen.dart';
import '../kitchen/kitchen_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  final String selectedRole;
  const LoginScreen({super.key, this.selectedRole = 'Student'});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _selectedRole;

  final List<String> _roles = ['Student', 'Warden/Admin', 'Kitchen Staff'];

  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both Email and Password!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in successfully as $_selectedRole!'),
          backgroundColor: const Color(0xFF22C55E),
        ),
      );

      final roleNormalized = _selectedRole.trim().toLowerCase();

      // 🚀 Kitchen Staff Login hune bitikai Direct KitchenDashboardScreen khulne
      if (roleNormalized == 'kitchen staff') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const KitchenDashboardScreen()),
          (route) => false,
        );
      } else if (roleNormalized == 'admin' || roleNormalized == 'warden' || roleNormalized == 'warden/admin') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(role: _selectedRole)),
          (route) => false,
        );
      }
    }
  }

  void _navigateToSignup() {
    final roleNormalized = _selectedRole.trim().toLowerCase();
    if (roleNormalized == 'student') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentSignupScreen()));
    } else if (roleNormalized == 'kitchen staff') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const KitchenStaffSignupScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$_selectedRole signup is restricted. Please contact Admin.')),
      );
    }
  }

  void _navigateToForgotPassword() {
    if (_selectedRole.trim().toLowerCase() != 'student') return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0B1C30)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.house, color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "HostelMate",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
                  ),
                  const SizedBox(height: 6),
                  Text("Sign in to your $_selectedRole portal", style: const TextStyle(fontSize: 14, color: Color(0xFF3D4A3D))),
                  const SizedBox(height: 24),

                  // Role Tabs Selector
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAEFEA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: _roles.map((role) {
                        bool isSelected = _selectedRole == role;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedRole = role),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF006E2F) : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                role == 'Kitchen Staff' ? 'Kitchen' : role,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : const Color(0xFF3D4A3D),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form Container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0B1C30).withValues(alpha: 0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email Address", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "name@hostel.com",
                            prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20, color: Color(0xFF006E2F)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Password", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "••••••••",
                            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: Color(0xFF006E2F)),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        if (_selectedRole.trim().toLowerCase() == 'student')
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _navigateToForgotPassword,
                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF006E2F)),
                              ),
                            ),
                          ),

                        if (_selectedRole.trim().toLowerCase() != 'student') const SizedBox(height: 10),
                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF22C55E),
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: _isLoading ? null : _handleSignIn,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text("Sign In as $_selectedRole", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _selectedRole.trim().toLowerCase() == 'student'
                            ? "Don't have a student account?"
                            : "Staff/Admin account registration?",
                        style: const TextStyle(fontSize: 13, color: Color(0xFF3D4A3D)),
                      ),
                      TextButton(
                        onPressed: _navigateToSignup,
                        child: Text(
                          _selectedRole.trim().toLowerCase() == 'student'
                              ? "Sign Up"
                              : _selectedRole.trim().toLowerCase() == 'kitchen staff'
                                  ? "Sign Up"
                                  : "Contact Admin",
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'student_signup.dart';
// import 'forgot_password_screen.dart';
// import '../dashboard/homepage.dart'; // Apna homepage.dart file yahan import karein
// import '../admin/admin_dashboard_screen.dart';

// class LoginScreen extends StatefulWidget {
//   final String selectedRole;
//   const LoginScreen({super.key, this.selectedRole = 'Student'});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   late String _selectedRole;
//   final List<String> _roles = ['Student', 'Warden', 'Kitchen Staff'];

//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _selectedRole = widget.selectedRole;
//   }

//   // Handle Sign In with Email & Password validation & redirect to homepage.dart
//   void _handleSignIn() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     // Validation: Email and Password required
//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter both Email and Password!'),
//           backgroundColor: Colors.redAccent,
//         ),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);
//     await Future.delayed(const Duration(milliseconds: 1200)); // Simulated network delay
//     setState(() => _isLoading = false);

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Logged in successfully as $_selectedRole!'),
//           backgroundColor: const Color(0xFF22C55E),
//         ),
//       );

//       // Navigate directly to HomeScreen (homepage.dart) and clear login route stack
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen(role: _selectedRole)),
//             (route) => false,
//       );
//     }
//   }

//   void _navigateToSignup() {
//     if (_selectedRole == 'Student') {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentSignupScreen()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('$_selectedRole signup is restricted. Please contact Admin.')),
//       );
//     }
//   }

//   void _navigateToForgotPassword() {
//     if (_selectedRole != 'Student') return;

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Color(0xFF0B1C30)),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
//             child: Container(
//               constraints: const BoxConstraints(maxWidth: 460),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 64,
//                     height: 64,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF22C55E),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Icon(Icons.house, color: Colors.white, size: 36),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "HostelMate",
//                     style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
//                   ),
//                   const SizedBox(height: 6),
//                   Text("Sign in to your $_selectedRole portal", style: const TextStyle(fontSize: 14, color: Color(0xFF3D4A3D))),
//                   const SizedBox(height: 24),

//                   // Role Selector Tabs
//                   Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEAEFEA),
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: _roles.map((role) {
//                         bool isSelected = _selectedRole == role;
//                         return Expanded(
//                           child: GestureDetector(
//                             onTap: () => setState(() => _selectedRole = role),
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 200),
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               decoration: BoxDecoration(
//                                 color: isSelected ? const Color(0xFF006E2F) : Colors.transparent,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               alignment: Alignment.center,
//                               child: Text(
//                                 role == 'Kitchen Staff' ? 'Kitchen' : role,
//                                 style: TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.bold,
//                                   color: isSelected ? Colors.white : const Color(0xFF3D4A3D),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   // Login Card Container
//                   Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(32),
//                       boxShadow: [
//                         BoxShadow(
//                           color: const Color(0xFF0B1C30).withValues(alpha: 0.06),
//                           blurRadius: 24,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Email Address", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
//                         const SizedBox(height: 8),
//                         TextField(
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             hintText: "name@hostel.com",
//                             prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20, color: Color(0xFF006E2F)),
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(14),
//                               borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         const Text("Password", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
//                         const SizedBox(height: 8),
//                         TextField(
//                           controller: _passwordController,
//                           obscureText: _obscurePassword,
//                           decoration: InputDecoration(
//                             hintText: "••••••••",
//                             prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: Color(0xFF006E2F)),
//                             suffixIcon: IconButton(
//                               icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
//                               onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                             ),
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(14),
//                               borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // Forgot Password Option (Only for Student)
//                         if (_selectedRole == 'Student')
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: _navigateToForgotPassword,
//                               style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(50, 30)),
//                               child: const Text(
//                                 "Forgot Password?",
//                                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF006E2F)),
//                               ),
//                             ),
//                           ),

//                         if (_selectedRole != 'Student') const SizedBox(height: 10),

//                         const SizedBox(height: 16),

//                         // Sign In Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF22C55E),
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                             ),
//                             onPressed: _isLoading ? null : _handleSignIn,
//                             child: _isLoading
//                                 ? const CircularProgressIndicator(color: Colors.white)
//                                 : Text("Sign In as $_selectedRole", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 24),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         _selectedRole == 'Student' ? "Don't have a student account?" : "Staff/Admin account registration?",
//                         style: const TextStyle(fontSize: 13, color: Color(0xFF3D4A3D)),
//                       ),
//                       TextButton(
//                         onPressed: _navigateToSignup,
//                         child: Text(
//                           _selectedRole == 'Student' ? "Sign Up" : "Contact Admin",
//                           style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF006E2F)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }