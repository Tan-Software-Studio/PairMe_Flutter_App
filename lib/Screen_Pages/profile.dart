import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Modal/user_profile_modal.dart';
import 'package:pair_me/Screen_Pages/edit_profile.dart';
import 'package:pair_me/Screen_Pages/location.dart';
import 'package:pair_me/Screen_Pages/premium_membership.dart';
import 'package:pair_me/Screen_Pages/view_pdf.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/cubits/user_profile_cubit.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:path/path.dart' as path;

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  final TextEditingController _bio = TextEditingController();
  UserDetailsCubit userDetailsCubit = UserDetailsCubit();
  UserProfile userProfile = UserProfile();
  int length = 0;
  bool file1 = false;
  bool file2 = false;
  bool file3 = false;
  String _file1 = '';
  String _file2 = '';
  String _file3 = '';

  getpath(var filePath) {
    String fileName = path.basename(filePath);

    // Splitting the name using '-' as a separator
    List<String> nameParts = fileName.split('-');

    // Assuming the desired part is always at index 1
    return nameParts.length > 1 ? nameParts[1] : fileName;
  }

  GetData() async {
    userProfile = await userDetailsCubit.GetUserdetails() ?? UserProfile();
    print("user profile ===> $userProfile");
    length =
        userProfile.data?.first.professionalDetails?.companyName?.length ?? 0;
    _bio.text = userProfile.data?.first.bio ?? '';
    file1 = userProfile.data?.first.file?.file1?.isNotEmpty ?? false;
    file2 = userProfile.data?.first.file?.file2?.isNotEmpty ?? false;
    file3 = userProfile.data?.first.file?.file3?.isNotEmpty ?? false;
    if (file1) {
      _file1 = getpath(userProfile.data?.first.file?.file1 ?? '');
    }
    if (file2) {
      _file2 = getpath(userProfile.data?.first.file?.file2 ?? '');
    }
    if (file3) {
      _file3 = getpath(userProfile.data?.first.file?.file3 ?? '');
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetailsCubit = BlocProvider.of<UserDetailsCubit>(context);
    GetData();
    setState(() {});
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
            Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  centerTitle: false,
                  title: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 30)),
                    child: custom_header(text: "Profile"),
                  ),
                ),
                body: BlocBuilder<UserDetailsCubit, UserDetailsState>(
                  builder: (context, state) {
                    print("stste  ===> $state");
                    if (state is UserDetailsLoading) {
                      return customLoader();
                    }
                    if (state is UserDetailsSuccess) {
                      return SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // height: screenHeight(context, dividedBy: 12),
                                width: screenWidth(context),
                                child: Row(
                                  children: [
                                    Container(
                                      height: screenHeight(context,
                                          dividedBy: 11.5),
                                      width: screenHeight(context,
                                          dividedBy: 11.5),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${apis.baseurl}/${userProfile.data?.first.image?.photo1}"
                                                  //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMVP7dBLbLgjKD8lHdaMcQz7XBf2E22eParQ&usqp=CAU'
                                                  ),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width:
                                          screenWidth(context, dividedBy: 35),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          userProfile.data?[0].name ?? '',
                                          style: const TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        userProfile
                                                    .data
                                                    ?.first
                                                    .professionalDetails
                                                    ?.addRole !=
                                                null
                                            ? Row(
                                                children: [
                                                  Text(
                                                    'Role'.tr(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            AppColor.skyBlue),
                                                  ),
                                                  const Text(
                                                    ' : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            AppColor.skyBlue),
                                                  ),
                                                  Text(
                                                    userProfile
                                                            .data
                                                            ?.first
                                                            .professionalDetails
                                                            ?.addRole ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color: AppColor
                                                            .dropdownfont),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                        userProfile
                                                    .data
                                                    ?.first
                                                    .professionalDetails
                                                    ?.companyName !=
                                                null
                                            ? Row(
                                                children: [
                                                  Text(
                                                    'Company'.tr(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            AppColor.skyBlue),
                                                  ),
                                                  const Text(
                                                    ' : ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color:
                                                            AppColor.skyBlue),
                                                  ),
                                                  Text(
                                                    length >= 10
                                                        ? "${userProfile.data?.first.professionalDetails?.companyName?.substring(0, 10)}..."
                                                        : userProfile
                                                                .data
                                                                ?.first
                                                                .professionalDetails
                                                                ?.companyName ??
                                                            '',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                        fontFamily: 'Roboto',
                                                        color: AppColor
                                                            .dropdownfont),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            String refresh =
                                                await Navigator.push(context,
                                                    MaterialPageRoute(
                                              builder: (context) {
                                                return Edit_Profile();
                                              },
                                            ));
                                            if (refresh == "refresh") {
                                              GetData();
                                            }
                                          },
                                          child: Container(
                                            height: screenHeight(context,
                                                dividedBy: 60),
                                            width: screenHeight(context,
                                                dividedBy: 60),
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/Images/edit.png'))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight(context,
                                              dividedBy: 30),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return const Location_page();
                                              },
                                            ));
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: screenHeight(context,
                                                  dividedBy: 30),
                                              // width: screenWidth(context, dividedBy: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColor.Blue
                                                  // gradient: const LinearGradient(colors: [
                                                  //   AppColor.skyBlue,
                                                  //   AppColor.whiteskyBlue
                                                  // ]),
                                                  ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth(
                                                        context,
                                                        dividedBy: 25)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: screenHeight(
                                                          context,
                                                          dividedBy: 60),
                                                      width: screenHeight(
                                                          context,
                                                          dividedBy: 60),
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/Images/location.png"))),
                                                    ),
                                                    // Image(
                                                    //   color: AppColor.white,
                                                    //   image: const AssetImage(
                                                    //       'assets/Images/location.png'),
                                                    //   height: screenHeight(context,
                                                    //       dividedBy: 60),
                                                    //   width: screenHeight(context,
                                                    //       dividedBy: 60),
                                                    // ),
                                                    SizedBox(
                                                      width: screenWidth(
                                                          context,
                                                          dividedBy: 150),
                                                    ),
                                                    Text(
                                                      'Location'.tr(),
                                                      style: const TextStyle(
                                                          color: AppColor.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Roboto'),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                color: Color(0xffF5F5F5),
                              ),
                              custom_textfield_header(text: 'Intermediate'),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        screenHeight(context, dividedBy: 70),
                                    top: screenHeight(context, dividedBy: 100)),
                                child: LinearPercentIndicator(
                                    width:
                                        screenWidth(context, dividedBy: 1.25),
                                    lineHeight: 7.0,
                                    percent:  userProfile.data?.first.score == 1
                                        ? 0.2
                                        : userProfile.data?.first.score == 2
                                            ? 0.4
                                            : userProfile.data?.first.score == 3
                                                ? 0.6
                                                : userProfile
                                                            .data?.first.score ==
                                                        4
                                                    ? 0.8
                                                    : 1,
                                    barRadius: const Radius.circular(20),
                                    backgroundColor: Colors.grey.shade200,
                                    trailing: custom_text(
                                        text:
                                            "${userProfile.data?.first.score ?? 5}/5",
                                        color: const Color(0xff434343)),
                                    // progressColor: Colors.blue,
                                    linearGradient: const LinearGradient(
                                        colors: [
                                          AppColor.skyBlue,
                                          AppColor.whiteskyBlue
                                        ])),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 330.0),
                              //   child: custom_text(text: "2/5", color: Color(0xff434343)),
                              // ),
                              if (_bio.text.isNotEmpty) ...[
                                custom_textfield_header(text: 'Bio'),
                                Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          screenHeight(context, dividedBy: 100),
                                      bottom:
                                          screenHeight(context, dividedBy: 70)),
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
                                        vertical: screenHeight(context,
                                            dividedBy: 150)),
                                    child: TextField(
                                      controller: _bio,
                                      maxLength: 250,
                                      readOnly: true,
                                      minLines: 1,
                                      maxLines: 7,
                                      cursorColor: AppColor.fontdarkgray,
                                      style: const TextStyle(
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff434343)),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        // hintText: 'Enter some words of your Profile',
                                        // hintStyle: TextStyle(
                                        //     fontFamily: 'Roboto',
                                        //     fontWeight: FontWeight.w400,
                                        //     fontSize: 15)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                             file1 ?  custom_textfield_header(text: 'My Documents') : const SizedBox(),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 150),
                              ),
                              file1
                                  ? InkWell(
                                      onTap: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Pdfview(
                                              pdfUrl:
                                                  '${apis.baseurl}/${userProfile.data?.first.file?.file1}',
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight(context,
                                                dividedBy: 190)),
                                        height: screenHeight(context,
                                            dividedBy: 15),
                                        width: screenWidth(context),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 150),
                                              horizontal: screenWidth(context,
                                                  dividedBy: 70)),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: screenWidth(context,
                                                    dividedBy: 13),
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/Images/uploadedfile.png'))),
                                              ),
                                              SizedBox(
                                                width: screenWidth(context,
                                                    dividedBy: 50),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _file1.trim(),
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '96.47 KB ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              file2
                                  ? InkWell(
                                      onTap: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Pdfview(
                                              pdfUrl:
                                                  '${apis.baseurl}/${userProfile.data?.first.file?.file2}',
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight(context,
                                                dividedBy: 190)),
                                        height: screenHeight(context,
                                            dividedBy: 15),
                                        width: screenWidth(context),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 150),
                                              horizontal: screenWidth(context,
                                                  dividedBy: 70)),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: screenWidth(context,
                                                    dividedBy: 13),
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/Images/uploadedfile.png'))),
                                              ),
                                              SizedBox(
                                                width: screenWidth(context,
                                                    dividedBy: 50),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _file2,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontFamily: 'Roboto',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Text(
                                                      '96.47 KB ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              file3
                                  ? InkWell(
                                      onTap: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return Pdfview(
                                              pdfUrl:
                                                  '${apis.baseurl}/${userProfile.data?.first.file?.file3}',
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight(context,
                                                dividedBy: 190)),
                                        height: screenHeight(context,
                                            dividedBy: 15),
                                        width: screenWidth(context),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 150),
                                              horizontal: screenWidth(context,
                                                  dividedBy: 70)),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: screenWidth(context,
                                                    dividedBy: 13),
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/Images/uploadedfile.png'))),
                                              ),
                                              SizedBox(
                                                width: screenWidth(context,
                                                    dividedBy: 50),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _file3,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          fontFamily: 'Roboto',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Text(
                                                      '96.47 KB ',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              userProfile.data?.first.address != null
                                  ? SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 100),
                                    )
                                  : const SizedBox(),
                              userProfile.data?.first.address != null
                                  ? custom_textfield_header(text: 'Address')
                                  : const SizedBox(),
                              userProfile.data?.first.address != null
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: screenHeight(context,
                                              dividedBy: 100),
                                          bottom: screenHeight(context,
                                              dividedBy: 70)),
                                      alignment: Alignment.centerLeft,
                                      // height: screenHeight(context,dividedBy: 17),
                                      width:
                                          screenWidth(context, dividedBy: 1.15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
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
                                          ]),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth(context,
                                                dividedBy: 30),
                                            vertical: screenHeight(context,
                                                dividedBy: 100)),
                                        child: Text(
                                          "${userProfile.data?.first.address?.address}, ${userProfile.data?.first.address?.city}, ${userProfile.data?.first.address?.state}, ${userProfile.data?.first.address?.country} - ${userProfile.data?.first.address?.zipCode}",
                                          style: const TextStyle(
                                              color: Color(0xff434343),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto"),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              if (userProfile.data?.first.professionalDetails !=
                                  null) ...[
                                custom_textfield_header(
                                    text: 'Business Experience'),
                                Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          screenHeight(context, dividedBy: 100),
                                      bottom:
                                          screenHeight(context, dividedBy: 70)),
                                  alignment: Alignment.centerLeft,
                                  height: screenHeight(context, dividedBy: 20),
                                  width: screenWidth(context, dividedBy: 1.15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
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
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth(context, dividedBy: 30),
                                        vertical: screenHeight(context,
                                            dividedBy: 100)),
                                    child: Text(
                                      userProfile
                                              .data
                                              ?.first
                                              .professionalDetails
                                              ?.businessExperience ??
                                          '',
                                      style: TextStyle(
                                          color: Color(0xff434343),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                                custom_textfield_header(text: 'Skills'),
                                Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          screenHeight(context, dividedBy: 100),
                                      bottom:
                                          screenHeight(context, dividedBy: 70)),
                                  alignment: Alignment.centerLeft,
                                  height: screenHeight(context, dividedBy: 20),
                                  width: screenWidth(context, dividedBy: 1.15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
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
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth(context, dividedBy: 30),
                                        vertical: screenHeight(context,
                                            dividedBy: 100)),
                                    child: Text(
                                      userProfile.data?.first
                                              .professionalDetails?.skills ??
                                          '1 year',
                                      style: const TextStyle(
                                          color: Color(0xff434343),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto"),
                                    ),
                                  ),
                                ),
                                custom_textfield_header(text: 'Education'),
                                Container(
                                  margin: EdgeInsets.only(
                                      top:
                                          screenHeight(context, dividedBy: 100),
                                      bottom:
                                          screenHeight(context, dividedBy: 70)),
                                  height: screenHeight(context, dividedBy: 20),
                                  width: screenWidth(context, dividedBy: 1.15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
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
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth(context,
                                            dividedBy: 30)),
                                    child: Row(
                                      children: [
                                        Text(
                                          userProfile
                                                  .data
                                                  ?.first
                                                  .professionalDetails
                                                  ?.education ??
                                              '',
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                custom_textfield_header(text: 'University'),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      top:
                                          screenHeight(context, dividedBy: 100),
                                      bottom:
                                          screenHeight(context, dividedBy: 70)),
                                  height: screenHeight(context, dividedBy: 20),
                                  width: screenWidth(context, dividedBy: 1.15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
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
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth(context,
                                            dividedBy: 30)),
                                    child: Text(
                                      userProfile
                                              .data
                                              ?.first
                                              .professionalDetails
                                              ?.university ??
                                          '',
                                      style: const TextStyle(
                                          color: AppColor.black,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                              Custom_botton(
                                context,
                                text: 'Premium Membership',
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const PremiumMembership();
                                    },
                                  ));
                                },
                                height: screenHeight(context, dividedBy: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (state is UserDetailsError) {
                      return SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
// height: screenHeight(context, dividedBy: 12),
                                width: screenWidth(context),
                                child: Row(
                                  children: [
                                    Container(
                                      height: screenHeight(context,
                                          dividedBy: 11.5),
                                      width: screenHeight(context,
                                          dividedBy: 11.5),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMVP7dBLbLgjKD8lHdaMcQz7XBf2E22eParQ&usqp=CAU'),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(
                                      width:
                                          screenWidth(context, dividedBy: 35),
                                    ),
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Vincenzo Cassano',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Role: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  fontFamily: 'Roboto',
                                                  color: AppColor.skyBlue),
                                            ),
                                            Text(
                                              'CEO',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  fontFamily: 'Roboto',
                                                  color: AppColor.dropdownfont),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Company: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  fontFamily: 'Roboto',
                                                  color: AppColor.skyBlue),
                                            ),
                                            Text(
                                              'Infosys',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  fontFamily: 'Roboto',
                                                  color: AppColor.dropdownfont),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(
                                            //   builder: (context) {
                                            //     return const Edit_Profile();
                                            //   },
                                            // ));
                                          },
                                          child: Container(
                                            height: screenHeight(context,
                                                dividedBy: 60),
                                            width: screenHeight(context,
                                                dividedBy: 60),
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/Images/edit.png'))),
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenHeight(context,
                                              dividedBy: 60),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return const Location_page();
                                              },
                                            ));
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: screenHeight(context,
                                                  dividedBy: 35),
// width: screenWidth(context, dividedBy: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppColor.Blue
// gradient: const LinearGradient(colors: [
// AppColor.skyBlue,
// AppColor.whiteskyBlue
// ]),
                                                  ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: screenWidth(
                                                        context,
                                                        dividedBy: 25)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: screenHeight(
                                                          context,
                                                          dividedBy: 60),
                                                      width: screenHeight(
                                                          context,
                                                          dividedBy: 60),
                                                      decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/Images/location.png'))),
                                                    ),
                                                    SizedBox(
                                                      width: screenWidth(
                                                          context,
                                                          dividedBy: 150),
                                                    ),
                                                    const Text(
                                                      'Location',
                                                      style: TextStyle(
                                                          color: AppColor.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Roboto'),
                                                    )
                                                  ],
                                                ),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 20,
                                color: Color(0xffF5F5F5),
                              ),
                              custom_textfield_header(text: 'Intermediate'),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        screenHeight(context, dividedBy: 70),
                                    top: screenHeight(context, dividedBy: 100)),
                                child: LinearPercentIndicator(
                                    width:
                                        screenWidth(context, dividedBy: 1.25),
                                    lineHeight: 7.0,
                                    percent: 0.5,
                                    barRadius: const Radius.circular(20),
                                    backgroundColor: Colors.grey.shade200,
                                    trailing: custom_text(
                                        text: "2/5",
                                        color: const Color(0xff434343)),
// progressColor: Colors.blue,
                                    linearGradient: const LinearGradient(
                                        colors: [
                                          AppColor.skyBlue,
                                          AppColor.whiteskyBlue
                                        ])),
                              ),
