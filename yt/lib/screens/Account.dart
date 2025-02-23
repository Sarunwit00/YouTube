import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final String _userName = "Sarunwit Pibul";
  final String _userEmail = "sarunwit@gmail.com";

  // ข้อมูลสำหรับ ListView แนวนอน
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.account_circle_outlined, 'label': 'Switch accounts'},
    {'icon': Icons.g_mobiledata_outlined,   'label': 'Switch accounts'},
    {'icon': Icons.masks,                  'label': 'Turn on incognito mode'},
    {'icon': Icons.share,                  'label': 'Share channel'},
  ];

  // เก็บ index ของ item ที่ถูกกดอยู่ (ถ้าไม่มีการกดจะเป็น null)
  int? pressedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _userEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final item = categories[index];
                    
                    final bool isPressed = (index == pressedIndex);

                    return GestureDetector(
                      
                      onTapDown: (_) {
                        setState(() {
                          pressedIndex = index;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          pressedIndex = null;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          pressedIndex = null;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isPressed ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isPressed ? Colors.white : Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            if (item['icon'] != null) ...[
                              Icon(
                                item['icon'],
                                size: 16,
                                color: isPressed ? Colors.black : Colors.white,
                              ),
                              const SizedBox(width: 4),
                            ],
                            if (item['label'] != null)
                              Text(
                                item['label'],
                                style: TextStyle(
                                  color:
                                      isPressed ? Colors.black : Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('My video'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.school_outlined),
                title: const Text('Course'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movies'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.youtube),
                title: const Text('Apply for YouTube Premium'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.insert_chart_outlined),
                title: const Text('Time spent viewing'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help and feedback'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
