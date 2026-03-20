import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[900]!, Colors.blueGrey[700]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book_rounded, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'SMART LIBRARY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Tri thức trong tầm tay bạn',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 50),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      final user = await _auth.signInWithGoogle();
                      setState(() => _isLoading = false);
                      if (user == null) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đăng nhập thất bại. Vui lòng thử lại.')),
                          );
                        }
                      }
                    },
                    icon: Image.network(
                      'https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png',
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.login, size: 24),
                    ),
                    label: const Text('Đăng nhập với Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
            const SizedBox(height: 20),
            _isLoading
                ? const SizedBox.shrink()
                : TextButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      final user = await _auth.signInAnonymously();
                      setState(() => _isLoading = false);
                      if (user == null && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lỗi đăng nhập khách.')),
                        );
                      }
                    },
                    child: const Text(
                      'Tiếp tục với tư cách Khách',
                      style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
