import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Column(
        children: [
          // ───────── CUSTOM TITLE BAR ─────────
          _buildCustomTitleBar(),

          // ───────── NỘI DUNG CHÍNH ─────────
          Expanded(
            child: Center(
              child: const Text(
                'Home Screen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────── WIDGET: CUSTOM TITLE BAR ─────────
  Widget _buildCustomTitleBar() {
    return GestureDetector(
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(
        height: 32,
        color: const Color(0xFF0D1B2A),
        child: Row(
          children: [
            const SizedBox(width: 12),
            // Nút Back
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              hoverColor: Colors.white24,
              child: Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back, size: 18, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              'assets/images/app_icon.ico',
              height: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'SNST VietNam',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            _windowButton(Icons.remove, () => windowManager.minimize()),
            _windowButton(Icons.crop_square, () async {
              if (await windowManager.isMaximized()) {
                windowManager.unmaximize();
              } else {
                windowManager.maximize();
              }
            }),
            _windowButton(Icons.close, () => windowManager.close(), isClose: true),
          ],
        ),
      ),
    );
  }

  Widget _windowButton(IconData icon, VoidCallback onPressed, {bool isClose = false}) {
    return InkWell(
      onTap: onPressed,
      hoverColor: isClose ? Colors.red : Colors.white24,
      child: Container(
        width: 46,
        height: 32,
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}