// Padding(
// padding: const EdgeInsets.only(left: 330.0),
// child: custom_text(text: "2/5", color: Color(0xff434343)),
// ),
                              custom_textfield_header(text: 'Bio'),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
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
                                      vertical: screenHeight(context,
                                          dividedBy: 150)),
                                  child: TextField(
                                    controller: _bio,
                                    maxLength: 250,
                                    readOnly: true,
                                    minLines: 1,
                                    maxLines: 7,
                                    cursorColor: AppColor.fontdarkgray,
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xff434343)),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
// hintText: 'Enter some words of your Profile',
// hintStyle: TextStyle(
// fontFamily: 'Roboto',
// fontWeight: FontWeight.w400,
// fontSize: 15)
                                    ),
                                  ),
                                ),
                              ),
                              custom_textfield_header(text: 'My Documents'),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 150),
                              ),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 4.3),
                                width: screenWidth(context),
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
//padding: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 100)),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: screenHeight(context,
                                              dividedBy: 190)),
                                      height:
                                          screenHeight(context, dividedBy: 15),
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
                                            vertical: screenHeight(context,
                                                dividedBy: 150),
                                            horizontal: screenWidth(context,
                                                dividedBy: 70)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth(context,
                                                  dividedBy: 13),
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/Images/uploadedfile.png'))),
                                            ),
                                            SizedBox(
                                              width: screenWidth(context,
                                                  dividedBy: 50),
                                            ),
                                            const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'image_03.PDF ',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '96.47 KB ',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 100),
                              ),
                              custom_textfield_header(text: 'Address'),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
                                alignment: Alignment.centerLeft,
