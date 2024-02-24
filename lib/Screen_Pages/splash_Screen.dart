import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/bottom_bar/home_screen.dart';
import 'package:pair_me/Screen_Pages/language.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({super.key});

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  SharedPrefsService prefsService = SharedPrefsService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Splash_Timer();
  }
  Splash_Timer() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("token ==> $token");
    Authtoken = (await prefsService.getStringData("Authtoken"))!;
    Timer(const Duration(seconds: 1), () async {
      if (Authtoken.length > 1) {
        setState(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home_screen()),
                  (route) => false);
        });
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Language_Screen(),), (route) => false);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context),
      width: screenWidth(context),
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/logo.png'),fit: BoxFit.cover)),
    );
  }
}
