import 'package:flutter/material.dart';

class SubscriptionsRow extends StatelessWidget {
  const SubscriptionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ข้อมูลตัวอย่าง: ช่องต่าง ๆ
    final List<Map<String, String>> subs = [
      {
        'name': 'OPZ TV',
        'avatar': 'assets/boom.png',
      },
      {
        'name': 'HEART ROCKER',
        'avatar': 'assets/E3.png',
      },
      {
        'name': 'Bay Riffer',
        'avatar': 'assets/E1.png',
      },
      {
        'name': 'CigaretteS',
        'avatar': 'assets/E5.png',
      },
      {
        'name': 'Rednight',
        'avatar': 'assets/E4.png',
      },
      {
        'name': '23 Mania',
        'avatar': 'assets/E2.png',
      },
      {
        'name': 'โครตคูล',
        'avatar':'assets/a2.png',
      },
      {
        'name': 'Tommy Richman',
        'avatar':'assets/c4.png',
      },
      
    ];

    return SliverToBoxAdapter(
      child: Container(
        color: Colors.black,
        height: 90, // ความสูงของแถว
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: subs.length,
          itemBuilder: (context, index) {
            final item = subs[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  // ถ้า avatar เป็นค่าว่าง เช่น "ทั้งหมด" อาจแสดงเป็น Icon หรือ CircleAvatar แบบอื่น
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white10,
                    backgroundImage: item['avatar']!.isNotEmpty
                        ? NetworkImage(item['avatar']!)
                        : null, // ถ้าไม่มี avatar ให้เป็น null
                    child: item['avatar']!.isEmpty
                        ? const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  // ชื่อช่อง (ตัดให้สั้น หรือใช้ TextOverflow)
                  Text(
                    item['name'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
