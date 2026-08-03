// ==========================================
// FILE: focus_session_screen.dart
// Path: lib/screens/student/focus_session_screen.dart
// ==========================================

import 'dart:async';
import 'package:flutter/material.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({super.key});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  String selectedAtmosphere = 'Rain';
  double volumeValue = 0.5;
  
  // Timer variables
  static const int totalSeconds = 25 * 60; // 25 minutes
  int remainingSeconds = totalSeconds;
  bool isPlaying = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingSeconds > 0) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          _timer?.cancel();
          setState(() {
            isPlaying = false;
          });
        }
      });
    } else {
      _timer?.cancel();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      isPlaying = false;
      remainingSeconds = totalSeconds;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Stack(
        children: [
          // Background Image with opacity overlay
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=800',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Color(0xFF0F172A), size: 24),
                        onPressed: () {
                          _timer?.cancel();
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Focus Session',
                        style: TextStyle(
                          color: Color(0xFF1E3A8A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Big Dynamic Timer Circle
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF3B0764), width: 8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatTime(remainingSeconds),
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'POMODORO',
                                style: TextStyle(
                                  color: Color(0xFF3B0764),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Control Buttons (Start/Pause & Reset)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF3B0764),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: _resetTimer,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: const Icon(Icons.refresh, color: Color(0xFF64748B), size: 24),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 35),

                        // Ambient Atmosphere Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Ambient Atmosphere',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => selectedAtmosphere = 'Noise'),
                                child: _buildAtmosphereCard('Noise', Icons.grain, selectedAtmosphere == 'Noise'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => selectedAtmosphere = 'Rain'),
                                child: _buildAtmosphereCard('Rain', Icons.water_drop_outlined, selectedAtmosphere == 'Rain'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => selectedAtmosphere = 'Library'),
                                child: _buildAtmosphereCard('Library', Icons.menu_book_outlined, selectedAtmosphere == 'Library'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        // Volume Slider
                        Row(
                          children: [
                            const Icon(Icons.volume_mute, size: 18, color: Color(0xFF64748B)),
                            Expanded(
                              child: Slider(
                                value: volumeValue,
                                activeColor: const Color(0xFF3B0764),
                                inactiveColor: Colors.grey.shade300,
                                onChanged: (val) => setState(() => volumeValue = val),
                              ),
                            ),
                            const Icon(Icons.volume_up, size: 18, color: Color(0xFF64748B)),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Quote Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '"Deep work is the ability to focus without distraction on a cognitively demanding task."',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF1E293B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '— Cal Newport',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF991B1B),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Daily Goal Progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Daily Goal',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF334155),
                              ),
                            ),
                            Text(
                              '3/4 Sessions',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3B0764),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B0764)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAtmosphereCard(String label, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3B0764) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF3B0764) : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: isSelected ? Colors.white : const Color(0xFF64748B), size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}