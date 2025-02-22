import 'package:flutter/material.dart';

import 'Search_Page.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 100.0,
            leading: Padding(
              padding: const EdgeInsets.only(left:12.0),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.black,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical:9.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index){
                  final item = categories[index];
                  final bool isSelected = (index == selectedCategoryIndex);
                  return GestureDetector(
                    onTap: (){
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
                          if (item['icon'] != null) ...[
                            Icon(
                              item['icon'],
                              size: 16,
                              color: isSelected ? Colors.black : Colors.white,
                            ),
                            const SizedBox(width: 4),
                          ],
                          if (item['label'] != null)
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
                }
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
