import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortsPageNew extends StatefulWidget {
  const ShortsPageNew({Key? key}) : super(key: key);

  @override
  State<ShortsPageNew> createState() => _ShortsPageNewState();
}

class _ShortsPageNewState extends State<ShortsPageNew> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _videoList = [
    {
      'videoUrl': 'video1.mp4',
      'creator': '@Creator1',
      'title': 'Amazing Video 1',
    },
    {
      'videoUrl': 'video1.mp4',
      'creator': '@Creator2',
      'title': 'Amazing Video 2',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videoList.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final video = _videoList[index];
          return ShortVideoItem(
            videoUrl: video['videoUrl']!,
            creator: video['creator']!,
            title: video['title']!,
            isActive: index == _currentPage,
          );
        },
      ),
    );
  }
}

class ShortVideoItem extends StatefulWidget {
  final String videoUrl;
  final String creator;
  final String title;
  final bool isActive;

  const ShortVideoItem({
    Key? key,
    required this.videoUrl,
    required this.creator,
    required this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  State<ShortVideoItem> createState() => _ShortVideoItemState();
}

class _ShortVideoItemState extends State<ShortVideoItem> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  // เพิ่ม state สำหรับไลค์และดิสไลค์
  int _likeCount = 0;
  int _dislikeCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        if (widget.isActive) {
          _controller.play();
        }
      }).catchError((error) {
        debugPrint('Error initializing video: $error');
      });
  }

  @override
  void didUpdateWidget(covariant ShortVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      widget.isActive ? _controller.play() : _controller.pause();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // วิดีโอเต็มจอ
        Positioned.fill(
          child: _initialized
              ? VideoPlayer(_controller)
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
        ),

        // แสดง Creator และ Title ด้านซ้ายล่าง
        Positioned(
          left: 16,
          bottom: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.creator,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),

        // ชุดปุ่มด้านขวา (Like, Dislike, Comment, Share)
        Positioned(
          right: 16,
          bottom: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Like
              IconButton(
                icon: const Icon(Icons.thumb_up, color: Colors.white, size: 30),
                onPressed: () {
                  setState(() {
                    _likeCount++; // เพิ่มจำนวนไลค์
                  });
                },
              ),
              // แสดงจำนวนไลค์ที่กด
              Text('$_likeCount', style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 20),

              // Dislike
              IconButton(
                icon: const Icon(Icons.thumb_down, color: Colors.white, size: 30),
                onPressed: () {
                  setState(() {
                    _dislikeCount++; // เพิ่มจำนวนดิสไลค์
                  });
                },
              ),
              // แสดงจำนวนดิสไลค์ที่กด
              Text('$_dislikeCount', style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 20),

              // Comment
              IconButton(
                icon: const Icon(Icons.comment, color: Colors.white, size: 30),
                onPressed: () {
                  // โค้ดเมื่อกดปุ่ม Comment
                },
              ),
              const Text('0', style: TextStyle(color: Colors.white)),

              const SizedBox(height: 20),

              // Share
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white, size: 30),
                onPressed: () {
                  // โค้ดเมื่อกดปุ่ม Share
                },
              ),
              const Text('แชร์', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
