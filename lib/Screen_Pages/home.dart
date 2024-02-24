import 'package:animate_do/animate_do.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pair_me/Modal/alluserprofile.dart';
import 'package:pair_me/Screen_Pages/bottom_bar/home_screen.dart';
import 'package:pair_me/Screen_Pages/connections_page.dart';
import 'package:pair_me/Screen_Pages/filter.dart';
import 'package:pair_me/Screen_Pages/userDetails.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/header_space.dart';
import 'package:pair_me/cubits/Filter_user.dart';
import 'package:pair_me/cubits/connect_user.dart';
import 'package:pair_me/cubits/message_req_id.dart';
import 'package:pair_me/cubits/reject_user.dart';
import 'package:pair_me/cubits/show_all_users.dart';
import 'package:pair_me/cubits/undo_users_cubit.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:video_player/video_player.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> with TickerProviderStateMixin {
  TabController? tabController;
  late TutorialCoachMark tutorialCoachMark;
  SharedPrefsService prefsService = SharedPrefsService();
  final GlobalKey _key = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  bool filterData = false;
  String undoid = '';
  String bottonname = '';
  int pageViewIndex = 0;
  double height = 0;
  double height1 = 1.2;
  double fontsize = 70.0;
  double wight = 1;
  AllUsersDetailsCubit allUsersDetailsCubit = AllUsersDetailsCubit();
  AllUsersdetails allUsersdetails = AllUsersdetails();
  ConnectUserCubit connectUserCubit = ConnectUserCubit();
  RejectUserCubit rejectUserCubit = RejectUserCubit();
  UndoUsersCubit undoUsersCubit = UndoUsersCubit();
  FilterUserCubit filterUserCubit = FilterUserCubit();
  MsgReqbyIDCubit msgReqbyIDCubit = MsgReqbyIDCubit();
  late AppinioSwiperController controller = AppinioSwiperController();
  List looking_for = [];
  bool theEnd = false;
  List looking_for1 = [];
  List image = [];
  bool exchang = false;
  int ind = 0;
  bool swipeUp = false;
  bool swipeDown = false;
  bool month = true;
  final PageController _pageController = PageController();
  getData() async {
    allUsersdetails = (await allUsersDetailsCubit.GetAllUsersDetails())!;
    setState(() {});
  }
  getImage(int index) {
    if(filterData){
      if (filterUserCubit.filterUser.data?[index].last?.image != null) {
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo1 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo1)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo1 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo1);
        }
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo2 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo2)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo2 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo2);
        }
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo3 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo3)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo3 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo3);
        }
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo4 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo4)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo4 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo4);
        }
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo5 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo5)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo5 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo5);
        }
        if (filterUserCubit.filterUser.data?[index].last?.image?.photo6 == null &&
            image.contains(filterUserCubit.filterUser.data?[index].last?.image?.photo6)) {
          image = image;
        } else if (filterUserCubit.filterUser.data?[index].last?.image?.photo6 != null) {
          image.add(filterUserCubit.filterUser.data?[index].last?.image?.photo6);
        }
      }
      image = image.toSet().toList();
    } else {
      if (allUsersdetails.data?[index].last.image != null) {
        if (allUsersdetails.data?[index].last.image?.photo1 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo1)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo1 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo1);
         // int imagelength = allUsersdetails.data?.length  ?? 0;

        }
        if (allUsersdetails.data?[index].last.image?.photo2 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo2)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo2 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo2);
        }
        if (allUsersdetails.data?[index].last.image?.photo3 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo3)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo3 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo3);
        }
        if (allUsersdetails.data?[index].last.image?.photo4 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo4)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo4 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo4);
        }
        if (allUsersdetails.data?[index].last.image?.photo5 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo5)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo5 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo5);
        }
        if (allUsersdetails.data?[index].last.image?.photo6 == null &&
            image.contains(allUsersdetails.data?[index].last.image?.photo6)) {
          image = image;
        } else if (allUsersdetails.data?[index].last.image?.photo6 != null) {
          image.add(allUsersdetails.data?[index].last.image?.photo6);
        }
      }
      image = image.toSet().toList();
      //image1 = image1.toSet().toList();
    }
  }
  @override
  void initState() {
    // allUsersDetailsCubit.GetAllUsersDetails();
    allUsersDetailsCubit = BlocProvider.of<AllUsersDetailsCubit>(context);
    rejectUserCubit = BlocProvider.of<RejectUserCubit>(context);
    connectUserCubit = BlocProvider.of<ConnectUserCubit>(context);
    undoUsersCubit = BlocProvider.of<UndoUsersCubit>(context);
    filterUserCubit = BlocProvider.of<FilterUserCubit>(context);
    createTutorial();
    getData();
    //_controller = AnimationController(vsync: this);
    controller = AppinioSwiperController();
    Future.delayed(Duration.zero, showTutorial);
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Stack(
            children: [
              Background_Img(context),
              PageView(
                controller: _pageController,
                scrollBehavior: const MaterialScrollBehavior(),
                allowImplicitScrolling: true,
                onPageChanged: (value) {},
                physics: const ClampingScrollPhysics(),
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        Header_Space(context),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 20)),
                          child: SizedBox(
                            height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context),
                            child: Row(
                              children: [
                                Container(
                                  height: screenHeight(context, dividedBy: 30),
                                  width: screenWidth(context, dividedBy: 3.5),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Images/pairme.png'))),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return const Connection_Page();
                                    },));
                                  },
                                  child: SvgPicture.asset(
                                      "assets/Images/Vector.svg",
                                    height: screenHeight(context, dividedBy: 40),
                                    width: screenHeight(context, dividedBy: 40),
                                  ),
                                ),
                                SizedBox(width: screenWidth(context,dividedBy: 20),),
                                InkWell(
                                  onTap: () async {
                                   String refresh = await Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const Filter_page();
                                      },
                                    ));
                                   if(refresh == "refresh"){
                                     filterData = (await prefsService.getBoolData("filter"))!;
                                     ind = 0;
                                     pageViewIndex=0;
                                     image.clear();
                                     //image1.clear();
                                     setState(() {});
                                     print("hello");
                                   }
                                  },
                                  child: Container(
                                    key: _key,
                                    height:
                                        screenHeight(context, dividedBy: 40),
                                    width: screenHeight(context, dividedBy: 40),
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/Images/filter.png'))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context, dividedBy: 100),
                        ),
                        if (filterData ) BlocBuilder<FilterUserCubit, FilterUserState>(
                          builder: (context, state) {
                            if (state is FilterUserSuccess) {
                              return Expanded(
                                  child: theEnd ? Center(child: Text("No User!"),) : Stack(
                                    children: [
                                      AppinioSwiper(
                                        controller: controller,
                                      onEnd: () {
                                        print("hello to this is end");
                                        theEnd = true;
                                        setState(() {});
                                      },
                                        invertAngleOnBottomDrag: true,
                                        onCardPositionChanged: (position) {
                                          if (position.offset.direction > 0) {
                                            setState(() {
                                              swipeDown = true;
                                              height = height + 20;
                                              height1 = height1 >= 1.60
                                                  ? height1 + 0.001
                                                  : height1 + 0.004;
                                              height1 >= 1.50 && fontsize >= 20
                                                  ? fontsize = fontsize - 1
                                                  : fontsize = fontsize;
                                              print(height1);
                                              wight = height1 >= 1.60
                                                  ? wight + 0.001
                                                  : wight + 0.003;
                                              swipeUp = false;
                                              bottonname = "Connect";
                                            });
                                          }
                                          if (position.offset.direction < 0) {
                                            setState(() {
                                              swipeUp = true;
                                              bottonname = "Reject";
                                              height1 = height1 >= 1.60
                                                  ? height1 + 0.001
                                                  : height1 + 0.004;
                                              height1 >= 1.50 && fontsize >= 20
                                                  ? fontsize = fontsize - 1
                                                  : fontsize = fontsize;
                                              print(height1);
                                              wight = height1 >= 1.60
                                                  ? wight + 0.001
                                                  : wight + 0.003;
                                              // print("wight ===> $wight");
                                              height = height + 20;
                                              swipeDown = false;
                                            });
                                          }
                                        },
                                        onSwipeCancelled: (activity) {
                                          setState(() {
                                            image.clear();
                                            swipeUp = false;
                                            swipeDown = false;
                                            fontsize = 70;
                                            height1 = 1.2;
                                            wight = 1;
                                            height = 0;
                                          });
                                        },
                                        onSwipeEnd: (previousIndex, targetIndex, activity) {
                                          setState(() {
                                            undoid = filterUserCubit.filterUser.data?[ind].first?.id ?? '';
                                           height1 >= 1.51 ? print("undoid =======> $undoid") :print("Sorry =======> ");
                                            print("previousIndex  ===> $previousIndex");
                                            print("targetIndex  ===> $targetIndex");
                                            print("activity  ===> $activity");
                                            print("activity  ===> ${activity.end}");
                                            print("activity  ===> ${activity.direction}");
                                            activity.direction == AxisDirection.up
                                               ? rejectUserCubit.GetRejectUser(
                                               id: filterUserCubit.filterUser.data?[ind].first?.id ?? '').then((value) =>  pageViewIndex = 0)
                                               : connectUserCubit.GetConnectUser(
                                               id: filterUserCubit.filterUser.data?[ind].first?.id ?? '').then((value) =>  pageViewIndex = 0);
                                           ind >= filterUserCubit.filterUser.data!.length - 1 ? ind = ind : ind = targetIndex;
                                            height = 0;
                                            fontsize = 70;
                                            height1 = 1.2;
                                            wight = 1;
                                            swipeUp = false;
                                            swipeDown = false;
                                            image.clear();
                                          });
                                        },
                                        threshold: screenHeight(context, dividedBy: 4.5),
                                        maxAngle: screenHeight(context, dividedBy: 7),
                                        swipeOptions: const SwipeOptions.only(down: true, up: true),
                                        cardCount:filterUserCubit.filterUser.data?.length ?? 0,
                                        cardBuilder: (BuildContext context, int index) {
                                          getImage(index);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth(context,
                                                  dividedBy: 100),
                                            ),
                                            child: Container(
                                              // height: screenHeight(context),
                                              // width: screenWidth(context),
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))
                                                // BorderRadius.only(
                                                //     topRight: Radius.circular(20),
                                                //     topLeft: Radius.circular(20)
                                                // )
                                              ),
                                              child: Stack(
                                                children: [
                                                  swipeUp || swipeDown
                                                      ? image[pageViewIndex]
                                                      .toString()
                                                      .endsWith(
                                                      ".mp4") ||
                                                      image[pageViewIndex]
                                                          .toString()
                                                          .endsWith(".3gpp")
                                                      ? Center(
                                                        child: SizedBox(
                                                          height: screenHeight(
                                                          context,
                                                          dividedBy:
                                                          swipeDown ? 1.2 : height1),
                                                          width: screenWidth(
                                                          context,
                                                          dividedBy:
                                                          swipeDown ?1 :wight),
                                                          child: Stack(
                                                            children: [
                                                              VideoWidget(
                                                              videoUrl: "${apis.baseurl}/${image[pageViewIndex]}", play: false,),
                                                              Container(
                                                                  height: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                      swipeDown ? 1.2 : height1),
                                                                  width: screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                      swipeDown ?1 :wight),
                                                                  decoration: const BoxDecoration(
                                                                      gradient: LinearGradient(
                                                                          begin: Alignment
                                                                              .bottomCenter,
                                                                          end: Alignment.topCenter,
                                                                          colors: [
                                                                            Colors
                                                                                .black,
                                                                            Colors
                                                                                .black38
                                                                          ]),
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(20))),
                                                                  child: swipeUp
                                                                      ? Center(
                                                                    child:
                                                                    Text(
                                                                      "Skip"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          fontSize: fontsize,
                                                                          fontFamily: 'Roboto',
                                                                          fontWeight: FontWeight.w700,
                                                                          // color: AppColor.skyBlue
                                                                          color: AppColor.white),
                                                                    ),
                                                                  )
                                                                      : Center(
                                                                    child:
                                                                    Text(
                                                                      "Connect"
                                                                          .tr(),
                                                                      style: TextStyle(
                                                                          fontSize: fontsize,
                                                                          fontFamily: 'Roboto',
                                                                          fontWeight: FontWeight.w700,
                                                                          // color: AppColor.skyBlue
                                                                          color: AppColor.white),
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ) : Align(
                                                      alignment:
                                                      Alignment.topCenter,
                                                      child: SizedBox(
                                                        child: Stack(
                                                          children: [
                                                            CachedNetworkImage(
                                                              imageUrl:
                                                              "${apis.baseurl}/${image[pageViewIndex]}",
                                                              imageBuilder:
                                                                  (context,
                                                                  imageProvider) =>
                                                                  Container(
                                                                    height: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                       swipeDown?1.2: height1),
                                                                    width: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                        swipeDown ?1 :wight),
                                                                    decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                            imageProvider,
                                                                            fit: BoxFit
                                                                                .cover,
                                                                            filterQuality:
                                                                            FilterQuality
                                                                                .high),
                                                                        borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(20))),
                                                                  ),
                                                              placeholder:
                                                                  (context,
                                                                  url) =>
                                                                  Container(
                                                                    height:
                                                                    screenHeight(
                                                                        context),
                                                                    width:
                                                                    screenWidth(
                                                                        context),
                                                                    decoration: const BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                            topLeft:
                                                                            Radius.circular(
                                                                                20)),
                                                                        color: Colors
                                                                            .black),
                                                                    child:
                                                                    const Center(
                                                                      child:
                                                                      CircularProgressIndicator(
                                                                        color: AppColor
                                                                            .skyBlue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              errorWidget: (context,
                                                                  url,
                                                                  error) =>
                                                              const Icon(Icons
                                                                  .error),
                                                            ),
                                                            Container(
                                                                height: screenHeight(
                                                                    context,
                                                                    dividedBy:
                                                                   swipeDown ?1.2 : height1),
                                                                width: screenWidth(
                                                                    context,
                                                                    dividedBy:
                                                                    swipeDown ? 1 :wight),
                                                                decoration: const BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .bottomCenter,
                                                                        end: Alignment.topCenter,
                                                                        colors: [
                                                                          Colors
                                                                              .black,
                                                                          Colors
                                                                              .black38
                                                                        ]),
                                                                    borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(20))),
                                                                child: swipeUp
                                                                    ? Center(
                                                                  child:
                                                                  Text(
                                                                    "Skip"
                                                                        .tr(),
                                                                    style: TextStyle(
                                                                        fontSize: fontsize,
                                                                        fontFamily: 'Roboto',
                                                                        fontWeight: FontWeight.w700,
                                                                        // color: AppColor.skyBlue
                                                                        color: AppColor.white),
                                                                  ),
                                                                )
                                                                    : Center(
                                                                  child:
                                                                  Text(
                                                                    "Connect"
                                                                        .tr(),
                                                                    style: TextStyle(
                                                                        fontSize: fontsize,
                                                                        fontFamily: 'Roboto',
                                                                        fontWeight: FontWeight.w700,
                                                                        // color: AppColor.skyBlue
                                                                        color: AppColor.white),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ))
                                                      : image[pageViewIndex]
                                                      .toString()
                                                      .endsWith(
                                                      ".mp4") ||
                                                      image[pageViewIndex]
                                                          .toString()
                                                          .endsWith(".3gpp")
                                                      ? VideoWidget(
                                                      videoUrl: "${apis.baseurl}/${image[pageViewIndex]}", play: true,)
                                                      : CachedNetworkImage(
                                                    imageUrl: "${apis.baseurl}/${image[pageViewIndex]}",
                                                    imageBuilder: (context, imageProvider) =>
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image:
                                                                  imageProvider,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  filterQuality:
                                                                  FilterQuality
                                                                      .high),
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      20))),
                                                        ),
                                                    placeholder: (context, url) =>
                                                        Container(
                                                          height:
                                                          screenHeight(
                                                              context),
                                                          width: screenWidth(
                                                              context),
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  20)),
                                                              color: Colors
                                                                  .black),
                                                          child: const Center(
                                                            child:
                                                            CircularProgressIndicator(
                                                              color: AppColor
                                                                  .skyBlue,
                                                            ),
                                                          ),
                                                        ),
                                                    errorWidget: (context, url, error) => const Center(
                                                      child: Icon(
                                                          Icons.error),
                                                    ),
                                                  ),
                                                  swipeUp || swipeDown
                                                      ? const SizedBox()
                                                      : Align(
                                                    alignment:
                                                    Alignment.topCenter,
                                                    child: swipeUp == false &&
                                                        swipeDown == false
                                                        ? Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: screenHeight(
                                                              context,
                                                              dividedBy:
                                                              35)),
                                                      child:
                                                      TabPageSelector(
                                                        key: _key1,
                                                        controller: TabController(
                                                            vsync: this,
                                                            length: image.isNotEmpty ? image.length : 0,
                                                            initialIndex:
                                                            pageViewIndex),
                                                        color: AppColor
                                                            .gray,
                                                        borderStyle:
                                                        BorderStyle. none,

                                                        indicatorSize: 9,
                                                        selectedColor: AppColor.skyBlue,
                                                      ),
                                                    )
                                                        : const SizedBox(),
                                                  ),
                                                  swipeUp || swipeDown
                                                      ? const SizedBox()
                                                      : Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          overlayColor:
                                                          const MaterialStatePropertyAll(
                                                              Colors
                                                                  .transparent),
                                                          onTap: () {
                                                            setState(() {

                                                                  pageViewIndex >
                                                                      0
                                                                  ? pageViewIndex--
                                                                  : null;
                                                              image = image;
                                                            });
                                                          },
                                                          child: Container(
                                                            height:
                                                            screenHeight(
                                                                context),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          overlayColor:
                                                          const MaterialStatePropertyAll(
                                                              Colors
                                                                  .transparent),
                                                          onTap: () {
                                                            setState(() {
                                                              pageViewIndex >= image.length  ? null : pageViewIndex++;
                                                              pageViewIndex = pageViewIndex;
                                                              image = image;
                                                            });
                                                          },
                                                          child: Container(
                                                            height:
                                                            screenHeight(
                                                                context),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  swipeUp || swipeDown
                                                      ? const SizedBox()
                                                      : Align(
                                                    alignment: Alignment
                                                        .bottomCenter,
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      height: screenHeight(
                                                          context,
                                                          dividedBy: 4.1),
                                                      width: screenWidth(
                                                          context),
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                  20),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                  20)),
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .topCenter,
                                                              end: Alignment
                                                                  .bottomCenter,
                                                              colors: [
                                                                Colors
                                                                    .transparent,
                                                                Colors.black
                                                              ])),
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                            screenWidth(
                                                                context,
                                                                dividedBy:
                                                                20)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                      1.3),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        filterUserCubit.filterUser.data?[index].first?.name ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            color: AppColor.white,
                                                                            fontFamily: 'Roboto',
                                                                            fontSize: 25,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy: 100),
                                                                      ),
                                                                      Container(
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy: 45),
                                                                        width: screenHeight(
                                                                            context,
                                                                            dividedBy: 45),
                                                                        decoration:
                                                                        const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Images/verified.png"))),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Wrap(
                                                                  spacing: 7,
                                                                  direction: Axis
                                                                      .vertical,
                                                                  children: [
                                                                    filterUserCubit.filterUser.data?[index].first?.professionalDetails != null ?  Row(
                                                                      children: [
                                                                        Text(
                                                                          'Job Title'.tr(),
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        const Text(
                                                                          ": ",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          13 >= filterUserCubit.filterUser.data![index].first!.professionalDetails!.addRole!.length
                                                                              ? "${filterUserCubit.filterUser.data?[index].first?.professionalDetails?.addRole ?? ''}"
                                                                              : "${filterUserCubit.filterUser.data?[index].first?.professionalDetails?.addRole?.substring(0, 13) ?? ''}...",
                                                                          style: const TextStyle(
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    ) : SizedBox(),
                                                                    filterUserCubit.filterUser.data?[index].first?.businessaddress?.country != null ? Row(
                                                                      children: [
                                                                        Text(
                                                                          'City/Country'.tr(),
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        const Text(
                                                                          ": ",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          10 <= filterUserCubit.filterUser.data![index].first!.businessaddress!.country!.length
                                                                              ? "${allUsersdetails.data?[index].first.businessaddress?.country?.substring(0, 10) ?? ''}..."
                                                                              : filterUserCubit.filterUser.data?[ind].first?.businessaddress?.country ?? '',
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    ) : const SizedBox(),
                                                                    filterUserCubit.filterUser.data?[index].first?.professionalDetails?.companyName != null ?Row(
                                                                      children: [
                                                                        Text(
                                                                          'Company'.tr(),
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        const Text(
                                                                          ": ",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          15 <= filterUserCubit.filterUser.data![index].first!.professionalDetails!.companyName!.length
                                                                              ? "${filterUserCubit.filterUser.data?[index].first?.professionalDetails?.companyName?.substring(0, 13) ?? ''}..."
                                                                              : "${filterUserCubit.filterUser.data?[index].first?.professionalDetails?.companyName ?? ''}",
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: 'Roboto',
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ],
                                                                    ) : SizedBox(),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                Wrap(
                                                                  direction: Axis
                                                                      .vertical,
                                                                  spacing: 5,
                                                                  children: filterUserCubit.filterUser.data?[index].first?.lookingfor
                                                                      ?.map((e) => Container(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: AppColor.white
                                                                              //const Color(0xff6D9Aff)
                                                                              ,
                                                                              width: 2),
                                                                          borderRadius: BorderRadius.circular(20)),
                                                                      child: Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal: screenWidth(context, dividedBy: 45),
                                                                          vertical: screenHeight(context, dividedBy: 250),
                                                                        ),
                                                                        child: Text(
                                                                          e,
                                                                          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.7, fontFamily: 'Roboto', color: AppColor.white),
                                                                        ),
                                                                      )))
                                                                      .toList() ??
                                                                      [],
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                              screenHeight(
                                                                  context,
                                                                  dividedBy:
                                                                  100),
                                                            ),
                                                            const Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  swipeUp || swipeDown
                                                      ? Align(
                                                    alignment: swipeUp
                                                        ? Alignment
                                                        .bottomCenter
                                                        : Alignment.topCenter,
                                                    child: SizedBox(
                                                      height: height,
                                                    ),
                                                  )
                                                      : Align(
                                                    alignment:
                                                    Alignment.center,
                                                    child: SizedBox(
                                                      key: _key3,
                                                      // margin: EdgeInsets.only(
                                                      //     top: screenHeight(context,
                                                      //         dividedBy: 10)),
                                                      height: 0,
                                                      width: 0,
                                                    ),
                                                  ),
                                                  swipeUp || swipeDown
                                                      ? const SizedBox()
                                                      : Align(
                                                    alignment:
                                                    Alignment.topRight,
                                                    child: swipeUp == false &&
                                                        swipeDown == false
                                                        ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical:
                                                          screenHeight(
                                                              context,
                                                              dividedBy:
                                                              120),
                                                          horizontal:
                                                          screenHeight(
                                                              context,
                                                              dividedBy:
                                                              40),
                                                        ),
                                                        child: SizedBox(
                                                          height:
                                                          screenHeight(
                                                              context,
                                                              dividedBy:
                                                              17),
                                                          width:
                                                          screenHeight(
                                                              context,
                                                              dividedBy:
                                                              10),
                                                          // decoration: BoxDecoration(
                                                          //   color: Colors.red,
                                                          //     image: DecorationImage(
                                                          //         image: AssetImage(
                                                          //             users[index]
                                                          //             ['premium']),
                                                          //         fit: BoxFit
                                                          //             .cover,
                                                          //         filterQuality:
                                                          //         FilterQuality
                                                          //             .high)),
                                                          child: SvgPicture
                                                              .asset(
                                                              "assets/Images/premiumTag.svg"),
                                                        ))
                                                        : const SizedBox(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        cardBuilder1: (BuildContext context, int index) {
                                          final image1 = filterUserCubit.filterUser.data?[index].last?.image?.photo1 ?? '';
                                          return  CachedNetworkImage(
                                            imageUrl:
                                            "${apis.baseurl}/$image1",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          filterQuality:
                                                          FilterQuality.high),
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20))),
                                                ),
                                            placeholder: (context, url) =>
                                                Container(
                                                  height: screenHeight(context),
                                                  width: screenWidth(context),
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)),
                                                      color: Colors.black),
                                                  child: const Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                      color: AppColor.skyBlue,
                                                    ),
                                                  ),
                                                ),
                                            errorWidget:
                                                (context, url, error) =>
                                            const Icon(Icons.error),
                                          );
                                        },
                                      ),
                                      Align(
                                          alignment: swipeUp
                                              ? Alignment.bottomLeft
                                              : swipeDown
                                              ? Alignment.bottomRight
                                              : Alignment.bottomCenter,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: screenHeight(context,
                                                      dividedBy: 70),
                                                  horizontal: screenWidth(context,
                                                      dividedBy: 15)),
                                              child: swipeUp
                                                  ? FadeIn(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                animate: true,
                                                child: buttons(
                                                    context: context,
                                                    img:
                                                    "assets/Images/button3.svg",
                                                    onTap: () {},
                                                    buttonName: "Skip",
                                                    bool: month),
                                              )
                                                  : swipeDown
                                                  ? FadeIn(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                animate: true,
                                                child: buttons(
                                                    context: context,
                                                    img:
                                                    "assets/Images/button2.svg",
                                                    onTap: () {},
                                                    buttonName: "Connect",
                                                    bool: month),
                                              )
                                                  : bottonname == "Connect"
                                                  ? Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button3.svg",
                                                      onTap: () {
                                                        controller.swipeUp();
                                                        setState(
                                                                () {
                                                              bottonname = "Reject";
                                                            });
                                                      },
                                                      buttonName:
                                                      "Skip",
                                                      bool: month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button1.svg",
                                                      onTap: () {
                                                        msgReqbyIDCubit.AcceptNotification(context, id: filterUserCubit.filterUser.data?[ind].first?.id ?? '', name: filterUserCubit.filterUser.data?[ind].first?.name ?? '', image: filterUserCubit.filterUser.data?[ind].first?.profileImage ?? '', uid: filterUserCubit.filterUser.loginUserId ?? '');
                                                      },
                                                      buttonName:
                                                      "Chat",
                                                      bool: month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button4.svg",
                                                      onTap: () {
                                                        undoUsersCubit
                                                            .GetUndoUsers(
                                                            id: undoid)
                                                            .then(
                                                              (value) async {
                                                            setState(
                                                                    () {
                                                                  image =
                                                                      image;
                                                                });
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return const Home_screen();
                                                                  },
                                                                ));
                                                            setState(
                                                                    () {});
                                                          },
                                                        );
                                                      },
                                                      buttonName:
                                                      "Undo",
                                                      bool: month),
                                                ],
                                              )
                                                  : bottonname == "Reject"
                                                  ? Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button4.svg",
                                                      onTap: () {
                                                        undoUsersCubit.GetUndoUsers(
                                                            id: undoid)
                                                            .then(
                                                              (value) async {
                                                            setState(
                                                                    () {
                                                                  image =
                                                                      image;
                                                                });
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return const Home_screen();
                                                                  },
                                                                ));
                                                            setState(
                                                                    () {});
                                                          },
                                                        );
                                                      },
                                                      buttonName:
                                                      "Undo",
                                                      bool:
                                                      month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button1.svg",
                                                      onTap: () {
                                                        msgReqbyIDCubit.AcceptNotification(context, id: filterUserCubit.filterUser.data?[ind].first?.id ?? '', name: filterUserCubit.filterUser.data?[ind].first?.name ?? '', image: filterUserCubit.filterUser.data?[ind].first?.profileImage ?? '', uid: filterUserCubit.filterUser.loginUserId ?? '');
                                                      },
                                                      buttonName:
                                                      "Chat",
                                                      bool:
                                                      month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button2.svg",
                                                      onTap: () {

                                                            controller
                                                                .swipeDown();
                                                            setState(
                                                                    () {
                                                                  bottonname =
                                                                  "Connect";
                                                                });

                                                      },
                                                      buttonName:
                                                      "Connect",
                                                      bool:
                                                      month),
                                                ],
                                              )
                                                  : Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button3.svg",
                                                      onTap: () {

                                                            controller
                                                                .swipeUp();
                                                            setState(
                                                                    () {
                                                                  bottonname =
                                                                  "Reject";
                                                                });

                                                      },
                                                      buttonName:
                                                      "Skip",
                                                      bool:
                                                      month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button1.svg",
                                                      onTap: () {
                                                        msgReqbyIDCubit.AcceptNotification(context, id: filterUserCubit.filterUser.data?[ind].first?.id ?? '', name: filterUserCubit.filterUser.data?[ind].first?.name ?? '', image: filterUserCubit.filterUser.data?[ind].first?.profileImage ?? '', uid: filterUserCubit.filterUser.loginUserId ?? '');
                                                      },
                                                      buttonName:
                                                      "Chat",
                                                      bool:
                                                      month),
                                                  buttons(
                                                      context:
                                                      context,
                                                      img:
                                                      "assets/Images/button2.svg",
                                                      onTap: () {
                                                        controller.swipeDown();
                                                        setState(
                                                                () {
                                                              bottonname =
                                                              "Connect";
                                                            });
                                                      },
                                                      buttonName:
                                                      "Connect",
                                                      bool:
                                                      month),
                                                ],
                                              )))
                                    ],
                                  ));
                            }
                            if (state is FilterUserLoading) {
                              return Expanded(
                                  child: Center(child: customLoader()));
                            }
                            if (state is FilterUserError) {
                              return Center(
                                child: Text("Somthing went wrong ...."),
                              );
                            }
                            return const Center(
                              child: Text("Somthing went wrong ...."),
                            );
                          },
                        ) else BlocBuilder<AllUsersDetailsCubit, AllUsersDetailsState>(
                          builder: (context, state) {
                            if (state is AllUsersDetailsSuccess) {
                              return  Expanded(
                                  child: theEnd ? Center(child: Text("No User!"),) : Stack(
                                children: [
                                  AppinioSwiper(
                                    controller: controller,
                                    invertAngleOnBottomDrag: true,
                                    onEnd: () {
                                      print("hello to this is end");
                                      theEnd = true;
                                      setState(() {});
                                    },
                                    onCardPositionChanged: (position) {
                                      if (position.offset.direction > 0) {
                                        setState(() {
                                          swipeDown = true;
                                          height = height + 20;
                                          height1 = height1 >= 1.60
                                              ? height1 + 0.001
                                              : height1 + 0.004;
                                          height1 >= 1.50 && fontsize >= 20
                                              ? fontsize = fontsize - 1
                                              : fontsize = fontsize;
                                          print(height1);
                                          wight = height1 >= 1.60
                                              ? wight + 0.001
                                              : wight + 0.003;
                                          swipeUp = false;
                                          bottonname = "Connect";
                                        });
                                      }
                                      if (position.offset.direction < 0) {
                                        setState(() {
                                          swipeUp = true;
                                          bottonname = "Reject";
                                          height1 = height1 >= 1.60
                                              ? height1 + 0.001
                                              : height1 + 0.004;
                                          height1 >= 1.50 && fontsize >= 20
                                              ? fontsize = fontsize - 1
                                              : fontsize = fontsize;
                                          wight = height1 >= 1.60
                                              ? wight + 0.001
                                              : wight + 0.003;
                                          // print("wight ===> $wight");
                                          height = height + 20;
                                          swipeDown = false;
                                        });
                                      }
                                    },
                                    onSwipeCancelled: (activity) {
                                      bottonname = '';
                                      setState(() {
                                        image.clear();
                                        swipeUp = false;
                                        swipeDown = false;
                                        fontsize = 70;
                                        height1 = 1.2;
                                        wight = 1;
                                        height = 0;
                                      });
                                    },
                                    onSwipeBegin: (previousIndex, targetIndex, activity) {

                                    },
                                    onSwipeEnd: (previousIndex, targetIndex, activity) {
                                      setState(() {
                                        undoid = allUsersdetails.data?[ind].first.id ?? '';
                                        print("undoid =======> ${previousIndex}");
                                        print("undoid =======> ${targetIndex}");
                                        print("activity ===> $activity");
                                        print("activity ===> ${activity.direction.isHorizontal}");
                                        print("activity ===> ${activity.direction.isVertical}");
                                        print("activity ===> ${activity.direction.opposite}");
                                        print("activity ===> ${activity.direction.name}");
                                        print("activity ===> ${activity.animation}");
                                        print("activity ===> ${activity.currentOffset}");
                                        print("activity ===> ${activity.end}");
                                        print("activity ===> ${activity.begin}");
                                        if(activity == SwiperActivity){
                                          print("<====== --- hello --- ======>");
                                        }
                                          // activity.direction == AxisDirection.up
                                          //   ? rejectUserCubit.GetRejectUser(
                                          //   id: allUsersdetails
                                          //       .data?[ind].first.id ??
                                          //       '').then((value) =>  pageViewIndex = 0)
                                          //   : connectUserCubit.GetConnectUser(
                                          //   id: allUsersdetails
                                          //       .data?[ind].first.id ??
                                          //       '').then((value) =>  pageViewIndex = 0) ;
                                        ind >= allUsersdetails.data!.length - 1
                                            ? ind = ind
                                            : ind = targetIndex;
                                        height = 0;
                                        fontsize = 70;
                                        height1 = 1.2;
                                        wight = 1;
                                        swipeUp = false;
                                        swipeDown = false;
                                        image.clear();
                                      });
                                    },
                                    threshold: screenHeight(context, dividedBy: 4.5),
                                    maxAngle: screenHeight(context, dividedBy: 7),
                                    swipeOptions: const SwipeOptions.only(down: true, up: true),
                                    cardCount: allUsersdetails.data?.length ?? 0,
                                    cardBuilder: (BuildContext context, int index) {
                                      getImage(index);
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context,
                                              dividedBy: 100),
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))
                                              ),
                                          child: Stack(
                                            children: [
                                              swipeUp || swipeDown
                                                  ? image[pageViewIndex]
                                                  .toString()
                                                  .endsWith(
                                                  ".mp4") ||
                                                  image[pageViewIndex]
                                                      .toString()
                                                      .endsWith(".3gpp")
                                                  ? Center(
                                                child: SizedBox(
                                                  height: screenHeight(
                                                      context,
                                                      dividedBy:
                                                      swipeDown ? 1.2 : height1),
                                                  width: screenWidth(
                                                      context,
                                                      dividedBy:
                                                      swipeDown ?1 :wight),
                                                  child: Stack(
                                                    children: [
                                                      VideoWidget(
                                                        videoUrl: "${apis.baseurl}/${image[pageViewIndex]}", play: false,),
                                                      Container(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy:
                                                              swipeDown ? 1.2 : height1),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy:
                                                              swipeDown ?1 :wight),
                                                          decoration: const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  begin: Alignment
                                                                      .bottomCenter,
                                                                  end: Alignment.topCenter,
                                                                  colors: [
                                                                    Colors
                                                                        .black,
                                                                    Colors
                                                                        .black38
                                                                  ]),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(20))),
                                                          child: swipeUp
                                                              ? Center(
                                                            child:
                                                            Text(
                                                              "Skip"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                  fontSize: fontsize,
                                                                  fontFamily: 'Roboto',
                                                                  fontWeight: FontWeight.w700,
                                                                  // color: AppColor.skyBlue
                                                                  color: AppColor.white),
                                                            ),
                                                          )
                                                              : Center(
                                                            child:
                                                            Text(
                                                              "Connect"
                                                                  .tr(),
                                                              style: TextStyle(
                                                                  fontSize: fontsize,
                                                                  fontFamily: 'Roboto',
                                                                  fontWeight: FontWeight.w700,
                                                                  // color: AppColor.skyBlue
                                                                  color: AppColor.white),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ) : Align(
                                                  alignment:
                                                  Alignment.topCenter,
                                                  child: SizedBox(
                                                    child: Stack(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                          "${apis.baseurl}/${image[pageViewIndex]}",
                                                          imageBuilder:
                                                              (context,
                                                              imageProvider) =>
                                                              Container(
                                                                height: screenHeight(
                                                                    context,
                                                                    dividedBy:
                                                                    swipeDown?1.2: height1),
                                                                width: screenWidth(
                                                                    context,
                                                                    dividedBy:
                                                                    swipeDown ?1 :wight),
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image:
                                                                        imageProvider,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        filterQuality:
                                                                        FilterQuality
                                                                            .high),
                                                                    borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(20))),
                                                              ),
                                                          placeholder:
                                                              (context,
                                                              url) =>
                                                              Container(
                                                                height:
                                                                screenHeight(
                                                                    context),
                                                                width:
                                                                screenWidth(
                                                                    context),
                                                                decoration: const BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                        Radius.circular(
                                                                            20),
                                                                        topLeft:
                                                                        Radius.circular(
                                                                            20)),
                                                                    color: Colors
                                                                        .black),
                                                                child:
                                                                const Center(
                                                                  child:
                                                                  CircularProgressIndicator(
                                                                    color: AppColor
                                                                        .skyBlue,
                                                                  ),
                                                                ),
                                                              ),
                                                          errorWidget: (context,
                                                              url,
                                                              error) =>
                                                          const Icon(Icons
                                                              .error),
                                                        ),
                                                        Container(
                                                            height: screenHeight(
                                                                context,
                                                                dividedBy:
                                                                swipeDown ?1.2 : height1),
                                                            width: screenWidth(
                                                                context,
                                                                dividedBy:
                                                                swipeDown ? 1 :wight),
                                                            decoration: const BoxDecoration(
                                                                gradient: LinearGradient(
                                                                    begin: Alignment
                                                                        .bottomCenter,
                                                                    end: Alignment.topCenter,
                                                                    colors: [
                                                                      Colors
                                                                          .black,
                                                                      Colors
                                                                          .black38
                                                                    ]),
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(20))),
                                                            child: swipeUp
                                                                ? Center(
                                                              child:
                                                              Text(
                                                                "Skip"
                                                                    .tr(),
                                                                style: TextStyle(
                                                                    fontSize: fontsize,
                                                                    fontFamily: 'Roboto',
                                                                    fontWeight: FontWeight.w700,
                                                                    // color: AppColor.skyBlue
                                                                    color: AppColor.white),
                                                              ),
                                                            )
                                                                : Center(
                                                              child:
                                                              Text(
                                                                "Connect"
                                                                    .tr(),
                                                                style: TextStyle(
                                                                    fontSize: fontsize,
                                                                    fontFamily: 'Roboto',
                                                                    fontWeight: FontWeight.w700,
                                                                    // color: AppColor.skyBlue
                                                                    color: AppColor.white),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ))
                                                  : image[pageViewIndex]
                                                  .toString()
                                                  .endsWith(
                                                  ".mp4") ||
                                                  image[pageViewIndex]
                                                      .toString()
                                                      .endsWith(".3gpp")
                                                  ? VideoWidget(
                                                videoUrl: "${apis.baseurl}/${image[pageViewIndex]}", play: true,)
                                                  : CachedNetworkImage(
                                                imageUrl: "${apis.baseurl}/${image[pageViewIndex]}",
                                                imageBuilder: (context, imageProvider) =>
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image:
                                                              imageProvider,
                                                              fit: BoxFit
                                                                  .cover,
                                                              filterQuality:
                                                              FilterQuality
                                                                  .high),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20))),
                                                    ),
                                                placeholder: (context, url) =>
                                                    Container(
                                                      height:
                                                      screenHeight(
                                                          context),
                                                      width: screenWidth(
                                                          context),
                                                      decoration: const BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              20)),
                                                          color: Colors
                                                              .black),
                                                      child: const Center(
                                                        child:
                                                        CircularProgressIndicator(
                                                          color: AppColor
                                                              .skyBlue,
                                                        ),
                                                      ),
                                                    ),
                                                errorWidget: (context, url, error) => const Center(
                                                  child: Icon(
                                                      Icons.error),
                                                ),
                                              ),
                                              swipeUp || swipeDown
                                                  ? const SizedBox()
                                                  : Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      overlayColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors
                                                              .transparent),
                                                      onTap: () {
                                                        setState(() {
                                                          pageViewIndex >
                                                              0
                                                              ? pageViewIndex--
                                                              : null;
                                                          image = image;
                                                        });
                                                      },
                                                      child: Container(
                                                        height:
                                                        screenHeight(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      overlayColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors
                                                              .transparent),
                                                      onTap: () {
                                                        setState(() {
                                                          setState(() {
                                                            pageViewIndex >= image.length - 1 ? null : pageViewIndex++;
                                                          });
                                                          image = image;
                                                        });
                                                      },
                                                      child: Container(
                                                        height:
                                                        screenHeight(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              swipeUp || swipeDown
                                                  ? const SizedBox()
                                                  : Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: swipeUp == false &&
                                                              swipeDown == false
                                                          ? Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          35)),
                                                              child:
                                                                  TabPageSelector(
                                                                key: _key1,
                                                                controller: TabController(
                                                                    vsync: this,
                                                                    length: image.isEmpty ? 0 :image.length,
                                                                    initialIndex:
                                                                        pageViewIndex),
                                                                color: AppColor
                                                                    .gray,
                                                                borderStyle:
                                                                    BorderStyle
                                                                        .none,
                                                                indicatorSize:
                                                                    8,
                                                                selectedColor:
                                                                    AppColor
                                                                        .skyBlue,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                              swipeUp || swipeDown
                                                  ? const SizedBox()
                                                  : Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 4.1),
                                                        width: screenWidth(
                                                            context),
                                                        decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20)),
                                                            gradient: LinearGradient(
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter,
                                                                colors: [
                                                                  Colors
                                                                      .transparent,
                                                                  Colors.black
                                                                ])),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          20)),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          allUsersdetails.data?[index].first.name?.trim() ?? '',
                                                                          style: const TextStyle(
                                                                              color: AppColor.white,
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 25,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                        SizedBox(
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 100),
                                                                        ),
                                                                        Container(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 45),
                                                                          width: screenHeight(
                                                                              context,
                                                                              dividedBy: 45),
                                                                          decoration:
                                                                              const BoxDecoration(image: DecorationImage(image: AssetImage("assets/Images/verified.png"))),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row (
                                                                children: [
                                                                  Wrap(
                                                                    spacing: 7,
                                                                    direction: Axis
                                                                        .vertical,
                                                                    children: [
                                                                      allUsersdetails.data?[index].first.professionalDetails?.addRole != null ? Row(
                                                                        children: [
                                                                          Text(
                                                                            'Job Title'.tr(),
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          const Text(
                                                                            ": ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Text(
                                                                            13 >= allUsersdetails.data![index].first.professionalDetails!.addRole!.length
                                                                                ? "${allUsersdetails.data?[index].first.professionalDetails?.addRole ?? ''}"
                                                                                : "${allUsersdetails.data?[index].first.professionalDetails?.addRole?.substring(0, 13) ?? ''}...",
                                                                            style: const TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ) : const SizedBox(),
                                                                      allUsersdetails.data?[index].first.businessaddress?.country != null ? Row(
                                                                        children: [
                                                                          Text(
                                                                            'City/Country'.tr(),
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          const Text(
                                                                            ": ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Text(
                                                                            10 <= allUsersdetails.data![index].first.businessaddress!.country!.length
                                                                                ? "${allUsersdetails.data?[index].first.businessaddress?.country?.substring(0, 10) ?? ''}..."
                                                                                : "${allUsersdetails.data?[index].first.businessaddress?.country ?? ''}",
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ) : const SizedBox(),
                                                                      allUsersdetails.data?[index].first.professionalDetails?.companyName != null ? Row(
                                                                        children: [
                                                                          Text(
                                                                            'Company'.tr(),
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          const Text(
                                                                            ": ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Text(
                                                                            15 <= allUsersdetails.data![index].first.professionalDetails!.companyName!.length
                                                                                ? "${allUsersdetails.data?[index].first.professionalDetails?.companyName?.substring(0, 13) ?? ''}..."
                                                                                : "${allUsersdetails.data?[index].first.professionalDetails?.companyName ?? ''}",
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Roboto',
                                                                                fontWeight: FontWeight.w400,
                                                                                color: Colors.white),
                                                                          ),
                                                                        ],
                                                                      ) : const SizedBox(),
                                                                    ],
                                                                  ),
                                                                  const Spacer(),
                                                                  Wrap(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    spacing: 5,
                                                                    children: allUsersdetails
                                                                            .data?[index]
                                                                            .first
                                                                            .lookingfor
                                                                            ?.map((e) => Container(
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(
                                                                                        color: AppColor.white
                                                                                        //const Color(0xff6D9Aff)
                                                                                        ,
                                                                                        width: 2),
                                                                                    borderRadius: BorderRadius.circular(20)),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                    horizontal: screenWidth(context, dividedBy: 45),
                                                                                    vertical: screenHeight(context, dividedBy: 250),
                                                                                  ),
                                                                                  child: Text(
                                                                                    e,
                                                                                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12.7, fontFamily: 'Roboto', color: AppColor.white),
                                                                                  ),
                                                                                )))
                                                                            .toList() ??
                                                                        [],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            100),
                                                              ),
                                                              const Spacer(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              swipeUp || swipeDown
                                                  ? Align(
                                                      alignment: swipeUp
                                                          ? Alignment
                                                              .bottomCenter
                                                          : Alignment.topCenter,
                                                      child: SizedBox(
                                                        height: height,
                                                      ),
                                                    )
                                                  : Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        key: _key3,
                                                        // margin: EdgeInsets.only(
                                                        //     top: screenHeight(context,
                                                        //         dividedBy: 10)),
                                                        height: 0,
                                                        width: 0,
                                                      ),
                                                    ),
                                              swipeUp || swipeDown
                                                  ? const SizedBox()
                                                  : Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: swipeUp == false &&
                                                              swipeDown == false
                                                          ? Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            120),
                                                                horizontal:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            40),
                                                              ),
                                                              child: SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            17),
                                                                width:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            10),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/Images/premiumTag.svg"),
                                                              ))
                                                          : const SizedBox(),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    cardBuilder1: (BuildContext context, int index) {
                                     final image1 = allUsersdetails.data?[index].last.image?.photo1 ?? '';
                                      return CachedNetworkImage(
                                              imageUrl:
                                                  "${apis.baseurl}/${image1}",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        filterQuality:
                                                            FilterQuality.high),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: screenHeight(context),
                                                width: screenWidth(context),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    color: Colors.black),
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColor.skyBlue,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Center(child: Icon(Icons.error)),
                                            );
                                    },
                                  ),
                                  Align(
                                      alignment: swipeUp
                                          ? Alignment.bottomLeft
                                          : swipeDown
                                              ? Alignment.bottomRight
                                              : Alignment.bottomCenter,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenHeight(context,
                                                  dividedBy: 70),
                                              horizontal: screenWidth(context,
                                                  dividedBy: 15)),
                                          child: swipeUp
                                              ? FadeIn(
                                                  duration: const Duration(
                                                      milliseconds: 1000),
                                                  animate: true,
                                                  child: buttons(
                                                      context: context,
                                                      img:
                                                          "assets/Images/button3.svg",
                                                      onTap: () {},
                                                      buttonName: "Skip",
                                                      bool: month),
                                                )
                                              : swipeDown
                                                  ? FadeIn(
                                                      duration: const Duration(
                                                          milliseconds: 1000),
                                                      animate: true,
                                                      child: buttons(
                                                          context: context,
                                                          img:
                                                              "assets/Images/button2.svg",
                                                          onTap: () {},
                                                          buttonName: "Connect",
                                                          bool: month),
                                                    )
                                                  : bottonname == "Connect"
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            buttons(
                                                                context:
                                                                    context,
                                                                img:
                                                                    "assets/Images/button3.svg",
                                                                onTap: () {
                                                                  controller.swipeUp();
                                                                  setState(
                                                                          () {
                                                                        bottonname =
                                                                        "Reject";
                                                                      });
                                                                },
                                                                buttonName:
                                                                    "Skip",
                                                                bool: month),
                                                            buttons(
                                                                context:
                                                                    context,
                                                                img:
                                                                    "assets/Images/button1.svg",
                                                                onTap: () {
                                                                  msgReqbyIDCubit.AcceptNotification(context, id: allUsersdetails.data?[ind].first.id ?? '', name: allUsersdetails.data?[ind].first.name ?? '', image: allUsersdetails.data?[ind].first.profileImage ?? '', uid:allUsersdetails.loginUserId ?? '');
                                                                },
                                                                buttonName:
                                                                    "Chat",
                                                                bool: month),
                                                            buttons(
                                                                context:
                                                                    context,
                                                                img:
                                                                    "assets/Images/button4.svg",
                                                                onTap: () {
                                                                  undoUsersCubit
                                                                          .GetUndoUsers(
                                                                              id: undoid)
                                                                      .then(
                                                                    (value) async {
                                                                      setState(
                                                                          () {
                                                                        image =
                                                                            image;
                                                                      });
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                          return const Home_screen();
                                                                        },
                                                                      ));
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                  );
                                                                },
                                                                buttonName:
                                                                    "Undo",
                                                                bool: month),
                                                          ],
                                                        )
                                                      : bottonname == "Reject"
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button4.svg",
                                                                    onTap: () {
                                                                      undoUsersCubit.GetUndoUsers(
                                                                              id: undoid)
                                                                          .then(
                                                                        (value) async {
                                                                          setState(
                                                                              () {
                                                                            image =
                                                                                image;
                                                                          });
                                                                          Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                            builder:
                                                                                (context) {
                                                                              return const Home_screen();
                                                                            },
                                                                          ));
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                      );
                                                                    },
                                                                    buttonName:
                                                                        "Undo",
                                                                    bool:
                                                                        month),
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button1.svg",
                                                                    onTap: () {
                                                                      msgReqbyIDCubit.AcceptNotification(context, id: allUsersdetails.data?[ind].first.id ?? '', name: allUsersdetails.data?[ind].first.name ?? '', image: allUsersdetails.data?[ind].first.profileImage ?? '', uid:allUsersdetails.loginUserId ?? '');
                                                                    },
                                                                    buttonName:
                                                                        "Chat",
                                                                    bool:
                                                                        month),
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button2.svg",
                                                                    onTap: () {
                                                                      controller.swipeDown();
                                                                      setState(
                                                                              () {
                                                                            bottonname =
                                                                            "Connect";
                                                                          });
                                                                    },
                                                                    buttonName:
                                                                        "Connect",
                                                                    bool:
                                                                        month),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button3.svg",
                                                                    onTap: () {
                                                                      controller.swipeUp();
                                                                      setState(
                                                                              () {
                                                                            bottonname =
                                                                            "Reject";
                                                                          });
                                                                    },
                                                                    buttonName:
                                                                        "Skip",
                                                                    bool:
                                                                        month),
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button1.svg",
                                                                    onTap: () {
                                                                      print(allUsersdetails.loginUserId);
                                                                      msgReqbyIDCubit.AcceptNotification(context, id: allUsersdetails.data?[ind].first.id ?? '', name: allUsersdetails.data?[ind].first.name ?? '', image: allUsersdetails.data?[ind].first.profileImage ?? '', uid:allUsersdetails.loginUserId ?? '');
                                                                    },
                                                                    buttonName:
                                                                        "Chat",
                                                                    bool:
                                                                        month),
                                                                buttons(
                                                                    context:
                                                                        context,
                                                                    img:
                                                                        "assets/Images/button2.svg",
                                                                    onTap: () {
                                                                      controller.swipeDown();
                                                                      setState(
                                                                              () {
                                                                            bottonname =
                                                                            "Connect";
                                                                          });
                                                                      // connectUserCubit.GetConnectUser(
                                                                      //         id: allUsersdetails.data?[ind].first.id ?? '')
                                                                      //     .then(
                                                                      //   (value) {
                                                                      //
                                                                      //   },
                                                                      // );
                                                                    },
                                                                    buttonName:
                                                                        "Connect",
                                                                    bool:
                                                                        month),
                                                              ],
                                                            )))
                                ],
                              ));
                            }
                            if (state is AllUsersDetailsLoading) {
                              return Expanded(
                                  child: Center(child: customLoader()));
                            }
                            if (state is AllUsersDetailsError) {
                              return const Center(
                                child: Text("Somthing went wrong ...."),
                              );
                            }
                            return const Center(
                              child: Text("Somthing went wrong ...."),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  filterData ? BlocBuilder<FilterUserCubit, FilterUserState>(
                    builder: (context, state) {
                      if (state is FilterUserSuccess) {
                        return UsersDetails(
                          list: image,
                          onTap: () {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          country: filterUserCubit.filterUser.data?[ind].first?.businessaddress?.country ?? '',
                          file1:
                          filterUserCubit.filterUser.data?[ind].last?.file?.file1 ?? '',
                          file3:
                          filterUserCubit.filterUser.data?[ind].last?.file?.file3 ?? '',
                          file2:
                          filterUserCubit.filterUser.data?[ind].last?.file?.file2 ?? '',
                          bio: filterUserCubit.filterUser.data?[ind].last?.bio ?? '',
                          Company: filterUserCubit.filterUser.data?[ind].first
                                  ?.professionalDetails?.companyName ??
                              '',
                          looking_for:
                          filterUserCubit.filterUser.data?[ind].last?.lookingfor ?? [],
                          Name: filterUserCubit.filterUser.data?[ind].first?.name ?? '',
                          role: filterUserCubit.filterUser.data?[ind].first
                                  ?.professionalDetails?.addRole ??
                              '',
                        );
                      }
                      if (state is AllUsersDetailsLoading) {
                        return customLoader();
                      }
                      if (state is AllUsersDetailsError) {
                        return Center(
                          child: Text("Somthing went wrong ...."),
                        );
                      }
                      return Center(
                        child: Text("Somthing went wrong ...."),
                      );
                    },
                  ) :
                  BlocBuilder<AllUsersDetailsCubit, AllUsersDetailsState>(
                    builder: (context, state) {
                      if (state is AllUsersDetailsSuccess) {
                        return UsersDetails(
                          list: image,
                          onTap: () {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          country: allUsersdetails
                                  .data?[ind].first.businessaddress?.country ??
                              '',
                          file1:
                              allUsersdetails.data?[ind].last.file?.file1 ?? '',
                          file3:
                              allUsersdetails.data?[ind].last.file?.file3 ?? '',
                          file2:
                              allUsersdetails.data?[ind].last.file?.file2 ?? '',
                          bio: allUsersdetails.data?[ind].last.bio ?? '',
                          Company: allUsersdetails.data?[ind].first
                                  .professionalDetails?.companyName ??
                              '',
                          looking_for: allUsersdetails.data?[ind].first.lookingfor ?? [],
                          Name: allUsersdetails.data?[ind].first.name ?? '',
                          role: allUsersdetails.data?[ind].first
                                  .professionalDetails?.addRole ??
                              '',
                        );
                      }
                      if (state is AllUsersDetailsLoading) {
                        return customLoader();
                      }
                      if (state is AllUsersDetailsError) {
                        return const Center(
                          child: Text("Somthing went wrong ...."),
                        );
                      }
                      return const Center(
                        child: Text("Somthing went wrong ...."),
                      );
                    },
                  )
                ],
              )
            ],
          )),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  Future<void> createTutorial() async {
    showcase = await prefsService.getBoolData('showcase') ?? true;
    showcasetime = await prefsService.getIntData("showcasetime") ?? 1;
    if (showcase) {
      if (showcasetime >= 3) {
      } else {
        tutorialCoachMark = TutorialCoachMark(
          targets: _createTargets(),
          colorShadow: Colors.black12,
          textSkip: "SKIP",
          textStyleSkip: const TextStyle(
            fontFamily: 'Roboto',
            color: AppColor.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
          paddingFocus: 0,
          // opacityShadow: 0.5,
          // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          onFinish: () {
            print("finish");
            showcase = false;
            prefsService.setBoolData('showcase', showcase);
          },
          onClickTarget: (target) {
            print('onClickTarget: $target');
          },
          onClickTargetWithTapPosition: (target, tapDetails) {
            print("target: $target");
            print(
                "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
          },
          onClickOverlay: (target) {
            print('onClickOverlay: $target');
          },
          onSkip: () {
            showcase = false;
            prefsService.setBoolData('showcase', showcase);
            return true;
          },
        );
      }
    }
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        unFocusAnimationDuration: Duration.zero,
        identify: "keyBottomNavigation",
        keyTarget: _key,
        alignSkip: Alignment.topLeft,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Fillter users as your choice like Distance or gender or Country or State or City or Looking for that it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      color: AppColor.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        // unFocusAnimationDuration: Duration.zero,
        identify: "keyBottomNavigation1",
        keyTarget: _key1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Tap left or right to see different images",
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        keyTarget: _key3,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 0.0,
        // focusAnimationDuration: Duration.zero,
        borderSide: BorderSide.none,
        unFocusAnimationDuration: Duration.zero,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                children: [
                  Container(
                    height: screenHeight(context, dividedBy: 5),
                    width: screenHeight(context, dividedBy: 5),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage("assets/Images/SwipeUp-unscreen.gif"),
                            fit: BoxFit.cover)),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Swipe up to  Reject user",
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "swipe",
        keyTarget: _key3,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 0.0,
        // focusAnimationDuration: Duration.zero,
        borderSide: BorderSide.none,
        unFocusAnimationDuration: Duration.zero,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                children: [
                  Container(
                    height: screenHeight(context, dividedBy: 5),
                    width: screenHeight(context, dividedBy: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/Images/Swipe-unscreen.gif"),
                            fit: BoxFit.cover)),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        " Swipe Down to connect with a user ",
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "swipe",
        keyTarget: _key3,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 0.0,
        // focusAnimationDuration: Duration.zero,
        borderSide: BorderSide.none,
        unFocusAnimationDuration: Duration.zero,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                children: [
                  Container(
                    height: screenHeight(context, dividedBy: 5),
                    width: screenHeight(context, dividedBy: 5),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/Images/SwipeLeft-unscreen.gif"),
                            fit: BoxFit.cover)),
                  ),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        " Swipe Left to Show Users Full Details and images or videos ",
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }
}

