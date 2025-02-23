import 'package:flutter/material.dart';
import 'Login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // รายการเมนูที่ต้องการแสดง
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.settings,
        'title': 'General',
      },
      {
        'icon': Icons.switch_account,
        'title': 'Apply for an account',
      },
      {
        'icon': Icons.family_restroom,
        'title': 'family center',
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifications',
      },
      {
        'icon': Icons.shopping_bag_outlined,
        'title': 'Purchasing and Membership',
      },
      {
        'icon': Icons.payment_outlined,
        'title': 'Billing and Payment',
      },
      {
        'icon': Icons.history,
        'title': 'Manage all history',
      },
      {
        'icon': Icons.play_circle_outlined,
        'title': 'Your information on YouTube',
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'title': 'Privacy',
      },
      {
        'icon': Icons.gavel_outlined,
        'title': 'Connected apps',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Colors.black,
      ),
      body: ListView.separated(
        itemCount: menuItems.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white24,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(
              item['icon'],
              color: Colors.white,
            ),
            title: Text(
              item['title'],
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {
              // เช็คว่าเมนูที่กดคือ "Apply for an account" หรือไม่
              if (item['title'] == 'Apply for an account') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              } else {
                // ถ้าเป็นเมนูอื่น ก็ทำอย่างอื่นตามต้องการ
                // Navigator.push(...) หรือแสดง Dialog ฯลฯ
              }
            },
          );
        },
      ),
    );
  }
}
