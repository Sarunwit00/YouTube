import 'package:flutter/material.dart';
import '../widgets/custom_sliverbar.dart';
import '../widgets/video_sliver.dart'; // <-- import ไฟล์ที่เราสร้าง

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> categories = [
    {'label': 'All'},
    {'label': 'Game'},
    {'label': 'Message'},
    {'label': 'Podcast'},
    {'label': 'Live'},
    {'label': 'Song'},
    {'label': 'Mix'},
    {'label': 'Basketball'},
    {'label': 'Action adventure game'},
    {'label': 'New video for you'},
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // พื้นหลังสีดำ
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          CustomCategorySliver(
            categories: categories,
            selectedCategoryIndex: selectedCategoryIndex,
            onCategorySelected: (int index) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
          ),
          // เพิ่ม SliverList ของวิดีโอ
          const VideoSliverList(),
        ],
      ),
    );
  }
}
