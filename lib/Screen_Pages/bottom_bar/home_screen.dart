import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/home.dart';
import 'package:pair_me/Screen_Pages/message.dart';
import 'package:pair_me/Screen_Pages/notification.dart';
import 'package:pair_me/Screen_Pages/profile.dart';
import 'package:pair_me/Screen_Pages/setting.dart';
import 'package:pair_me/Widgets/bottom_navigation_bar.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int indexdata = 0;
  int selectedIndex = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  bottomNavigationBarManage(
      selectedIndex: selectedIndex,
      bottomindex: indexdata,
      onTap: (index) {
        indexdata = index;
        selectedIndex = indexdata;
        setState(() {});
      },
    ),
      body: BottomNavBar(
          selectedIndex: selectedIndex,
          screenList: const [
            Home_Page(),
            Message_page(),
            Profile_page(),
            Setting_page(),
            Notification_page(),
          ],
          screenMange: indexdata),
    );
  }
}
