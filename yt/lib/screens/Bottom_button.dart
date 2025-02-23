import 'package:flutter/material.dart';
import 'Account.dart';
import 'Home_page.dart';
import 'Subscrip.dart';
import 'shorts_page.dart';

class BottomButton extends StatefulWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  int _selectedIndex = 0;

  // ลำดับหน้าที่จะแสดง
  final _screens = [
    Homepage(),        // index 0
    ShortsPageNew(),   // index 1
    Homepage(),        // index 2 -> จะถูกซ่อนไว้ ไม่ได้ใช้จริง (เพราะกดปุ่ม + แล้วโชว์ Bottom Sheet)
    Subscrip(),        // index 3
    AccountPage(),     // index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ใช้ Stack + Offstage เพื่อสลับหน้าตาม _selectedIndex
      body: Stack(
        children: _screens
            .asMap()
            .map((i, screen) => MapEntry(
                  i,
                  Offstage(offstage: _selectedIndex != i, child: screen),
                ))
            .values
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 45, color: Colors.white),
            activeIcon: Icon(Icons.add_circle),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            activeIcon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
      ),
    );
  }

  /// เมื่อกดปุ่มใน BottomNavigationBar
  void _onItemTapped(int index) {
    // ถ้ากดปุ่มกลาง (index == 2) -> แสดง Bottom Sheet
    if (index == 2) {
      _showCreateBottomSheet();
    } else {
      // เปลี่ยนหน้าไปตาม index ที่เลือก
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  /// แสดง Bottom Sheet สไตล์ YouTube
  void _showCreateBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250, // ปรับความสูงตามต้องการ
          child: Column(
            children: [
              // ส่วนหัว "สร้าง" + ปุ่มปิด
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    const Text(
                      'Create',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.grey),

              // แถวเมนู (วิดีโอ, ไลฟ์สด, โพสต์)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCreateItem(
                      icon: Icons.video_call_outlined,
                      label: 'Video',
                      onTap: () {
                        Navigator.pop(context);
                        // TODO: ใส่โค้ดอัปโหลด/สร้างวิดีโอ
                      },
                    ),
                    _buildCreateItem(
                      icon: Icons.wifi_tethering_outlined,
                      label: 'Live broadcast',
                      onTap: () {
                        Navigator.pop(context);
                        // TODO: ใส่โค้ดไลฟ์สด
                      },
                    ),
                    _buildCreateItem(
                      icon: Icons.post_add_outlined,
                      label: 'Post',
                      onTap: () {
                        Navigator.pop(context);
                        // TODO: ใส่โค้ดสร้างโพสต์
                      },
                    ),
                  ],
                ),
              ),

              // ปุ่มยกเลิก
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Widget ปุ่มเมนูใน Bottom Sheet (ไอคอน + ข้อความ)
  Widget _buildCreateItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 40),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
