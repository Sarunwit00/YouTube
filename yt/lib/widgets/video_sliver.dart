import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    'views': 'การดู 52 ล้าน ครั้ง 7 เดือนที่',
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
        // ส่วน Thumbnail + Duration
        Stack(
          children: [
            // ใช้ CachedNetworkImage แทน Image.network
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
        // ส่วน Avatar + Title + Channel + Views
        ListTile(
          leading: CircleAvatar(
            // ใช้ CachedNetworkImage ใน CircleAvatar
            backgroundImage: CachedNetworkImageProvider(
              avatarUrl,
            ),
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
