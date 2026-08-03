import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kathmadnuhostel/screens/admin/admin_dashboard_screen.dart';
import 'screens/auth/role_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isInitialized = false;
  try {
    if (Firebase.apps.isEmpty) {
      if (kIsWeb) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyC1M9DvtfB_0dYtbBuOhBgaFOqzk3SeeQM",
            authDomain: "ktmhostelpluee.firebaseapp.com",
            projectId: "ktmhostelpluee",
            storageBucket: "ktmhostelpluee.firebasestorage.app",
            messagingSenderId: "874999479733",
            appId: "1:874999479733:web:00978ad6ff3cbdd795adfc",
            measurementId: "G-CGD5GXLG7L",
          ),
        );
      } else {
        await Firebase.initializeApp();
      }
    }
    isInitialized = true;
    debugPrint("Firebase successfully initialized");
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }

  runApp(MyApp(isFirebaseReady: isInitialized));
}

class MyApp extends StatelessWidget {
  final bool isFirebaseReady;
  const MyApp({super.key, this.isFirebaseReady = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HostelMate',
      theme: ThemeData(
        fontFamily: 'Plus Jakarta Sans',
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: isFirebaseReady 
          ? const SplashScreen()
          : Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 50),
                    const SizedBox(height: 16),
                    const Text("Firebase Setup Error", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text("The API key provided is invalid.", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => const RoleSelectionScreen())
                      ),
                      child: const Text("Continue anyway (Offline/Demo Mode)"),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006E2F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.apartment, size: 45, color: Color(0xFF006E2F)),
            ),
            const SizedBox(height: 20),
            const Text(
              "HostelMate",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your Ultimate Hostel Companion",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
