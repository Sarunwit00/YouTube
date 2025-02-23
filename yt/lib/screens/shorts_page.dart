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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() => _initialized = true);
        if (widget.isActive) {
          _controller.play();
        }
      }).catchError((error) {
        print('Error initializing video: $error');
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
        // แสดงวิดีโอเต็มจอ
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
        // Overlay แสดงข้อมูล creator และ title
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
      ],
    );
  }
}