Widget buttons(
    {required BuildContext context,
    required String img,
    required Function() onTap,
    required String buttonName,
    required bool bool}) {
  return Container(
    height: screenHeight(context, dividedBy: 25),
    width: screenWidth(context, dividedBy: bool ? 3.7 : 4.9),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: AppColor.Blue),
    child: InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            img,
            height: screenHeight(context,
                dividedBy: img.endsWith("button3.svg") ? 80 : 65),
            width: screenHeight(context,
                dividedBy: img.endsWith("button3.svg") ? 80 : 65),
          ),
          SizedBox(
            width: screenWidth(context, dividedBy: 90),
          ),
          Text(
            buttonName.tr(),
            style: const TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto'),
          )
        ],
      ),
    ),
  );
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;
bool play;
   VideoWidget({Key? key, required this.videoUrl,required this.play}) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
startvideo(){
  print("video ===> ${widget.videoUrl}");
  _controller = VideoPlayerController.network(widget.videoUrl)
    ..initialize().then((_) {
      print(widget.videoUrl);
      _controller.setVolume(0);
     widget.play ? _controller.play() : _controller.pause();
      _controller.setLooping(true); // Auto-repeating the video
      setState(() { });
    });
  setState(() {});
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      startvideo();
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: VideoPlayer(_controller),)
        : Container(
            height: screenHeight(context),
            width: screenWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColor.skyBlue,
              ),
            ),
          );
  }
}
