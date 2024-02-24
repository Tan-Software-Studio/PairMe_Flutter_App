import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pair_me/Modal/notification_modal.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/header_space.dart';
import 'package:pair_me/cubits/acceptORrejectnotification.dart';
import 'package:pair_me/cubits/clearAllNotification_cubit.dart';
import 'package:pair_me/cubits/notification_cubit.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({super.key});

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page> {
  NotificationCubit notificationCubit = NotificationCubit();
  UserNotification userNotification = UserNotification();
  AcceptorRejectCubit acceptorRejectCubit = AcceptorRejectCubit();
  ClearAllNotificationCubit clearAllNotificationCubit =
      ClearAllNotificationCubit();
  List ids = [];
  getData() {
    notificationCubit.GetNotification();
    int lenth = notificationCubit.userNotification.data?.length ?? 0;
    for (int i = 0; i <= lenth - 1; i++) {
      ids.add(notificationCubit.userNotification.data![i].sentBy?.id);
    }
    print("ids $ids");
    // print("ids ===> $ids");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    notificationCubit = BlocProvider.of<NotificationCubit>(context);
    acceptorRejectCubit = BlocProvider.of<AcceptorRejectCubit>(context);
    clearAllNotificationCubit =
        BlocProvider.of<ClearAllNotificationCubit>(context);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            Background_Img(context),
            SafeArea(
              child: Column(
                children: [
                  Header_Space(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, dividedBy: 15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        custom_header(text: 'Notification'),
                        GestureDetector(
                            onTap: () {
                              acceptorRejectCubit.RejectNotification(id: ids)
                                  .whenComplete(
                                () {
                                  getData();
                                },
                              );
                            },
                            child: Text(
                              'Clear all'.tr(),
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.skyBlue),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 70),
                  ),
                  Expanded(
                      child: BlocBuilder<NotificationCubit, NotificationState>(
                    builder: (context, state) {
                      if (state is NotificationLoading) {
                        return Expanded(child: Center(child: customLoader()));
                      }
                      if (state is NotificationError) {
                        return Center(
                          child: Container(
                            height: screenHeight(context, dividedBy: 5),
                            width: screenHeight(context, dividedBy: 5),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/Images/Nonotification.png'))),
                          ),
                        );
                      }
                      if (state is NotificationSuccess) {
                        return notificationCubit.userNotification.data ==
                                    null ||
                                notificationCubit
                                        .userNotification.data?.length ==
                                    0
                            ? Center(
                                child: Container(
                                  height: screenHeight(context, dividedBy: 5),
                                  width: screenHeight(context, dividedBy: 5),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/Images/Nonotification.png'))),
                                ),
                              )
                            : ListView.separated(
                                physics: const ClampingScrollPhysics(),
                                padding: EdgeInsets.only(
                                  bottom: screenHeight(context, dividedBy: 100),
                                ),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    // margin: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 15)),
                                    height: screenHeight(context, dividedBy: 8.67),
                                    width: screenHeight(context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth(context, dividedBy: 30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                "${apis.baseurl}/${notificationCubit.userNotification.data?[index].sentBy?.image}",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: screenHeight(context,
                                                  dividedBy: 15),
                                              width: screenHeight(context,
                                                  dividedBy: 15),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,

                                                  // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                                        radius: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        child: const Icon(
                                                            Icons.person)),
                                          ),
                                          SizedBox(
                                            width: screenWidth(context,
                                                dividedBy: 30),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: screenWidth(context,
                                                    dividedBy: 50)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  notificationCubit
                                                          .userNotification
                                                          .data?[index]
                                                          .sentBy
                                                          ?.userName ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Roboto'),
                                                ),
                                                SizedBox(
                                                  height: screenHeight(context,
                                                      dividedBy: 300),
                                                ),
                                                SizedBox(
                                                  width: screenWidth(context,
                                                      dividedBy: 2.2),
                                                  child: Text(
                                                      notificationCubit
                                                              .userNotification
                                                              .data?[index]
                                                              .message ??
                                                          '',
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xffAAAAAA),
                                                          height: 1.3,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Roboto')),
                                                ),
                                                SizedBox(
                                                  height: screenHeight(context,
                                                      dividedBy: 150),
                                                ),
                                                SizedBox(
                                                    width: screenWidth(context,
                                                        dividedBy: 2.2),
                                                    child: Text(
                                                        notificationCubit
                                                                .userNotification
                                                                .data?[index]
                                                                .time ??
                                                            '',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xffAAAAAA),
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Roboto'))),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: screenWidth(context,
                                                      dividedBy: 40)),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      acceptorRejectCubit
                                                          .RejectNotification(
                                                              id: [
                                                            notificationCubit
                                                                    .userNotification
                                                                    .data?[
                                                                        index]
                                                                    .sentBy
                                                                    ?.id ??
                                                                ''
                                                          ]).whenComplete(
                                                        () {
                                                          getData();
                                                        },
                                                      );
                                                    },
                                                    child: SvgPicture.asset(
                                                        "assets/Images/cancel.svg",
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 15)),
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth(context,
                                                        dividedBy: 25),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      acceptorRejectCubit.AcceptNotification(
                                                              id: notificationCubit
                                                                      .userNotification
                                                                      .data?[
                                                                          index]
                                                                      .sentBy
                                                                      ?.id ??
                                                                  '')
                                                          .whenComplete(
                                                        () {
                                                          getData();
                                                        },
                                                      );
                                                    },
                                                    child: SvgPicture.asset(
                                                        "assets/Images/accept.svg",
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 15)),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 0,
                                    thickness: 2,
                                    color: Color(0xffF5F5F5),
                                    // color: Colors.black12,
                                  );
                                },
                                itemCount: notificationCubit
                                        .userNotification.data?.length ??
                                    0);
                      }
                      return Expanded(child: Center(child: customLoader()));
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
