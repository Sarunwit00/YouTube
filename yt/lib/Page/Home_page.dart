import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // สร้าง List ของหมวดหมู่ (icon + label)
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.explore_outlined,
      'label': 'ทั้งหมด',
    },
    {
      'label': 'วิดีโอใหม่สำหรับคุณ',
    },
    {
      'label': 'เกม',
    },
    {
      'label': 'ไลฟ์สด',
    },
    // เพิ่มได้ตามต้องการ
  ];

  // เก็บ index ของหมวดหมู่ที่ถูกเลือก
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ส่วน AppBar ด้านบน
          SliverAppBar(
            pinned: true,
            floating: false,
            leadingWidth: 100.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Image.asset('assets/youTubelogo.png'),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.cast),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notification_add_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
            ],
            backgroundColor: Colors.black,
          ),

          // เพิ่ม SliverToBoxAdapter เพื่อวาง Widget แนวนอน (ListView) ด้านล่าง AppBar
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black, // พื้นหลังสีดำ
              height: 56,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final bool isSelected = (index == selectedCategoryIndex);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // ถ้ามี icon ใน item ก็แสดง
                          if (item['icon'] != null) ...[
                            Icon(
                              item['icon'],
                              size: 16,
                              color: isSelected ? Colors.black : Colors.white,
                            ),
                            const SizedBox(width: 4),
                          ],

                          Text(
                            item['label'],
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Home Content',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
