import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ตั้งพื้นหลังเป็นสีดำ
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // หัวข้อ "Login"
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            
            // ช่องกรอก Username
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: Colors.white),
                hintText: 'Type your username',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // ช่องกรอก Password
            TextField(
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock, color: Colors.white),
                hintText: 'Type your password',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            
            // ปุ่มลิงก์ "Forgot password?" ชิดขวา
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // โค้ดเมื่อกด "Forgot password?"
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            
            // ปุ่ม Gradient สำหรับ "LOGIN"
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.pinkAccent, Colors.deepPurpleAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // โค้ดเมื่อกดปุ่ม LOGIN
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // ข้อความ "Or Sign Up Using"
            const SizedBox(height: 20),
            const Text(
              'Or Sign Up Using',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 16),
            
            // แถวไอคอน Social Media
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Facebook
                InkWell(
                  onTap: () {
                    // Sign up with Facebook
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Twitter (ใช้ Icons.alternate_email เป็นตัวอย่าง)
                InkWell(
                  onTap: () {
                    // Sign up with Twitter
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.alternate_email,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Google (ใช้ Icons.g_mobiledata เป็นตัวอย่าง)
                InkWell(
                  onTap: () {
                    // Sign up with Google
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: Icon(
                      Icons.g_mobiledata,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            
            // ลิงก์ SIGN UP
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // โค้ดเมื่อกด "SIGN UP"
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
