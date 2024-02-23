import 'package:flutter/material.dart';
import 'package:pair_me/Modal/user_profile_modal.dart';
import 'package:pair_me/Screen_Pages/home.dart';
import 'package:pair_me/Screen_Pages/notification.dart';
import 'package:pair_me/Screen_Pages/profile.dart';
import 'package:pair_me/Screen_Pages/setting.dart';
import 'package:pair_me/Widgets/bottom_navigation_bar.dart';
import 'package:pair_me/cubits/user_profile_cubit.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/zego_chat/call/call_function.dart';
import 'package:pair_me/zego_chat/home.dart';

import '../../zego_chat/zego_zimkit.dart';

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
    zegoUserLogin();
    super.initState();
    setState(() {});
  }

  UserDetailsCubit userDetailsCubit = UserDetailsCubit();
  UserProfile userProfile = UserProfile();

  zegoUserLogin() async {
    userProfile = await userDetailsCubit.GetUserdetails() ?? UserProfile();
    // SharedPreferences prefsService = await SharedPreferences.getInstance();
    // String userID = prefsService.getString("chatId") ?? '';
    // String userName = prefsService.getString("name") ?? '';
    // debugPrint("Data ----- ${userID} ${userName}");

    String userID = userProfile.data![0].id ?? '';
    String userName = userProfile.data![0].name ?? '';
    String userImage = "${apis.baseurl}/${userProfile.data?.first.image?.photo1}";

    debugPrint("zego userID --- $userID");
    debugPrint("zego userName --- $userName");
    debugPrint("zego userImage --- $userImage");

    await ZIMKit().connectUser(id: userID, name: userName, avatarUrl: userImage ?? "");
    await onUserLogin(userID, userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBarManage(
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
            MyHomePage(),
            // Message_page(),
            Profile_page(),
            Setting_page(),
            Notification_page(),
          ],
          screenMange: indexdata),
    );
  }
}
