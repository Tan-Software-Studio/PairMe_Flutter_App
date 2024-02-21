import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:video_player/video_player.dart';

class Image_Screen extends StatefulWidget {
  String image,name;
  Image_Screen({super.key, required this.image,required this.name});

  @override
  State<Image_Screen> createState() => _Image_ScreenState();
}

class _Image_ScreenState extends State<Image_Screen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.image),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),)
      ..initialize().then((_) {
        print("Hello Prit:- ${widget.image}");
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: widget.image.endsWith('.mp4') || widget.image.endsWith('.3gpp') || widget.name == "video"
          ? _controller!.value.isInitialized
              ? SizedBox(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  child: Stack(
                    children: [
                      VideoPlayer(
                        _controller!,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColor.white,
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.white30,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller!.value.isPlaying
                                        ? _controller?.pause()
                                        : _controller?.play();
                                  });
                                },
                                child: Icon(
                                  _controller!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.white,
                        )),
                    Expanded(child: Center(child: customLoader()))
                  ],
                )
          : InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: widget.image,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.image),
                          //  fit: BoxFit.fitHeight,
                            filterQuality: FilterQuality.high)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColor.white,
                            ))
                      ],
                    ),
                  );
                },
                placeholder: (context, url) => Expanded(child: customLoader()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
    );
  }
}
