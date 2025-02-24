import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// mockVideos เหมือนเดิม
final List<Map<String, String>> mockVideos = [
  {
    'title': 'CAMPปลิ้น | EP.88[1/2] เที่ยวชุมชน แวะชมธรรมชาติไปกับ "ตูน บริบั๊ก"',
    'channel': 'โคตรคูล',
    'views': 'การดู 9.5 หมื่น ครั้ง · 4 ชั่วโมงที่ผ่านมา',
    'thumbnail': 'assets/a1.png',
    'duration': '27:16',
    'avatar': 'assets/a2.png',
  },
  {
    'title': 'Tommy Richman - MILLION DOLLAR BABY(Official Music Video)',
    'channel': 'Tommy Richman',
    'views': 'การดู 52 ล้าน ครั้ง 7 เดือนที่แล้ว',
    'thumbnail': 'assets/c3.png',
    'duration': '2:47',
    'avatar': 'assets/c4.png',
  },
  {
    'title': 'เปิดโปงความขี้เหนียวของ เซอร์จิม เพื่อเปลี่ยนผี-ขอบสนามSPECIAL',
    'channel': 'ซอฝอท่านเซอร์ [Official]',
    'views': '7.6M views • 1 day ago',
    'thumbnail': 'assets/b1.png',
    'duration': '9:57',
    'avatar': 'assets/b2.png',
  },
  {
    'title': 'แกงคนรสดีแท้แลว!',
    'channel': 'OPZ TV',
    'views': 'การดู 1.2 ล้านครั้ง • 3 days ago',
    'thumbnail': 'assets/boom2.png',
    'duration': '10:32',
    'avatar': 'assets/boom.png',
  },
];

// SliverList สำหรับรายการวิดีโอ
class VideoSliverList extends StatelessWidget {
  const VideoSliverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final video = mockVideos[index];
          return VideoCard(
            title: video['title'] ?? '',
            channel: video['channel'] ?? '',
            views: video['views'] ?? '',
            thumbnailUrl: video['thumbnail'] ?? '',
            duration: video['duration'] ?? '',
            avatarUrl: video['avatar'] ?? '',
          );
        },
        childCount: mockVideos.length,
      ),
    );
  }
}

// Widget สำหรับแสดงวิดีโอ 1 รายการ (Thumbnail + Title + Channel + Views)
class VideoCard extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String thumbnailUrl;
  final String duration;
  final String avatarUrl;

  const VideoCard({
    Key? key,
    required this.title,
    required this.channel,
    required this.views,
    required this.thumbnailUrl,
    required this.duration,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ใช้ GestureDetector (หรือ InkWell) ครอบ Stack (Thumbnail)
        GestureDetector(
          onTap: () {
            // เมื่อกดที่ Thumbnail แล้วให้ไปหน้า VideoDetailPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoDetailPage(
                  title: title,
                  channel: channel,
                  views: views,
                  thumbnailUrl: thumbnailUrl,
                  duration: duration,
                  avatarUrl: avatarUrl,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              // Thumbnail
              CachedNetworkImage(
                imageUrl: thumbnailUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                // Placeholder ระหว่างโหลด
                placeholder: (context, url) => Container(
                  height: 220,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
                // ถ้าโหลดภาพไม่สำเร็จ
                errorWidget: (context, url, error) => Container(
                  height: 220,
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.black,
                  child: Text(
                    duration,
                    style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white) ??
                        const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ส่วน Avatar + Title + Channel + Views
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(avatarUrl),
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '$channel • $views',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // กดปุ่มเพิ่มเติม
            },
          ),
        ),

        // Divider คั่นแต่ละวิดีโอ
        const Divider(
          color: Colors.white24,
          height: 1,
        ),
      ],
    );
  }
}

// สร้างหน้าแสดงรายละเอียดของวิดีโอ (เหมือน YouTube)
class VideoDetailPage extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String thumbnailUrl;
  final String duration;
  final String avatarUrl;

  const VideoDetailPage({
    Key? key,
    required this.title,
    required this.channel,
    required this.views,
    required this.thumbnailUrl,
    required this.duration,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // กำหนด Theme เป็นสีดำ เพื่อให้เหมือน YouTube Dark Mode
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //title: const Text('YouTube Clone'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วน "วิดีโอ" (ในที่นี้ยังใช้รูป Thumbnail จำลองแทนวิดีโอจริง)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: thumbnailUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.black,
                      child: Text(
                        duration,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ชื่อวิดีโอ
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // จำนวนวิว
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                views,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

            // แถวของ Like / Dislike / Share / ฯลฯ
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconButtonText(
                    icon: Icons.thumb_up,
                    label: '4.5K',
                    onTap: () {},
                  ),
                  _iconButtonText(
                    icon: Icons.thumb_down,
                    label: '50',
                    onTap: () {},
                  ),
                  _iconButtonText(
                    icon: Icons.share,
                    label: 'แชร์',
                    onTap: () {},
                  ),
                  _iconButtonText(
                    icon: Icons.download,
                    label: 'ดาวน์โหลด',
                    onTap: () {},
                  ),
                  _iconButtonText(
                    icon: Icons.library_add,
                    label: 'บันทึก',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Divider
            const Divider(color: Colors.white24, thickness: 1),

            // ส่วนข้อมูลช่อง
            ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(avatarUrl),
              ),
              title: Text(
                channel,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '4.64M subscribers',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  // โค้ดเมื่อกด Subscribe
                },
                child: const Text('ติดตาม'),
              ),
            ),

            // Divider
            const Divider(color: Colors.white24, thickness: 1),

            // ส่วนคอมเมนต์ (ตัวอย่าง)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ความคิดเห็น 130',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            // ตัวอย่างคอมเมนต์ 1 อัน
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=3'), // ตัวอย่างรูป
              ),
              title: const Text(
                'Favourite, came from picturesque',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '1 ชั่วโมงที่แล้ว',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),

            // ... สามารถใส่คอมเมนต์อื่น ๆ เพิ่มได้ ...
            // Spacer เพื่อเลื่อนจอ
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // สร้าง widget ปุ่ม icon + text สำหรับ row ด้านบน
  Widget _iconButtonText({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
