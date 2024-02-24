import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pair_me/Screen_Pages/chat.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/cubits/connected_user_data.dart';
import 'package:pair_me/cubits/message_user.dart';
import 'package:pair_me/cubits/remove_connect_user.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';
import '../helper/App_Colors.dart';

class Connection_Page extends StatefulWidget {
  const Connection_Page({super.key});

  @override
  State<Connection_Page> createState() => _Connection_PageState();
}

class _Connection_PageState extends State<Connection_Page> {
  ConnectedUsersCubit connectedUsersCubit = ConnectedUsersCubit();
  RemoveUserCubit removeUserCubit = RemoveUserCubit();
  MessageUserCubit messageUserCubit = MessageUserCubit();
  TextEditingController serarchbar = TextEditingController();
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectedUsersCubit = BlocProvider.of<ConnectedUsersCubit>(context);
    removeUserCubit = BlocProvider.of<RemoveUserCubit>(context);
    messageUserCubit = BlocProvider.of<MessageUserCubit>(context);
    setState(() {
      connectedUsersCubit.GetConnectedUsers();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(backgroundColor: Colors.transparent),
        body: SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Stack(
        children: [
          Background_Img(context),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                titleSpacing: 0,
                centerTitle: false,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.arrow_back_ios_rounded),
                  ),
                ),
                title: custom_header(text: "Connections"),
              ),
              body: SizedBox(
                height: screenHeight(context),
                width: screenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth(context, dividedBy: 30),
                        vertical: screenHeight(context, dividedBy: 200),
                      ),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          controller: serarchbar,
                          onChanged: (value) {
                            setState(() {
                              data = connectedUsersCubit.data
                                      .where((element) => element['name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(value))
                                      .toList() ??
                                  [];
                            });
                            print(data);
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(top: 3.5),
                            hintText: "Search...",
                            hintStyle: const TextStyle(fontSize: 15),
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7),
                              child: SvgPicture.asset(
                                "assets/Images/search.svg",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, dividedBy: 30),
                            vertical: screenHeight(context, dividedBy: 70)),
                        child: BlocBuilder<ConnectedUsersCubit,
                            ConnectedUsersState>(
                          builder: (context, state) {
                            print("state is $state");
                            if (state is ConnectedUsersSuccess) {
                              return connectedUsersCubit
                                      .connectedUsers.data!.isNotEmpty
                                  ? Text(
                                      "${connectedUsersCubit.connectedUsers.data?.length} Connection",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColor.skyBlue),
                                      maxLines: 2,
                                    )
                                  : const Text(
                                      "0 Connection",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColor.skyBlue),
                                      maxLines: 2,
                                    );
                            }
                            return const Text(
                              "0 Connection",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColor.skyBlue),
                              maxLines: 2,
                            );
                          },
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<ConnectedUsersCubit, ConnectedUsersState>(
                      builder: (context, state) {
                        if (state is ConnectedUsersSuccess) {
                          return connectedUsersCubit
                                      .connectedUsers.data!.isNotEmpty ||
                                  data.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                      physics: const ClampingScrollPhysics(),
                                      padding: EdgeInsets.only(
                                        bottom: screenHeight(context,
                                            dividedBy: 100),
                                      ),
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          // margin: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 15)),
                                          height: screenHeight(context,
                                              dividedBy: 8),
                                          width: screenHeight(context),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth(context,
                                                  dividedBy: 30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: serarchbar
                                                          .text.isNotEmpty
                                                      ? '${apis.baseurl}/${data[index]['profileImage'] ?? ''}'
                                                      : '${apis.baseurl}/${connectedUsersCubit.connectedUsers.data?[index].profileImage ?? ''}',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    height: screenHeight(
                                                        context,
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
                                                  errorWidget: (context, url,
                                                          error) =>
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
                                                      vertical: screenWidth(
                                                          context,
                                                          dividedBy: 40)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        serarchbar
                                                                .text.isNotEmpty
                                                            ? data[index]
                                                                ['name']
                                                            : connectedUsersCubit
                                                                    .connectedUsers
                                                                    .data?[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                      SizedBox(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 300),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 2.2),
                                                        child: const Text(
                                                            'Dis promethium, vei maximus gulag......',
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xffAAAAAA),
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Roboto')),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 2.2),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/Images/calendar.png",
                                                                width: screenWidth(
                                                                    context,
                                                                    dividedBy:
                                                                        40)),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(serarchbar
                                                                .text
                                                                .isNotEmpty
                                                                ?DateFormat('dd/MM/yyyy').format(DateTime.parse(data[index]['time']) ?? DateTime.now()) :
                                                                DateFormat('dd/MM/yyyy').format(connectedUsersCubit.connectedUsers.data?[index].time ?? DateTime.now()),
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xffAAAAAA),
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        'Roboto'))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                screenWidth(
                                                                    context,
                                                                    dividedBy:
                                                                        40)),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return SizedBox(
                                                                  height: screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          7.5),
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: screenHeight(context, dividedBy: 50)),
                                                                        child:
                                                                            Container(
                                                                          width: screenHeight(
                                                                              context,
                                                                              dividedBy: 15),
                                                                          height:
                                                                              7,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          removeUserCubit.AcceptNotification(id: serarchbar.text.isNotEmpty ? data[index]['id'] : connectedUsersCubit.connectedUsers.data?[index].id ?? '')
                                                                              .then(
                                                                            (value) {
                                                                              setState(() {
                                                                                connectedUsersCubit.GetConnectedUsers();
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(left: screenWidth(context, dividedBy: 50)),
                                                                          width:
                                                                              screenWidth(context),
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 10),
                                                                          decoration: const BoxDecoration(
                                                                              color: Colors.transparent,
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(16))),
                                                                          child: const Center(
                                                                              child: ListTile(
                                                                            title:
                                                                                Text("Remove Connection"),
                                                                            leading:
                                                                                Icon(Icons.delete),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: screenWidth(context, dividedBy: 30),
                                                                vertical: screenHeight(context, dividedBy: 50),
                                                            ),
                                                            child: SvgPicture.asset(
                                                                "assets/Images/more.svg",
                                                                height: screenHeight(context,dividedBy: 50),
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            100)),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            if(serarchbar.text.isNotEmpty){
                                                              messageUserCubit.AcceptNotification(
                                                                context,
                                                                id: data[index]['_id'],
                                                                name: data[index]['name'],
                                                                uid: connectedUsersCubit.connectedUsers.loginUserId ?? '',
                                                                img: data[index]['profileImage'],
                                                              );
                                                            } else {
                                                              messageUserCubit
                                                                  .AcceptNotification(
                                                                context,
                                                                id: connectedUsersCubit
                                                                    .connectedUsers
                                                                    .data?[index]
                                                                    .id ?? '',
                                                                name: connectedUsersCubit
                                                                    .connectedUsers
                                                                    .data?[index]
                                                                    .name ?? '',
                                                                uid: connectedUsersCubit
                                                                    .connectedUsers
                                                                    .loginUserId ??
                                                                    '',
                                                                img: connectedUsersCubit
                                                                    .connectedUsers
                                                                    .data?[index]
                                                                    .profileImage ??
                                                                    '',
                                                              );
                                                            }
                                                          },
                                                          child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                              horizontal: screenWidth(context, dividedBy: 50),
                                                          vertical: screenHeight(context, dividedBy: 40),
                                                        ),
                                                            child: SvgPicture.asset(
                                                                "assets/Images/message.svg",
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            25)),
                                                          ),
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
                                      itemCount: serarchbar.text.isNotEmpty
                                          ? data.length
                                          : connectedUsersCubit.connectedUsers
                                                  .data?.length ??
                                              0))
                              : Expanded(
                                  child: Center(child: NoMessage(context)));
                        }
                        if (state is ConnectedUsersLoading) {
                          return Expanded(child: customLoader());
                        }
                        if (state is ConnectedUsersError) {
                          return Expanded(
                              child: Center(child: NoMessage(context)));
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

Widget NoMessage(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: SvgPicture.asset(
          "assets/Images/connection.svg",
          width: screenWidth(context, dividedBy: 5),
          height: screenHeight(context, dividedBy: 10),
        ),
      ),
      SizedBox(
        height: screenHeight(context, dividedBy: 14),
      ),
      InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: screenHeight(context, dividedBy: 18),
            width: screenWidth(context, dividedBy: 1.7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromRGBO(250, 250, 250, 1),
                boxShadow: [
                  BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(
                      1,
                      1,
                    ),
                    blurRadius: 10,
                    spreadRadius: 0.0,
                  ),
                ]),
            child: Text(
              "Browse More Profile",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: Colors.black87.withOpacity(0.8)),
            ),
          ),
        ),
      ),
      // Custom_botton(context, text:"Browse More Profile", onTap:() {
      //
      // }, height: screenHeight(context, dividedBy: 20))
    ],
  );
}
