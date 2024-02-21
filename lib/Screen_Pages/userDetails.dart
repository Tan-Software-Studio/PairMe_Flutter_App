import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/image_page.dart';
import 'package:pair_me/Screen_Pages/view_pdf.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class UsersDetails extends StatefulWidget {
  String Name,role,country,Company,bio,file1,file2,file3;
  List list,looking_for;
  Function() onTap;
  UsersDetails({super.key, required this.list,required this.onTap,required this.country,required this.file1,required this.file3,required this.file2,required this.bio,required this.Company,required this.looking_for,required this.Name,required this.role});

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> with TickerProviderStateMixin {
  int pageViewIndex = 0;
  final TextEditingController _bio = TextEditingController();
  late VideoPlayerController _controller;
  bool file1 = false;
  bool file2 = false;
  bool file3 = false;
  String _file1 = '';
  String _file2 = '';
  String _file3 = '';

  List lookingFor = [];
  List list = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTT1VsnxGw7Phf_Giwuc126WClsqRK5hEVzGF8-8b4fWtE-CTqwBkTf1cBfxbXepxe8aug&usqp=CAU',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLWxpa2VkfDE3fHx8ZW58MHx8fHx8&w=1000&q=80',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS92eisuWOx3tEjeW14mT9ACVgXDwIRBGtnww&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdX029ohIUSygq9zirl9fSNBwSLqEOaKEYuw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCczoMDFIc77qVeqtnJ26h8Yen0WXNfyLTIg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJ0mv_NlCWaAPKCTefbXTZtdh3-d3CuK9GXA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeHt2GDofV5sNOaTrLarqU3XmMpTNXxaw9dg&usqp=CAU',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  getpath(var filePath){
    String fileName = path.basename(filePath);

    // Splitting the name using '-' as a separator
    List<String> nameParts = fileName.split('-');

    // Assuming the desired part is always at index 1
    return nameParts.length > 1 ? nameParts[1] : fileName;
  }
  GetData() async {
    print("looking for ==> ${widget.looking_for}");
    lookingFor = widget.looking_for;
    file1 = widget.file1.isNotEmpty ? true : false ;
    file2 = widget.file2.isNotEmpty ? true : false ;
    file3 = widget.file3.isNotEmpty ? true : false ;
    if(file1){
     _file1 = getpath(widget.file1);
    }
    if(file2){
      _file2 =  getpath(widget.file2);
    }
    if(file3){
      _file3 =  getpath(widget.file3);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      widget.list = widget.list.toSet().toList();
      widget.looking_for = widget.looking_for;
    });
    GetData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _bio.text = widget.bio;
      print("looking1 for ==> ${widget.looking_for}");
      GetData();
    });
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            Background_Img(context),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: false,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
               // automaticallyImplyLeading: false,
                titleSpacing: -5,
                leading: InkWell(
                    onTap: widget.onTap,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_back_ios_rounded),
                    )),
                title: Padding(
                  padding: EdgeInsets.only(left: screenWidth(context,dividedBy: 150)),
                  child: custom_header(text: "User Details"),
                ),
              ),
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                        items: widget.list
                            .map((e) => InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Image_Screen(
                                  image: "${apis.baseurl}/${widget.list[pageViewIndex]}", name: '',
                                );
                              },
                            ));
                          },
                          child: widget.list[pageViewIndex]
                              .toString()
                              .endsWith('.mp4')
                              ? video_play(videoUrl: "${apis.baseurl}/${widget.list[pageViewIndex]}")
                              : CachedNetworkImage(
                            imageUrl: "${apis.baseurl}/${widget.list[pageViewIndex]}",
                            imageBuilder: (context, imageProvider) =>  Container(
                              // margin: EdgeInsets.symmetric(
                              //     vertical: screenHeight(context,
                              //         dividedBy: 65)),
                              height: screenHeight(context,
                                  dividedBy: 3),
                              width: screenWidth(context,dividedBy: 1.015),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    //fit:BoxFit.cover
                                  )),
                            ),
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),

                        ))
                            .toList(),
                        options: CarouselOptions(
                          height: screenHeight(context, dividedBy: 2.5),
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          autoPlayCurve: Curves.linear,
                         animateToClosest: true,
                         // autoPlay: true,
                          onPageChanged: (index, re) {
                            pageViewIndex = index;
                            setState(() {});
                          },
                        )),
                    SizedBox(
                      height: screenHeight(context,dividedBy: 200),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 65)),
                      child: Center(
                        child: TabPageSelector(
                          controller: TabController(
                              vsync: this,
                              length: widget.list.length,
                              animationDuration:
                              const Duration(milliseconds: 300),
                              initialIndex: pageViewIndex),
                          color: AppColor.gray,
                          borderStyle: BorderStyle.none,
                          indicatorSize: 5,
                          selectedColor: AppColor.skyBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, dividedBy: 15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               Text(
                                widget.Name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1E1E1E),
                                    fontSize: 18,
                                    fontFamily: 'Roboto'),
                              ),
                              SizedBox(
                                width: screenWidth(context, dividedBy: 100),
                              ),
                              Image(
                                  width: screenHeight(context, dividedBy: 60),
                                  height: screenHeight(context, dividedBy: 60),
                                  image:
                                  const AssetImage('assets/Images/verified.png'))
                            ],
                          ),
                          if(widget.country.isNotEmpty)...[
                            Row(
                              children: [
                                Text(
                                  'City/Country'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.skyBlue,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  ': ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.skyBlue,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  widget.country,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.dropdownfont,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 500),
                            ),
                          ],
                          if(widget.role.isNotEmpty)...[
                            Row(
                              children: [
                                Text(
                                  'Role'.tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.skyBlue,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                                const Text(
                                  ': ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.skyBlue,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                                Text(
                                  widget.role,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.dropdownfont,
                                      fontSize: 14,
                                      fontFamily: 'Roboto'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 500),
                            ),
                          ],

                          widget.Company.isNotEmpty ? Row(
                            children: [
                               Text(
                                'Company'.tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.skyBlue,
                                    fontSize: 14,
                                    fontFamily: 'Roboto'),
                              ),
                               const Text(
                                ': ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.skyBlue,
                                    fontSize: 14,
                                    fontFamily: 'Roboto'),
                              ),
                              Text(
                                widget.Company,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dropdownfont,
                                    fontSize: 14,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ) : const SizedBox(),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50) ,
                          ),
                          custom_textfield_header(text: 'Looking for'),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 150),
                          ),
                          Wrap(
                            spacing: 5,
                            runSpacing: 8,
                            children: widget.looking_for
                                .map((e) => Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: const Color(0xff6D9Aff), width: 2.5),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth(context,dividedBy: 35),
                                        vertical: screenHeight(context,dividedBy: 250),
                                      ),
                                      child: Text(e,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'Roboto',color: AppColor.dropdownfont),),
                                    )))
                                .toList() ??
                                [],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          if(_bio.text.isNotEmpty)...[
                            custom_textfield_header(text: 'Bio'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 65),
                                  bottom: screenHeight(context, dividedBy: 100)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColor.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColor.fontgray,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                    blurRadius: 8,
                                    // spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    screenWidth(context, dividedBy: 25),
                                    vertical:
                                    screenHeight(context, dividedBy: 150)),
                                child: TextField(
                                  maxLength: 250,
                                  readOnly: true,
                                  minLines: 1,
                                  maxLines: 7,
                                  controller: _bio,
                                  cursorColor: AppColor.fontdarkgray,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColor.dropdownfont),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 50),
                            ),
                          ],
                          custom_textfield_header(text: 'Documents'),
                          file1 ? InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Pdfview( pdfUrl: '${apis.baseurl}/${widget.file1}',);
                              },));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                  screenHeight(context, dividedBy: 190)),
                              height: screenHeight(context, dividedBy: 15),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColor.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColor.fontgray,
                                    offset: Offset(
                                      1,
                                      1,
                                    ),
                                    blurRadius: 4,
                                    // spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                    screenHeight(context, dividedBy: 150),
                                    horizontal:
                                    screenWidth(context, dividedBy: 70)),
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                      screenWidth(context, dividedBy: 13),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/Images/uploadedfile.png'))),
                                    ),
                                    SizedBox(
                                      width:
                                      screenWidth(context, dividedBy: 50),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _file1,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Text(
                                          '96.47 KB ',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ) : const SizedBox(),
                          file2 ? InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Pdfview( pdfUrl: '${apis.baseurl}/${widget.file2}',);
                              },));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                  screenHeight(context, dividedBy: 190)),
                              height: screenHeight(context, dividedBy: 15),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColor.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColor.fontgray,
                                    offset: Offset(
                                      1,
                                      1,
                                    ),
                                    blurRadius: 4,
                                    // spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                    screenHeight(context, dividedBy: 150),
                                    horizontal:
                                    screenWidth(context, dividedBy: 70)),
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                      screenWidth(context, dividedBy: 13),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/Images/uploadedfile.png'))),
                                    ),
                                    SizedBox(
                                      width:
                                      screenWidth(context, dividedBy: 50),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _file2,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Text(
                                          '96.47 KB ',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ) : const SizedBox(),
                          file3 ? InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Pdfview( pdfUrl: '${apis.baseurl}/${widget.file3}',);
                              },));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                  screenHeight(context, dividedBy: 190)),
                              height: screenHeight(context, dividedBy: 15),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AppColor.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColor.fontgray,
                                    offset: Offset(
                                      1,
                                      1,
                                    ),
                                    blurRadius: 4,
                                    // spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                    screenHeight(context, dividedBy: 150),
                                    horizontal:
                                    screenWidth(context, dividedBy: 70)),
                                child: Row(
                                  children: [
                                    Container(
                                      width:
                                      screenWidth(context, dividedBy: 13),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/Images/uploadedfile.png'))),
                                    ),
                                    SizedBox(
                                      width:
                                      screenWidth(context, dividedBy: 50),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _file3,
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Text(
                                          '96.47 KB ',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ) : const SizedBox(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class video_play extends StatefulWidget {
  final String videoUrl;
  const video_play({super.key,required this.videoUrl});

  @override
  State<video_play> createState() => _video_playState();
}

class _video_playState extends State<video_play> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.setVolume(0);
         // _controller.play();
          _controller.setLooping(true); // Auto-repeating the video
        });
      });
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(
      //     vertical: screenHeight(context,
      //         dividedBy: 65)),
      height: screenHeight(context,
          dividedBy: 2.6),
      width: screenWidth(context,dividedBy: 1.015),
      decoration: const BoxDecoration(
        //  image: DecorationImage(image: NetworkImage(list[pageViewIndex]),fit: BoxFit.fill)
      ),
      child: Stack(
        children: [
          VideoPlayer(_controller),
          const Align(
            child: CircleAvatar(
              backgroundColor:
              Colors.white30,
              child: Icon(Icons.play_arrow_rounded),
            ),
          )
        ],
      ),
    );
  }
}