// height: screenHeight(context,dividedBy: 17),
                                width: screenWidth(context, dividedBy: 1.15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
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
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30),
                                      vertical: screenHeight(context,
                                          dividedBy: 100)),
                                  child: const Text(
                                    "Ground Floor, BL-91, Plot No. 13/24, Udhana - Magdalla Rd, near Dharti Namkin Udhna, Chandramani Society, Surat, Gujarat 395007",
                                    style: TextStyle(
                                        color: Color(0xff434343),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ),
                              custom_textfield_header(
                                  text: 'Business Experience '),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
                                alignment: Alignment.centerLeft,
                                height: screenHeight(context, dividedBy: 20),
                                width: screenWidth(context, dividedBy: 1.15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
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
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30),
                                      vertical: screenHeight(context,
                                          dividedBy: 100)),
                                  child: const Text(
                                    "1 years",
                                    style: TextStyle(
                                        color: Color(0xff434343),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ),
                              custom_textfield_header(text: 'Skills'),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
                                alignment: Alignment.centerLeft,
                                height: screenHeight(context, dividedBy: 20),
                                width: screenWidth(context, dividedBy: 1.15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
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
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30),
                                      vertical: screenHeight(context,
                                          dividedBy: 100)),
                                  child: const Text(
                                    "Graphic Design",
                                    style: TextStyle(
                                        color: Color(0xff434343),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ),
                              custom_textfield_header(text: 'Education'),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
                                height: screenHeight(context, dividedBy: 20),
                                width: screenWidth(context, dividedBy: 1.15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
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
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30)),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'BCA - Bachelor of Computer Applications',
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              custom_textfield_header(text: 'University'),
                              Container(
                                margin: EdgeInsets.only(
                                    top: screenHeight(context, dividedBy: 100),
                                    bottom:
                                        screenHeight(context, dividedBy: 70)),
                                height: screenHeight(context, dividedBy: 20),
                                width: screenWidth(context, dividedBy: 1.15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
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
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          screenWidth(context, dividedBy: 30)),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Veer Narmad South Gujarat University',
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Custom_botton(
                                context,
                                text: 'Premium Membership',
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const PremiumMembership();
                                    },
                                  ));
                                },
                                height: screenHeight(context, dividedBy: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth(context, dividedBy: 15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
// height: screenHeight(context, dividedBy: 12),
                              width: screenWidth(context),
                              child: Row(
                                children: [
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 11.5),
                                    width:
                                        screenHeight(context, dividedBy: 11.5),
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMVP7dBLbLgjKD8lHdaMcQz7XBf2E22eParQ&usqp=CAU'),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(
                                    width: screenWidth(context, dividedBy: 35),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Vincenzo Cassano',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Role: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                fontFamily: 'Roboto',
                                                color: AppColor.skyBlue),
                                          ),
                                          Text(
                                            'CEO',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                fontFamily: 'Roboto',
                                                color: AppColor.dropdownfont),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Company: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                fontFamily: 'Roboto',
                                                color: AppColor.skyBlue),
                                          ),
                                          Text(
                                            'Infosys',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                fontFamily: 'Roboto',
                                                color: AppColor.dropdownfont),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return const Edit_Profile();
                                          //   },
                                          // ));
                                        },
                                        child: Container(
                                          height: screenHeight(context,
                                              dividedBy: 60),
                                          width: screenHeight(context,
                                              dividedBy: 60),
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/Images/edit.png'))),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 60),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const Location_page();
                                            },
                                          ));
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            height: screenHeight(context,
                                                dividedBy: 35),
