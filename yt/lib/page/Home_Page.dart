import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // รายการหมวดหมู่ (horizontal list) 
  final List<String> categories = [
    "ทั้งหมด",
    "วิดีโอใหม่สำหรับคุณ",
    "เกม",
    "ไลฟ์สด",
    "เพลง",
    "ข่าวสาร",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar สีดำ พร้อมปุ่ม Cast, Notification, Search
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            // สมมติเป็นโลโก้ YouTube ถ้าไม่มีไฟล์ ใช้ Icon แทน
            // ถ้ามีไฟล์โลโก้ ให้ใช้ Image.asset('assets/youtube_logo.png', height: 24)
            Icon(Icons.play_arrow, color: Colors.red, size: 32),
            const SizedBox(width: 8),
            const Text("YouTube"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // แถบหมวดหมู่แบบเลื่อนซ้ายขวา
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () {
                      // กดเลือกหมวดหมู่
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      categories[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          // เนื้อหาอื่น ๆ ของหน้า Home
          Expanded(
            child: Center(
              child: Text(
                "Home Content",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}