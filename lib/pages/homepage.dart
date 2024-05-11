import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:volunteer_connection/features/newfeed/presentation/pages/news_feed.dart';
import 'package:volunteer_connection/features/notification/presentation/pages/notification_page.dart';
import 'package:volunteer_connection/features/setting/presentation/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Widget> items = [
    const NewFeeds(),
    // còn thiếU 1 page
    const NotificationPage(),
    const SettingPage(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: items[index],
      bottomNavigationBar: DotNavigationBar(
        marginR: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        paddingR: const EdgeInsets.only(bottom: 5, top: 5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000), // Màu đen với độ trong suốt 25%
            offset: Offset(4, 4), // Độ lệch theo trục x và y
            blurRadius: 40, // Độ mờ
          ),
        ],
        splashBorderRadius: 50,
        currentIndex: index,
        unselectedItemColor: Colors.black,
        onTap: (p0) {
          setState(() {
            index = p0;
          });
        },
        items: [
          DotNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            selectedColor: const Color(0xff0866FF),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.message),
            selectedColor: const Color(0xff0866FF),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.notifications),
            selectedColor: const Color(0xff0866FF),
          ),
          DotNavigationBarItem(
            icon: const Icon(Icons.settings),
            selectedColor: const Color(0xff0866FF),
          ),
        ],
      ),
    );
  }
}
