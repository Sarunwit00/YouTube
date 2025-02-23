import 'package:flutter/material.dart';
import '../widgets/SubscriptionsRow.dart';
import '../widgets/custom_sliverbar.dart';
import '../widgets/video_sliver.dart';

class Subscrip extends StatefulWidget {
  const Subscrip({super.key});

  @override
  State<Subscrip> createState() => _SubscripState();
}

class _SubscripState extends State<Subscrip> {
  final List<Map<String, dynamic>> categories = [
    {'label': 'All'},
    {'label': 'Today'},
    {'label': 'Video'},
    {'label': 'Shorts'},
    {'label': 'Live'},
    {'label': 'Post'},
    {'label': 'Continue watching'},
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // 1) SliverAppBar
          const CustomSliverAppBar(),

          // 2) SubscriptionsRow
          const SubscriptionsRow(),

          // 3) SliverToBoxAdapter: แสดงหมวดหมู่ (CustomCategorySliver)
          CustomCategorySliver(
            categories: categories,
            selectedCategoryIndex: selectedCategoryIndex,
            onCategorySelected: (int index) {
              setState(() {
                selectedCategoryIndex = index;
              });
            },
          ),

          // 4) VideoSliverList
          const VideoSliverList(),
        ],
      ),
    );
  }
}
