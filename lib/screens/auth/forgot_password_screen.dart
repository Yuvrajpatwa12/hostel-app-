import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 0; // 0: Forgot, 1: OTP, 2: New Password, 3: Success

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 4 OTP Boxes Controllers & FocusNodes
  final List<TextEditingController> _otpControllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
  List.generate(4, (index) => FocusNode());

  bool _obscureNewPass = true;
  bool _obscureConfirmPass = true;

  // Timer Variables for OTP Resend
  int _start = 30;
  bool _isTimerActive = false;
  Timer? _timer;

  // Animation Controller for Smooth Transitions
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _changeStep(int nextStep) {
    _animController.reverse().then((_) {
      setState(() {
        _currentStep = nextStep;
      });
      _animController.forward();
    });
  }

  void _startOtpTimer() {
    setState(() {
      _start = 30;
      _isTimerActive = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isTimerActive = false;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF0B1C30)),
        leading: _currentStep < 3
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            if (_currentStep > 0) {
              _changeStep(_currentStep - 1);
            } else {
              Navigator.pop(context);
            }
          },
        )
            : null,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 460),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildCurrentStepScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStepScreen() {
    switch (_currentStep) {
      case 0:
        return _buildForgotPasswordStep();
      case 1:
        return _buildOtpVerificationStep();
      case 2:
        return _buildSetNewPasswordStep();
      case 3:
        return _buildSuccessStep();
      default:
        return _buildForgotPasswordStep();
    }
  }

  // 1. Forgot Password Step
  Widget _buildForgotPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.lock_reset_rounded, color: Color(0xFF006E2F), size: 30),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forgot Password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
                SizedBox(height: 2),
                Text("No worries, we got you covered.", style: TextStyle(fontSize: 13, color: Color(0xFF3D4A3D))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
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
                  prefixIcon: const Icon(Icons.mail_outline_rounded, color: Color(0xFF006E2F), size: 20),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    if (_emailController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your email address')),
                      );
                      return;
                    }
                    _startOtpTimer();
                    _changeStep(1);
                  },
                  child: const Text("Send Code", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, size: 16, color: Color(0xFF006E2F)),
            label: const Text("Back to log in?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006E2F))),
          ),
        ),
      ],
    );
  }

  // 2. OTP Verification Step with Live Timer & Animated Boxes
  Widget _buildOtpVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.mark_email_read_rounded, color: Color(0xFF006E2F), size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Verification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
                  const SizedBox(height: 2),
                  Text("Code sent to ${_emailController.text.isEmpty ? 'your email' : _emailController.text}",
                      style: const TextStyle(fontSize: 12, color: Color(0xFF3D4A3D)), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0B1C30).withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text("Enter the 4-digit code to continue", style: TextStyle(fontSize: 13, color: Color(0xFF3D4A3D))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 55,
                    height: 55,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _otpFocusNodes[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30)),
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _otpFocusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _otpFocusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    String otp = _otpControllers.map((c) => c.text).join();
                    if (otp.length < 4) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
                      );
                      return;
                    }
                    _changeStep(2);
                  },
                  child: const Text("Continue", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive code? ", style: TextStyle(fontSize: 13, color: Color(0xFF3D4A3D))),
                  _isTimerActive
                      ? Text("Resend in 0:${_start.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey))
                      : GestureDetector(
                    onTap: () {
                      _startOtpTimer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('New verification code sent!')),
                      );
                    },
                    child: const Text("Send Again",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF006E2F))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Set New Password Step
  Widget _buildSetNewPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.security_rounded, color: Color(0xFF006E2F), size: 30),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set New Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
                SizedBox(height: 2),
                Text("Create a secure unique password.", style: TextStyle(fontSize: 13, color: Color(0xFF3D4A3D))),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
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
              const Text("New Password", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
              const SizedBox(height: 8),
              TextField(
                controller: _newPasswordController,
                obscureText: _obscureNewPass,
                decoration: InputDecoration(
                  hintText: "••••••••",
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF006E2F), size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureNewPass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () => setState(() => _obscureNewPass = !_obscureNewPass),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Confirm Password", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF3D4A3D))),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPass,
                decoration: InputDecoration(
                  hintText: "••••••••",
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF006E2F), size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPass ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () => setState(() => _obscureConfirmPass = !_obscureConfirmPass),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF006E2F), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all password fields')),
                      );
                      return;
                    }
                    if (_newPasswordController.text != _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match!')),
                      );
                      return;
                    }
                    _changeStep(3);
                  },
                  child: const Text("Reset Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 4. Success Screen
  Widget _buildSuccessStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_rounded, size: 60, color: Color(0xFF006E2F)),
        ),
        const SizedBox(height: 24),
        const Text("Password Changed!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF0B1C30))),
        const SizedBox(height: 8),
        const Text("Your password has been reset successfully. You can now login with your new credentials.",
            style: TextStyle(fontSize: 14, color: Color(0xFF3D4A3D), height: 1.4), textAlign: TextAlign.center),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text("Continue to Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}