// width: screenWidth(context, dividedBy: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColor.Blue
// gradient: const LinearGradient(colors: [
// AppColor.skyBlue,
// AppColor.whiteskyBlue
// ]),
                                                ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: screenWidth(
                                                      context,
                                                      dividedBy: 25)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 60),
                                                    width: screenHeight(context,
                                                        dividedBy: 60),
                                                    decoration: const BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'assets/Images/location.png'))),
                                                  ),
                                                  // Image(
                                                  //   color: AppColor.white,
                                                  //   image: const AssetImage(
                                                  //       'assets/Images/location.png'),
                                                  //   height: screenHeight(context,
                                                  //       dividedBy: 60),
                                                  //   width: screenHeight(context,
                                                  //       dividedBy: 60),
                                                  // ),
                                                  SizedBox(
                                                    width: screenWidth(context,
                                                        dividedBy: 150),
                                                  ),
                                                  const Text(
                                                    'Location',
                                                    style: TextStyle(
                                                        color: AppColor.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'Roboto'),
                                                  )
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              height: 20,
                              color: Color(0xffF5F5F5),
                            ),
                            custom_textfield_header(text: 'Intermediate'),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight(context, dividedBy: 70),
                                  top: screenHeight(context, dividedBy: 100)),
                              child: LinearPercentIndicator(
                                  width: screenWidth(context, dividedBy: 1.25),
                                  lineHeight: 7.0,
                                  percent: 0.5,
                                  barRadius: const Radius.circular(20),
                                  backgroundColor: Colors.grey.shade200,
                                  trailing: custom_text(
                                      text: "2/5",
                                      color: const Color(0xff434343)),
// progressColor: Colors.blue,
                                  linearGradient: const LinearGradient(colors: [
                                    AppColor.skyBlue,
                                    AppColor.whiteskyBlue
                                  ])),
                            ),
