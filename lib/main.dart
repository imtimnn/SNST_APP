import 'dart:async';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:native_splash_screen/native_splash_screen.dart' as nss;
import 'home_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1100, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  // Chỉ cấu hình, KHÔNG show() ở đây nữa
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    // để trống — cửa sổ vẫn đang ẩn
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Giữ splash thêm 2 giây (tùy chỉnh số này theo ý bạn)
      await Future.delayed(const Duration(milliseconds: 1000));

      // Đóng splash TRƯỚC, và CHỜ animation fade chạy xong hẳn
      await nss.close(animation: nss.CloseAnimation.fade);

      // Splash đã đóng xong hoàn toàn → giờ mới cho cửa sổ chính hiện ra
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNST VietNam',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 32, 42, 168)),
      ),
    );
  }
}