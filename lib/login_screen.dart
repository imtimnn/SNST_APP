import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Màu chủ đạo lấy theo tone logo ADTechnology
  static const Color brandRed = Color(0xFFE3001B);
  static const Color darkText = Color(0xFF333333);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // TODO: thay bằng logic xác thực thật sau này
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both Username and Password')),
      );
      return;
    }

    // Tạm thời chuyển thẳng qua HomeScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // nền ngoài cùng, tông tối
      body: Column(
        children: [
          // ───────── CUSTOM TITLE BAR ─────────
          _buildCustomTitleBar(),

          // ───────── NỘI DUNG LOGIN (giữ nguyên như cũ) ─────────
          Expanded(
            child: Center(
              child: Container(
                width: 1000,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    // ───────── PANEL TRÁI: FORM LOGIN ─────────
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo công ty
                            Center(
                              child: Image.asset(
                                'assets/images/logo_rm_bkgr.png',
                                height: 120,
                              ),
                            ),
                            const Spacer(flex: 2),

                            // Avatar icon
                            Center(
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 46,
                                  color: brandRed,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Ô Username
                            _buildTextField(
                              controller: _usernameController,
                              hint: 'Username',
                              icon: Icons.person_outline,
                              obscureText: false,
                            ),
                            const SizedBox(height: 16),

                            // Ô Password
                            _buildTextField(
                              controller: _passwordController,
                              hint: 'Password',
                              icon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() => _obscurePassword = !_obscurePassword);
                                },
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Nút LOGIN
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: brandRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(flex: 3),
                          ],
                        ),
                      ),
                    ),

                    // ───────── PANEL PHẢI: ẢNH NỀN + WELCOME ─────────
                    Expanded(
                      flex: 6,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/login_background.gif',
                            fit: BoxFit.cover,
                          ),
                          // Lớp phủ tối nhẹ để chữ "Welcome." luôn rõ dù ảnh nền sáng/tối
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.4),
                                ],
                              ),
                            ),
                          ),

                          // Chữ "Welcome."
                          Positioned(
                            right: 40,
                            bottom: 50,
                            child: Text(
                              'Welcome.',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
            //const Icon(Icons.bolt, size: 16, color: Colors.white),
            Image.asset(
            'assets/images/app_icon.ico',
            height: 18,
),
            const SizedBox(width: 8),
            const Text(
              'SNST VietNam',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscureText,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: darkText),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}