// Padding(
// padding: const EdgeInsets.only(left: 330.0),
// child: custom_text(text: "2/5", color: Color(0xff434343)),
// ),
                            custom_textfield_header(text: 'Bio'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
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
                                  controller: _bio,
                                  maxLength: 250,
                                  readOnly: true,
                                  minLines: 1,
                                  maxLines: 7,
                                  cursorColor: AppColor.fontdarkgray,
                                  style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Color(0xff434343)),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
// hintText: 'Enter some words of your Profile',
// hintStyle: TextStyle(
// fontFamily: 'Roboto',
// fontWeight: FontWeight.w400,
// fontSize: 15)
                                  ),
                                ),
                              ),
                            ),
                            custom_textfield_header(text: 'My Documents'),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 150),
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 4.3),
                              width: screenWidth(context),
                              child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
//padding: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 100)),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: screenHeight(context,
                                            dividedBy: 190)),
                                    height:
                                        screenHeight(context, dividedBy: 15),
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
                                          vertical: screenHeight(context,
                                              dividedBy: 150),
                                          horizontal: screenWidth(context,
                                              dividedBy: 70)),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: screenWidth(context,
                                                dividedBy: 13),
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/Images/uploadedfile.png'))),
                                          ),
                                          SizedBox(
                                            width: screenWidth(context,
                                                dividedBy: 50),
                                          ),
                                          const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'image_03.PDF ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                '96.47 KB ',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: screenHeight(context, dividedBy: 100),
                            ),
                            custom_textfield_header(text: 'Address'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
                              alignment: Alignment.centerLeft,
// height: screenHeight(context,dividedBy: 17),
                              width: screenWidth(context, dividedBy: 1.15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
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
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30),
                                    vertical:
                                        screenHeight(context, dividedBy: 100)),
                                child: const Text(
                                  "Ground Floor, BL-91, Plot No. 13/24, Udhana - Magdalla Rd, near Dharti Namkin Udhna, Chandramani Society, Surat, Gujarat 395007",
                                  style: TextStyle(
                                      color: Color(0xff434343),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                            ),
                            custom_textfield_header(
                                text: 'Business Experience '),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
                              alignment: Alignment.centerLeft,
                              height: screenHeight(context, dividedBy: 20),
                              width: screenWidth(context, dividedBy: 1.15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
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
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30),
                                    vertical:
                                        screenHeight(context, dividedBy: 100)),
                                child: const Text(
                                  "1 years",
                                  style: TextStyle(
                                      color: Color(0xff434343),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                            ),
                            custom_textfield_header(text: 'Skills'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
                              alignment: Alignment.centerLeft,
                              height: screenHeight(context, dividedBy: 20),
                              width: screenWidth(context, dividedBy: 1.15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
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
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30),
                                    vertical:
                                        screenHeight(context, dividedBy: 100)),
                                child: const Text(
                                  "Graphic Design",
                                  style: TextStyle(
                                      color: Color(0xff434343),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto"),
                                ),
                              ),
                            ),
                            custom_textfield_header(text: 'Education'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
                              height: screenHeight(context, dividedBy: 20),
                              width: screenWidth(context, dividedBy: 1.15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
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
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30)),
                                child: const Row(
                                  children: [
                                    Text(
                                      'BCA - Bachelor of Computer Applications',
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            custom_textfield_header(text: 'University'),
                            Container(
                              margin: EdgeInsets.only(
                                  top: screenHeight(context, dividedBy: 100),
                                  bottom: screenHeight(context, dividedBy: 70)),
                              height: screenHeight(context, dividedBy: 20),
                              width: screenWidth(context, dividedBy: 1.15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
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
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 30)),
                                child: const Row(
                                  children: [
                                    Text(
                                      'Veer Narmad South Gujarat University',
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Custom_botton(
                              context,
                              text: 'Premium Membership',
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const PremiumMembership();
                                  },
                                ));
                              },
                              height: screenHeight(context, dividedBy: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
