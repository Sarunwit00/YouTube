import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.explore_outlined,
    },
    {
      'label': 'All',
    },
    {
      'label': 'Game',
    },
    {
      'label': 'Live broadcast',
    },
    {
      'label': 'Message',
    },
    {
      'label': 'Long Category Name Example That Scrolls',
    },
    {
      'label': 'Another Category',
    },
    // เพิ่มได้ตามต้องการ
  ];
  int selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              height: 55,
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == index ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedCategoryIndex == index ? Colors.white : Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (category['icon'] != null)
                              Icon(
                                category['icon'],
                                color: selectedCategoryIndex == index ? Colors.white : Colors.grey,
                              ),
                            if (category['label'] != null)
                              Container(
                                // กำหนดความกว้างคงที่เพื่อให้ marquee ทำงานได้
                                width: 120,
                                child: Marquee(
                                  text: category['label'],
                                  style: TextStyle(
                                    color: selectedCategoryIndex == index ? Colors.white : Colors.grey,
                                  ),
                                  scrollAxis: Axis.horizontal,
                                  blankSpace: 20.0,
                                  velocity: 30.0,
                                  pauseAfterRound: const Duration(seconds: 1),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // ส่วนเนื้อหาของหน้า Home
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
