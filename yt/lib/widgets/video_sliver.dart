import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

// mockVideos ที่เพิ่ม key "originalLink"
final List<Map<String, String>> mockVideos = [
  {
    'title': 'CAMPปลิ้น | EP.88[1/2] เที่ยวชุมชน แวะชมธรรมชาติไปกับ "ตูน บริบั๊ก"',
    'channel': 'โคตรคูล',
    'views': 'การดู 9.5 หมื่น ครั้ง · 4 ชั่วโมงที่ผ่านมา',
    'thumbnail': 'assets/a1.png',
    'duration': '27:16',
    'avatar': 'assets/a2.png',
    'originalLink': 'https://www.youtube.com/watch?v=pULBAwhqwus',
  },
  {
    'title': 'Tommy Richman - MILLION DOLLAR BABY(Official Music Video)',
    'channel': 'Tommy Richman',
    'views': 'การดู 52 ล้าน ครั้ง 7 เดือนที่แล้ว',
    'thumbnail': 'assets/c3.png',
    'duration': '2:47',
    'avatar': 'assets/c4.png',
    'originalLink': 'https://www.youtube.com/watch?v=Zf1d8SGuxfs',
  },
  {
    'title': 'เปิดโปงความขี้เหนียวของ เซอร์จิม เพื่อเปลี่ยนผี-ขอบสนามSPECIAL',
    'channel': 'ซอฝอท่านเซอร์ [Official]',
    'views': '7.6M views • 1 day ago',
    'thumbnail': 'assets/b1.png',
    'duration': '9:57',
    'avatar': 'assets/b2.png',
    'originalLink': 'https://www.youtube.com/watch?v=rdUATC7KN_8',
  },
  {
    'title': 'แกจบลงแค่นี้แหละ!',
    'channel': 'OPZ TV',
    'views': 'การดู 1.2 ล้านครั้ง • 3 year ago',
    'thumbnail': 'assets/boom2.png',
    'duration': '10:32',
    'avatar': 'assets/boom.png',
    'originalLink': 'https://www.youtube.com/watch?v=oSNntXkNZeE',
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
            originalLink: video['originalLink'] ?? '',
          );
        },
        childCount: mockVideos.length,
      ),
    );
  }
}

// Widget สำหรับแสดงวิดีโอ 1 รายการ
class VideoCard extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String thumbnailUrl;
  final String duration;
  final String avatarUrl;
  final String originalLink; // เพิ่ม field สำหรับลิงก์ต้นฉบับ

  const VideoCard({
    Key? key,
    required this.title,
    required this.channel,
    required this.views,
    required this.thumbnailUrl,
    required this.duration,
    required this.avatarUrl,
    required this.originalLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // เมื่อกดที่ Thumbnail ให้ไปหน้า VideoDetailPage พร้อมส่งค่า originalLink
        GestureDetector(
          onTap: () {
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
                  originalLink: originalLink,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: thumbnailUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 220,
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
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
            onPressed: () {},
          ),
        ),
        const Divider(
          color: Colors.white24,
          height: 1,
        ),
      ],
    );
  }
}

// หน้าแสดงรายละเอียดของวิดีโอ (VideoDetailPage)
class VideoDetailPage extends StatelessWidget {
  final String title;
  final String channel;
  final String views;
  final String thumbnailUrl;
  final String duration;
  final String avatarUrl;
  final String originalLink; // เพิ่ม field สำหรับลิงก์ต้นฉบับ

  const VideoDetailPage({
    Key? key,
    required this.title,
    required this.channel,
    required this.views,
    required this.thumbnailUrl,
    required this.duration,
    required this.avatarUrl,
    required this.originalLink,
  }) : super(key: key);

  // ฟังก์ชันเปิด URL ด้วย url_launcher
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนวิดีโอที่แสดง Thumbnail พร้อมไอคอนเล่น (Play icon) อยู่ตรงกลาง
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
                  // ไอคอนเล่นวิดีโอที่อยู่ตรงกลาง Thumbnail
                  Center(
                    child: IconButton(
                      iconSize: 64,
                      icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                      onPressed: () {
                        _launchURL(originalLink);
                      },
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                views,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconButtonText(icon: Icons.thumb_up, label: '4.5K', onTap: () {}),
                  _iconButtonText(icon: Icons.thumb_down, label: '50', onTap: () {}),
                  _iconButtonText(icon: Icons.share, label: 'แชร์', onTap: () {}),
                  _iconButtonText(icon: Icons.download, label: 'ดาวน์โหลด', onTap: () {}),
                  _iconButtonText(icon: Icons.library_add, label: 'บันทึก', onTap: () {}),
                ],
              ),
            ),
            const Divider(color: Colors.white24, thickness: 1),
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
                child: const Text('ติดตาม'),
              ),
            ),
            const Divider(color: Colors.white24, thickness: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ความคิดเห็น 130',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _iconButtonText({required IconData icon, required String label, required VoidCallback onTap}) {
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
