import 'package:flutter/material.dart';
import '../widgets/custom_sliverbar.dart';
//import 'Search_Page.dart';

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
          
        ],
      ),
    );
  }
}
