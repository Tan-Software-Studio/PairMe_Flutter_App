import 'package:flutter/material.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool  mic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          color: AppColor.whiteskyBlue,
          child:     Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight(context, dividedBy: 20),
                  left: screenWidth(context, dividedBy: 15),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_new,color: AppColor.white,)
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: screenHeight(context,dividedBy: 4),
                width: screenWidth(context),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 40)),
                            height: screenHeight(context,dividedBy: 13),
                            width: screenHeight(context,dividedBy: 13),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle
                            ),
                            child:  Center(
                              child: Image(
                                image:  const AssetImage('assets/Images/Endcall.png'),
                                height: screenHeight(context,dividedBy: 20),
                                width: screenHeight(context,dividedBy: 20),
                                color: AppColor.white,
                              ),
                            ),
                          )

                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: screenWidth(context,dividedBy: 20),
                          bottom: screenHeight(context,dividedBy: 80)
                        ),
                        height: screenHeight(context,dividedBy: 4.5),
                        width: screenWidth(context,dividedBy: 3),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                    right: screenWidth(context,dividedBy: 7),
                    left: screenWidth(context,dividedBy: 7),
                    bottom: screenHeight(context,dividedBy: 15),
                    top: screenHeight(context,dividedBy: 25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/Images/cameraposition.png'),
                      height: screenHeight(context,dividedBy: 20),
                      width: screenHeight(context,dividedBy: 20),
                      color: AppColor.white,
                    ),
                    Image(
                      image: const AssetImage('assets/Images/chaticon.png'),
                      height: screenHeight(context,dividedBy: 20),
                      width: screenHeight(context,dividedBy: 20),
                      color: AppColor.white,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mic = !mic;
                        });
                      },
                      child: Image(
                        image: mic ? const AssetImage('assets/Images/mic.png') :const AssetImage('assets/Images/micoff.png'),
                        height: screenHeight(context,dividedBy: 20),
                        width: screenHeight(context,dividedBy: 20),
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
