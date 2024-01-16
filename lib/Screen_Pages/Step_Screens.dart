import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:pair_me/Modal/city&state.dart';
import 'package:pair_me/Screen_Pages/bottom_bar/home_screen.dart';
import 'package:pair_me/Screen_Pages/view_pdf.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/Widgets/stepper.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/Buisness_profile.dart';
import 'package:pair_me/cubits/City&state.dart';
import 'package:pair_me/cubits/Describe_yourself_cubit.dart';
import 'package:pair_me/cubits/adsress_drtails.dart';
import 'package:pair_me/cubits/business_address_cubit.dart';
import 'package:pair_me/cubits/connect_with_cubit.dart';
import 'package:pair_me/cubits/professional_details_cubit.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';
import '../Widgets/custom_button.dart';

class StepScreen extends StatefulWidget {
  const StepScreen({super.key});

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  int ind = 0;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String files1 = "";
  String files2 = "";
  String files3 = "";
  String openFile1 = "";
  String openFile2 = "";
  String openFile3 = "";
  int KB1 = 0;
  int KB2 = 0;
  int KB3 = 0;
  bool _contry = false;
  bool _state = false;
  bool _city = false;
  bool calendar = false;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  SharedPrefsService prefsService = SharedPrefsService();
  CityStateCubit cityStateCubit = CityStateCubit();
  AdressDetailsCubit adressDetailsCubit = AdressDetailsCubit();
  CityandState cityandState = CityandState();
  ProfessionalDetailsCubit professionalDetailsCubit =
      ProfessionalDetailsCubit();
  BusinessDetailsCubit businessDetailsCubit = BusinessDetailsCubit();
  DescribeYourSelfCubit describeYourSelfCubit = DescribeYourSelfCubit();
  ConnectwithCubit connectwithCubit = ConnectwithCubit();
  BusinessProfileCubit businessProfileCubit = BusinessProfileCubit();
  final TextEditingController _Address = TextEditingController();
  final TextEditingController _Address1 = TextEditingController();
  final TextEditingController _Address2 = TextEditingController();
  final TextEditingController _Address3 = TextEditingController();
  final TextEditingController _Zipcode = TextEditingController();
  final TextEditingController _Zipcode1 = TextEditingController();
  final TextEditingController _Contry = TextEditingController();
  final TextEditingController _Contry1 = TextEditingController();
  final TextEditingController _State = TextEditingController();
  final TextEditingController _State1 = TextEditingController();
  final TextEditingController _City = TextEditingController();
  final TextEditingController _City1 = TextEditingController();
  final TextEditingController _compnyName = TextEditingController();
  final TextEditingController _jobTitle = TextEditingController();
  final TextEditingController _compnyDomain = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _categorycontroller = TextEditingController();
  final TextEditingController _experiencecontroller = TextEditingController();
  final TextEditingController _skillcontroller = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _educationcontroller = TextEditingController();
  final TextEditingController _univercitycontroller = TextEditingController();
  final TextEditingController _date = TextEditingController();
  File? image;
  File? image1;
  File? image2;
  File? image3;
  File? image4;
  File? image5;
  SelectedByte? _selectedimag1;
  SelectedByte? _selectedimag2;
  SelectedByte? _selectedimag3;
  SelectedByte? _selectedimag4;
  SelectedByte? _selectedimag5;
  SelectedByte? _selectedimag6;
  PlatformFile? file1;
  PlatformFile? file2;
  PlatformFile? file3;
  String img = '';
  String Uname = '';
  RegExp regExp =  RegExp('\b*@abc\.net\$');
  RegExp regExp1 =  RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final List _categorys = [
    'Entrepreneurship',
    'Leadership',
    'Management',
    'Finance',
  ];
  final List _experiences = [
    '1 years',
    '2 years',
    '3 years',
    '4 years',
  ];
  final List _skills = [
    'Graphic Design',
    'Web Design',
    'Communication',
    'Project management',
    'Problem solving',
    'Creativity',
    'Data analysis',
    'Software development',
    'Presentation',
    'Data mining',
    'Troubleshooting',
    'Artificial intelligence',
    'Machine learning',
    'Cloud computing',
    'Cybersecurity',
    'Blockchain and cryptocurrencies',
    'Analytical thinking',
    'Application Development',
    'Architecture',
    'UI / UX',
  ];
  List lookingFor = [
    'Investor',
    'Startup Founder',
    'Corporate Executive',
    'Manufacturer',
    'Distributor',
    'Channel Partner',
    'Business Partner',
    'Translator',
    'Software tester',
  ];
  List selectedlookingFor = [];
  List selectedlookingFor1 = [];
  List filelist = [];
  bool _category = false;
  bool _experience = false;
  bool _skill = false;
  bool _education = false;
  final dio = Dio();

  addFolderNameDialog(String delete) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 60),
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Text(
            'Are you sure you want to remove file?',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: 'Roboto'),
          ),
        ),
        const Divider(
          height: 0,
          color: Color(0xffF5F5F5),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.skyBlue, width: 2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.skyBlue),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  filelist.remove(delete);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal:screenWidth(context,dividedBy: 10),vertical: height),
                  alignment: Alignment.center,
                  height: 35,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                        colors: [AppColor.skyBlue, AppColor.whiteskyBlue]),
                  ),
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'Roboto',
                        color: AppColor.white),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  GetData(String country) async {
    cityandState = (await cityStateCubit.getcalendarEvents(country: country))!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getImagesPath();
    cityStateCubit = BlocProvider.of<CityStateCubit>(context);
    adressDetailsCubit = BlocProvider.of<AdressDetailsCubit>(context);
    professionalDetailsCubit =
        BlocProvider.of<ProfessionalDetailsCubit>(context);
    businessDetailsCubit = BlocProvider.of<BusinessDetailsCubit>(context);
    describeYourSelfCubit = BlocProvider.of<DescribeYourSelfCubit>(context);
    connectwithCubit = BlocProvider.of<ConnectwithCubit>(context);
    businessProfileCubit = BlocProvider.of<BusinessProfileCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Background_Img(context),
            ind == 0
                ? SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context, dividedBy: 15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight(context, dividedBy: 8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:
                                      custom_header(text: "Address Details")),
                              skip_button(
                                context,
                                onTap: () {
                                  if(_Address.text.isNotEmpty || _Address2.text.isNotEmpty ) {
                                    if(_Contry.text.isEmpty){
                                      flutterToast("Enter Your Country", false);
                                    } else if(_City.text.isEmpty) {
                                      flutterToast("Enter Your City", false);
                                    } else if(_State.text.isEmpty) {
                                      flutterToast("Enter Your State", false);
                                    } else if(_Zipcode.text.isEmpty) {
                                      flutterToast("Enter Your Zipcode", false);
                                    } else {
                                      adressDetailsCubit.AdressDetailsService(
                                          address: "${_Address.text}${_Address2
                                              .text}",
                                          country: _Contry.text,
                                          state: _State.text,
                                          city: _City.text,
                                          zipCode: _Zipcode.text,
                                          context: context).then((value) {
                                        setState(() {
                                          ind++;
                                        });
                                      });
                                    }
                                  } else {
                                    flutterToast("Please Enter Your Address", true);
                                  }
                                //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //   //   return Professional_Details(Name: '',);
                                //   // },));
                                 },
                              )
                            ],
                          ),
                          custom_discription(
                              text:
                                  "Please show some alternative font designs throughout the app"),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          custom_textfield_header(text: 'Address'),
                          Custom_textfield(context,
                              show_icon: false,
                              readOnly: false,
                              onPress: () {},
                              hint: "Address line 1",
                              mxline: 2,
                              hidetext: false,
                              controller: _Address),
                          Custom_textfield(context,
                              show_icon: false,
                              readOnly: false,
                              onPress: () {},
                              hint: "Address line 2",
                              mxline: 2,
                              hidetext: false,
                              controller: _Address2),
                          custom_textfield_header(text: 'Country'),
                          Custom_textfield(context,
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.phoneCode}');
                                    print('Select country: ${country.name}');
                                    _Contry.text = country.name;
                                    GetData(_Contry.text);
                                    // countryCodeSelect = country.phoneCode;
                                    // countryCodeflagsvg = country.flagEmoji;
                                    //flutterToast(country.displayNameNoCountryCode, true);
                                    setState(() {});
                                  },
                                );
                              },
                              show_icon: true,
                              image: _contry
                                  ? 'assets/Images/Vector.png'
                                  : 'assets/Images/right_arrow.png',
                              readOnly: true,
                              onPress: () {
                                // setState(() {
                                //   _contry = !_contry;
                                // });
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.phoneCode}');
                                    print('Select country: ${country.name}');
                                    _Contry.text = country.name;
                                    GetData(_Contry.text);
                                    // countryCodeSelect = country.phoneCode;
                                    // countryCodeflagsvg = country.flagEmoji;
                                    //flutterToast(country.displayNameNoCountryCode, true);
                                    setState(() {});
                                  },
                                );
                              },
                              hint: "Select",
                              hidetext: false,
                              controller: _Contry),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    custom_textfield_header(text: 'State'),
                                    Custom_textfield(context,
                                        onTap: () {
                                          setState(() {
                                            _state = !_state;
                                          });
                                        },
                                        show_icon: true,
                                        image: _state
                                            ? 'assets/Images/Vector.png'
                                            : 'assets/Images/right_arrow.png',
                                        readOnly: false,
                                        onPress: () {
                                          setState(() {
                                            _state = !_state;
                                          });
                                        },
                                        hint: "Select",
                                        hidetext: false,
                                        controller: _State),
                                    _state
                                        ? Container(
                                            height: screenHeight(context,
                                                dividedBy: 7),
                                            width: screenWidth(context),
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                      1,
                                                      1,
                                                    ),
                                                    blurRadius: 4,
                                                    // spreadRadius: 1.0,
                                                  ),
                                                ]),
                                            child: BlocBuilder<CityStateCubit,
                                                CityStateState>(
                                              builder: (context, state) {
                                                print(state);
                                                if (state is CityStateError)
                                                  return const Center(
                                                    child: Text("No State"),
                                                  );
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: screenHeight(
                                                          context,
                                                          dividedBy: 100),
                                                      horizontal: screenWidth(
                                                          context,
                                                          dividedBy: 30)),
                                                  child: ListView.builder(
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: cityandState
                                                        .state?.states.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          _State.text =
                                                              cityandState
                                                                      .state
                                                                      ?.states[
                                                                          index]
                                                                      .name ??
                                                                  '';
                                                          _state = !_state;
                                                          setState(() {});
                                                        },
                                                        child: custom_text(
                                                            text: cityandState
                                                                    .state
                                                                    ?.states[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            color: const Color(
                                                                0xff303030)),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ))
                                        : SizedBox(
                                            height: _city
                                                ? screenHeight(context,
                                                    dividedBy: 6.35)
                                                : 0,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: screenWidth(context, dividedBy: 50),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    custom_textfield_header(text: 'City'),
                                    Custom_textfield(
                                        onTap: () {
                                          setState(() {
                                            _city = !_city;
                                          });
                                        },
                                        context,
                                        show_icon: true,
                                        image: _city
                                            ? 'assets/Images/Vector.png'
                                            : 'assets/Images/right_arrow.png',
                                        readOnly: false,
                                        onPress: () {
                                          setState(() {
                                            _city = !_city;
                                          });
                                        },
                                        hint: "Select",
                                        hidetext: false,
                                        controller: _City),
                                    _city
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 10),
                                            height: screenHeight(context,
                                                dividedBy: 7),
                                            width: screenWidth(context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                      1,
                                                      1,
                                                    ),
                                                    blurRadius: 4,
                                                    // spreadRadius: 1.0,
                                                  ),
                                                ]),
                                            child: BlocBuilder<CityStateCubit,
                                                CityStateState>(
                                              builder: (context, state) {
                                                print(state);
                                                if (state is CityStateError) {
                                                  return const Center(
                                                    child: Text("No State"),
                                                  );
                                                }
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: screenHeight(
                                                          context,
                                                          dividedBy: 100),
                                                      horizontal: screenWidth(
                                                          context,
                                                          dividedBy: 30)),
                                                  child: ListView.builder(
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    padding: EdgeInsets.zero,
                                                    itemCount: cityandState
                                                        .city?.cities.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                          onTap: () {
                                                            _City
                                                                .text = cityandState
                                                                        .city
                                                                        ?.cities[
                                                                    index] ??
                                                                '';
                                                            _city = !_city;
                                                            setState(() {});
                                                          },
                                                          child: custom_text(
                                                              text: cityandState
                                                                          .city
                                                                          ?.cities[
                                                                      index] ??
                                                                  '',
                                                              color: const Color(
                                                                  0xff303030)));
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: _state
                                                ? screenHeight(context,
                                                    dividedBy: 6.35)
                                                : 0,
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          custom_textfield_header(text: 'Post code / Zip code'),
                          Custom_textfield(context,
                              show_icon: false,
                              number: true,
                              readOnly: false,
                              onPress: () {},
                              hint: "Post code / Zip code",
                              hidetext: false,
                              controller: _Zipcode),
                          Custom_botton(
                            context,
                            text: 'Next',
                            onTap: () {
                              // setState(() {
                              //   ind++;
                              // });
                              if (_Address.text.isNotEmpty ||
                                  _Address2.text.isNotEmpty) {
                                if (_Contry.text.isEmpty) {
                                  flutterToast("Enter Your Country", false);
                                } else if (_City.text.isEmpty) {
                                  flutterToast("Enter Your City", false);
                                } else if (_State.text.isEmpty) {
                                  flutterToast("Enter Your State", false);
                                } else if (_Zipcode.text.isEmpty) {
                                  flutterToast("Enter Your Zipcode", false);
                                } else {
                                  adressDetailsCubit.AdressDetailsService(
                                          address:
                                              "${_Address.text}${_Address2.text}",
                                          country: _Contry.text,
                                          state: _State.text,
                                          city: _City.text,
                                          zipCode: _Zipcode.text,
                                          context: context)
                                      .then((value) {
                                    setState(() {
                                      ind++;
                                    });
                                  });
                                }
                              } else {
                                flutterToast("Please Enter Your Address", true);
                              }
                            },
                            height: screenHeight(context, dividedBy: 20),
                          )
                        ],
                      ),
                    ),
                  )
                : ind == 1
                    ? SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight(context, dividedBy: 8),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: custom_header(
                                          text: "Professional Details")),
                                  skip_button(
                                    context,
                                    onTap: () {
                                      if(_compnyName.text.isEmpty){
                                        flutterToast("Please Enter Your Company Name", false);
                                      } else
                                      if(_jobTitle.text.isEmpty){
                                        flutterToast("Please Enter Your Job Title/Add Role", false);
                                      } else
                                      if(_compnyDomain.text.isEmpty){
                                        flutterToast("Please Enter Your Company Domain", false);
                                      } else
                                      if(_email.text.isEmpty){
                                        flutterToast("Please Enter Email", false);
                                      } else
                                      if(_categorycontroller.text.isEmpty){
                                        flutterToast("Please Enter Category", false);
                                      } else {
                                        professionalDetailsCubit.ProfessionalDetailsService(company_name: _compnyName.text, add_role: _jobTitle.text, company_domain: _compnyDomain.text, email: _email.text, category: _categorycontroller.text, business_experience: _experiencecontroller.text, skills: _skillcontroller.text, education: _educationcontroller.text, university: _univercitycontroller.text, context: context).then((value) {
                                          setState(() {
                                            ind++;
                                          });
                                        },);
                                      }
                                    },
                                    // onTap: () {
                                    //   setState(() {
                                    //     ind++;
                                    //   });
                                    // },
                                  )
                                ],
                              ),
                              custom_discription(
                                  text:
                                      "Your new password cannot be the same as a previous password."),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 50),
                              ),
                              custom_textfield_header(text: 'Company Name'),
                              Custom_textfield(context,
                                  show_icon: false,
                                  onPress: () {},
                                  hint: 'Company Name',
                                  controller: _compnyName,
                                  hidetext: false,
                                  readOnly: false),
                              custom_textfield_header(
                                  text: 'Add role / Job title', header: true),
                              Custom_textfield(context,
                                  show_icon: false,
                                  onPress: () {},
                                  hint: 'Job title',
                                  controller: _jobTitle,
                                  hidetext: false,
                                  readOnly: false),
                              custom_textfield_header(text: 'Company Domain'),
                              Custom_textfield(context,
                                  show_icon: false,
                                  onPress: () {},
                                  hint: 'Company Domain',
                                  controller: _compnyDomain,
                                  hidetext: false,
                                  readOnly: false),
                              custom_textfield_header(
                                  text: 'Email', header: true),
                              Custom_textfield(context,
                                  show_icon: false,
                                  onPress: () {},
                                  hint: 'Your email',
                                  controller: _email,
                                  hidetext: false,
                                  readOnly: false),
                              custom_textfield_header(
                                  text: 'Category', header: true),
                              Custom_textfield(context,
                                  show_icon: true,
                                  image: _category
                                      ? 'assets/Images/Vector.png'
                                      : 'assets/Images/right_arrow.png',
                                  onTap: () {
                                    setState(() {
                                      _category = !_category;
                                    });
                                  },
                                  readOnly: true,
                                  onPress: () {
                                    setState(() {
                                      _category = !_category;
                                    });
                                  },
                                  hint: 'Select',
                                  hidetext: false,
                                  controller: _categorycontroller),
                              _category
                                  ? Container(
                                      height:
                                          screenHeight(context, dividedBy: 8),
                                      width: screenWidth(context),
                                      margin: EdgeInsets.only(
                                          bottom: screenHeight(context,
                                              dividedBy: 150)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 100),
                                              horizontal: 10),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            itemCount: _categorys.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: screenHeight(
                                                        context,
                                                        dividedBy: 150)),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _categorycontroller
                                                                .text =
                                                            _categorys[index];
                                                        _category = !_category;
                                                      });
                                                    },
                                                    child: custom_text(
                                                        text: _categorys[index],
                                                        color: const Color(
                                                            0xff303030))),
                                              );
                                            },
                                          )),
                                    )
                                  : const SizedBox(),
                              custom_textfield_header(
                                  text: 'Business Experience'),
                              Custom_textfield(context,
                                  show_icon: true,
                                  image: _experience
                                      ? 'assets/Images/Vector.png'
                                      : 'assets/Images/right_arrow.png',
                                  onTap: () {
                                    setState(() {
                                      _experience = !_experience;
                                    });
                                  },
                                  readOnly: true,
                                  onPress: () {
                                    setState(() {
                                      _experience = !_experience;
                                    });
                                  },
                                  hint: "Select",
                                  hidetext: false,
                                  controller: _experiencecontroller),
                              _experience
                                  ? Container(
                                      height:
                                          screenHeight(context, dividedBy: 7.5),
                                      width: screenWidth(context),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 70),
                                              horizontal: 10),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: _experiences.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: screenHeight(
                                                        context,
                                                        dividedBy: 100)),
                                                child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _experiencecontroller
                                                                .text =
                                                            _experiences[index];
                                                        _experience =
                                                            !_experience;
                                                      });
                                                    },
                                                    child: custom_text(
                                                        text:
                                                            _experiences[index],
                                                        color: const Color(
                                                            0xff303030))),
                                              );
                                            },
                                          )),
                                    )
                                  : const SizedBox(),
                              custom_textfield_header(text: 'Skills'),
                              Custom_textfield(context,
                                  show_icon: true,
                                  image: _skill
                                      ? 'assets/Images/Vector.png'
                                      : 'assets/Images/right_arrow.png',
                                  onTap: () {},
                                  readOnly: false, onPress: () {
                                setState(() {
                                  _skill = !_skill;
                                });
                              },
                                  hint: "Select",
                                  hidetext: false,
                                  controller: _skillcontroller),
                              _skill
                                  ? Container(
                                      height:
                                          screenHeight(context, dividedBy: 7.5),
                                      width: screenWidth(context),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                1,
                                                1,
                                              ),
                                              blurRadius: 4,
                                              // spreadRadius: 1.0,
                                            ),
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 85),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: custom_text(
                                                text: _skills[0],
                                                color: const Color(0xff303030)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: custom_text(
                                                text: _skills[1],
                                                color: const Color(0xff303030)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: custom_text(
                                                text: _skills[2],
                                                color: const Color(0xff303030)),
                                          ),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 85),
                                          ),
                                          const Divider(
                                            height: 0,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: screenHeight(context,
                                                dividedBy: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Show all 17 skills',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Roboto',
                                                      fontSize: 10,
                                                      color: AppColor.skyBlue),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: screenWidth(context,
                                                          dividedBy: 65)),
                                                  height: screenHeight(context,
                                                      dividedBy: 65),
                                                  width: screenWidth(context,
                                                      dividedBy: 30),
                                                  child: const Image(
                                                      image: AssetImage(
                                                          'assets/Images/LineArrow.png')),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              custom_textfield_header(text: 'Education'),
                              Custom_textfield(context,
                                  show_icon: true,
                                  image: _education
                                      ? 'assets/Images/Vector.png'
                                      : 'assets/Images/right_arrow.png',
                                  onTap: () {},
                                  readOnly: false, onPress: () {
                                setState(() {
                                  _education = !_education;
                                });
                              },
                                  hint: "Select",
                                  hidetext: false,
                                  controller: _educationcontroller),
                              _education
                                  ? Container(
                                      // height:
                                      //     screenHeight(context, dividedBy: 10),
                                      width: screenWidth(context),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                1,
                                                1,
                                              ),
                                              blurRadius: 4,
                                              // spreadRadius: 1.0,
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _educationcontroller.text =
                                                        "B.Com - Bachelor of Commerce";
                                                    _education = !_education;
                                                  });
                                                },
                                                child: const Text(
                                                    'B.Com - Bachelor of Commerce')),
                                            SizedBox(
                                              height: screenHeight(context,
                                                  dividedBy: 100),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _educationcontroller.text =
                                                        "BCA - Bachelor of Computer Applications";
                                                    _education = !_education;
                                                  });
                                                },
                                                child: const Text(
                                                    'BCA - Bachelor of Computer Applications')),
                                            // SizedBox(height: screenHeight(context,dividedBy: 205),),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              custom_textfield_header(text: 'University'),
                              Custom_textfield(context,
                                  show_icon: true,
                                  image: _education
                                      ? 'assets/Images/Vector.png'
                                      : 'assets/Images/right_arrow.png',
                                  onTap: () {},
                                  readOnly: false, onPress: () {
                                setState(() {
                                  _education = !_education;
                                });
                              },
                                  hint: "Select",
                                  hidetext: false,
                                  controller: _univercitycontroller),
                              _education
                                  ? Container(
                                      // height:
                                      //     screenHeight(context, dividedBy: 10),
                                      width: screenWidth(context),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(
                                                1,
                                                1,
                                              ),
                                              blurRadius: 4,
                                              // spreadRadius: 1.0,
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _univercitycontroller.text =
                                                        "Veer Narmad South Gujarat University";
                                                    _education = !_education;
                                                  });
                                                },
                                                child: const Text(
                                                    'Veer Narmad South Gujarat University')),
                                            // SizedBox(height: screenHeight(context,dividedBy: 205),),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              Center(
                                child: Custom_botton(
                                  context,
                                  text: 'Next',
                                  onTap: () {
                                    if (_compnyName.text.isEmpty) {
                                      flutterToast(
                                          "Please Enter Your Company Name",
                                          false);
                                    } else if (_jobTitle.text.isEmpty) {
                                      flutterToast(
                                          "Please Enter Your Job Title/Add Role",
                                          false);
                                    } else if (_compnyDomain.text.isEmpty) {
                                      flutterToast("Please Enter Your Company Domain", false);
                                    } else if(regExp.hasMatch(_compnyDomain.text)){
                                      if (_email.text.isEmpty) {
                                        flutterToast("Please Enter Email", false);
                                      } else if(regExp1.hasMatch(_email.text)){
                                        if (_categorycontroller
                                            .text.isEmpty) {
                                          flutterToast(
                                              "Please Enter Category", false);
                                        } else {
                                          professionalDetailsCubit
                                              .ProfessionalDetailsService(
                                              company_name:
                                              _compnyName.text,
                                              add_role: _jobTitle.text,
                                              company_domain:
                                              _compnyDomain.text,
                                              email: _email.text,
                                              category:
                                              _categorycontroller.text,
                                              business_experience:
                                              _experiencecontroller
                                                  .text,
                                              skills: _skillcontroller.text,
                                              education:
                                              _educationcontroller.text,
                                              university:
                                              _univercitycontroller
                                                  .text,
                                              context: context)
                                              .then(
                                                (value) {
                                              setState(() {
                                                ind++;
                                              });
                                            },
                                          );
                                        }
                                      } else {
                                        flutterToast("Please Enter valid Email", false);
                                      }
                                    } else {
                                      flutterToast("Please Enter valid company domain", false);
                                    }
                                  },
                                  // onTap: () {
                                  //   setState(() {
                                  //     ind++;
                                  //   });
                                  // },
                                  height: screenHeight(context, dividedBy: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ind == 2
                        ? SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      screenWidth(context, dividedBy: 15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: screenHeight(context, dividedBy: 8),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: custom_header(
                                              text:
                                                  "Business or Professional Address")),
                                      skip_button(
                                        context,
                                        onTap: () {
                                          if(_Address1.text.isEmpty && _Address3.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal Address", false);
                                          } else if(_Contry1.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal Contry", false);
                                          } else if(_State1.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal State", false);
                                          }else if(_City1.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal City", false);
                                          }else if(_Zipcode1.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal Zipcode", false);
                                          }else if(_date.text.isEmpty){
                                            flutterToast("Please Enter Your Business or Professinoal Start date", false);
                                          }else{
                                            businessDetailsCubit.BusinessDetailsService(address: "${_Address1.text}${_Address3.text}", country: _Contry1.text, state: _State1.text, city: _City1.text, zipCode: _Zipcode1.text, context: context, startDate: _date.text).then((value) {
                                              setState(() {
                                                ind++;
                                              });
                                            },);
                                          }

                                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          //   return Business_Profile(Name: '',);
                                          // },));
                                        },
                                      )
                                    ],
                                  ),
                                  custom_discription(
                                      text:
                                          "Your new password cannot be the same as a previous password."),
                                  SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 50),
                                  ),
                                  custom_textfield_header(text: 'Address'),
                                  Custom_textfield(context,
                                      show_icon: false,
                                      readOnly: false,
                                      onPress: () {},
                                      hint: "Address line 1",
                                      mxline: 2,
                                      hidetext: false,
                                      controller: _Address1),
                                  Custom_textfield(context,
                                      show_icon: false,
                                      readOnly: false,
                                      onPress: () {},
                                      hint: "Address line 2",
                                      mxline: 2,
                                      hidetext: false,
                                      controller: _Address3),
                                  custom_textfield_header(text: 'Country'),
                                  Custom_textfield(context,
                                      onTap: () {
                                        showCountryPicker(
                                          context: context,
                                          showPhoneCode: true,
                                          onSelect: (Country country) {
                                            print(
                                                'Select country: ${country.phoneCode}');
                                            print(
                                                'Select country: ${country.name}');
                                            _Contry1.text = country.name;
                                            GetData(_Contry1.text);
                                            // countryCodeSelect = country.phoneCode;
                                            // countryCodeflagsvg = country.flagEmoji;
                                            //flutterToast(country.displayNameNoCountryCode, true);
                                            setState(() {});
                                          },
                                        );
                                      },
                                      show_icon: true,
                                      image: _contry
                                          ? 'assets/Images/Vector.png'
                                          : 'assets/Images/right_arrow.png',
                                      readOnly: true,
                                      onPress: () {
                                        showCountryPicker(
                                          context: context,
                                          showPhoneCode: true,
                                          onSelect: (Country country) {
                                            print(
                                                'Select country: ${country.phoneCode}');
                                            print(
                                                'Select country: ${country.name}');
                                            _Contry1.text = country.name;
                                            GetData(_Contry1.text);
                                            // countryCodeSelect = country.phoneCode;
                                            // countryCodeflagsvg = country.flagEmoji;
                                            //flutterToast(country.displayNameNoCountryCode, true);
                                            setState(() {});
                                          },
                                        );
                                      },
                                      hint: "Select",
                                      hidetext: false,
                                      controller: _Contry1),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            custom_textfield_header(
                                                text: 'State'),
                                            Custom_textfield(context,
                                                onTap: () {
                                                  setState(() {
                                                    _state = !_state;
                                                  });
                                                },
                                                show_icon: true,
                                                image: _state
                                                    ? 'assets/Images/Vector.png'
                                                    : 'assets/Images/right_arrow.png',
                                                readOnly: false,
                                                onPress: () {
                                                  setState(() {
                                                    _state = !_state;
                                                  });
                                                },
                                                hint: "Select",
                                                hidetext: false,
                                                controller: _State1),
                                            _state
                                                ? Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 7),
                                                    width: screenWidth(context),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.white,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                              1,
                                                              1,
                                                            ),
                                                            blurRadius: 4,
                                                            // spreadRadius: 1.0,
                                                          ),
                                                        ]),
                                                    child: BlocBuilder<
                                                        CityStateCubit,
                                                        CityStateState>(
                                                      builder:
                                                          (context, state) {
                                                        print(state);
                                                        if (state
                                                            is CityStateError)
                                                          return const Center(
                                                            child: Text(
                                                                "No State"),
                                                          );
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          100),
                                                              horizontal:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          30)),
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemCount:
                                                                cityandState
                                                                    .state
                                                                    ?.states
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return InkWell(
                                                                onTap: () {
                                                                  _State1
                                                                      .text = cityandState
                                                                          .state
                                                                          ?.states[
                                                                              index]
                                                                          .name ??
                                                                      '';
                                                                  _state =
                                                                      !_state;
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child: custom_text(
                                                                    text: cityandState
                                                                            .state
                                                                            ?.states[
                                                                                index]
                                                                            .name ??
                                                                        '',
                                                                    color: const Color(
                                                                        0xff303030)),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ))
                                                : SizedBox(
                                                    height: _city
                                                        ? screenHeight(context,
                                                            dividedBy: 6.35)
                                                        : 0,
                                                  )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            screenWidth(context, dividedBy: 50),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            custom_textfield_header(
                                                text: 'City'),
                                            Custom_textfield(
                                                onTap: () {
                                                  setState(() {
                                                    _city = !_city;
                                                  });
                                                },
                                                context,
                                                show_icon: true,
                                                image: _city
                                                    ? 'assets/Images/Vector.png'
                                                    : 'assets/Images/right_arrow.png',
                                                readOnly: false,
                                                onPress: () {
                                                  setState(() {
                                                    _city = !_city;
                                                  });
                                                },
                                                hint: "Select",
                                                hidetext: false,
                                                controller: _City1),
                                            _city
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 7),
                                                    width: screenWidth(context),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color: Colors.white,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                              1,
                                                              1,
                                                            ),
                                                            blurRadius: 4,
                                                            // spreadRadius: 1.0,
                                                          ),
                                                        ]),
                                                    child: BlocBuilder<
                                                        CityStateCubit,
                                                        CityStateState>(
                                                      builder:
                                                          (context, state) {
                                                        print(state);
                                                        if (state
                                                            is CityStateError)
                                                          return const Center(
                                                            child: Text(
                                                                "No State"),
                                                          );
                                                        return Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          100),
                                                              horizontal:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          30)),
                                                          child:
                                                              ListView.builder(
                                                            physics:
                                                                const ClampingScrollPhysics(),
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemCount:
                                                                cityandState
                                                                    .city
                                                                    ?.cities
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return InkWell(
                                                                  onTap: () {
                                                                    _City1
                                                                        .text = cityandState
                                                                            .city
                                                                            ?.cities[index] ??
                                                                        '';
                                                                    _city =
                                                                        !_city;
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child: custom_text(
                                                                      text: cityandState.city?.cities[
                                                                              index] ??
                                                                          '',
                                                                      color: const Color(
                                                                          0xff303030)));
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: _state
                                                        ? screenHeight(context,
                                                            dividedBy: 6.35)
                                                        : 0,
                                                  )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  custom_textfield_header(
                                      text: 'Post code / Zip code'),
                                  Custom_textfield(context,
                                      show_icon: false,
                                      readOnly: false,
                                      onPress: () {},
                                      hint: "Post code / Zip code",
                                      number: true,
                                      hidetext: false,
                                      controller: _Zipcode1),
                                  custom_textfield_header(text: 'Start Date'),
                                  Custom_textfield(context,
                                      onTap: () {
                                        setState(() {
                                          calendar = !calendar;
                                        });
                                      },
                                      show_icon: true,
                                      image: 'assets/Images/calendar.png',
                                      onPress: () {
                                        BottomPicker.date(
                                          title: 'Set your Birthday',
                                          dateOrder: DatePickerDateOrder.dmy,
                                          initialDateTime: _focusedDay,
                                          gradientColors: const [
                                            AppColor.skyBlue,
                                            AppColor.whiteskyBlue
                                          ],
                                          titlePadding: EdgeInsets.only(
                                              top: screenHeight(context,
                                                  dividedBy: 100)),
                                          height: screenHeight(context,
                                              dividedBy: 3),
                                          dismissable: true,
                                          displayCloseIcon: false,
                                          maxDateTime: DateTime(2050),
                                          minDateTime: DateTime(1980),
                                          pickerTextStyle: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          titleStyle: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.black),
                                          titleAlignment:
                                              CrossAxisAlignment.center,
                                          onChange: (index) {},
                                          onSubmit: (index) {
                                            _date.text =
                                                DateFormat('dd MMMM yyyy')
                                                    .format(index);
                                          },
                                          bottomPickerTheme:
                                              BottomPickerTheme.plumPlate,
                                        ).show(context);
                                      },
                                      hint: 'Select'.tr(),
                                      controller: _date,
                                      hidetext: false,
                                      readOnly: true),
                                  Custom_botton(
                                    context,
                                    text: 'Next',
                                    onTap: () {
                                      if (_Address1.text.isEmpty &&
                                          _Address3.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal Address",
                                            false);
                                      } else if (_Contry1.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal Contry",
                                            false);
                                      } else if (_State1.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal State",
                                            false);
                                      } else if (_City1.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal City",
                                            false);
                                      } else if (_Zipcode1.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal Zipcode",
                                            false);
                                      } else if (_date.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Your Business or Professinoal Start date",
                                            false);
                                      } else {
                                        businessDetailsCubit.BusinessDetailsService(
                                                address:
                                                    "${_Address1.text}${_Address3.text}",
                                                country: _Contry1.text,
                                                state: _State1.text,
                                                city: _City1.text,
                                                zipCode: _Zipcode1.text,
                                                context: context,
                                                startDate: _date.text)
                                            .then(
                                          (value) {
                                            setState(() {
                                              ind++;
                                            });
                                          },
                                        );
                                      }
                                    },
                                    height:
                                        screenHeight(context, dividedBy: 20),
                                  )
                                ],
                              ),
                            ),
                          )
                        : ind == 3
                            ? SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth(context, dividedBy: 15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            screenHeight(context, dividedBy: 8),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: custom_header(
                                                  text: "Profile")),
                                          skip_button(
                                            context,
                                            onTap: () {
                                              if (image == null) {
                                                flutterToast(
                                                    "Please Enter atlest 2 image or video",
                                                    false);
                                              } else if (image1 == null) {
                                                flutterToast(
                                                    "Please Enter 1 more image or video",
                                                    false);
                                              } else if (file1 == null) {
                                                flutterToast(
                                                    "Please Enter atlest 1 file like pdf,doc,etc",
                                                    false);
                                              } else {
                                                businessProfileCubit
                                                        .BusinessProfileService(
                                                            photo_1: image ??
                                                                File(''),
                                                            bio: _bio.text,
                                                            file_2: file2 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0),
                                                            file_3: file3 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0),
                                                            context: context,
                                                            photo_2: image1 ??
                                                                File(''),
                                                            photo_3: image2 ??
                                                                File(''),
                                                            photo_4: image3 ??
                                                                File(''),
                                                            photo_5: image4 ??
                                                                File(''),
                                                            photo_6: image5 ??
                                                                File(''),
                                                            file_1: file1 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0))
                                                    .then(
                                                  (value) {
                                                    setState(() {
                                                      ind++;
                                                    });
                                                  },
                                                );
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      custom_discription(
                                          text:
                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 50),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: AppColor.fontgray,
                                                    offset: Offset(
                                                      1,
                                                      1,
                                                    ),
                                                    blurRadius: 5,
                                                    // spreadRadius: 1.0,
                                                  ),
                                                ],
                                                image: _selectedimag1 != null
                                                    ? DecorationImage(
                                                        //  image: AssestImage('assets/Images/vincenzo.png'),
                                                        image: FileImage(
                                                            _selectedimag1!
                                                                .selectedFile),
                                                        fit: BoxFit.cover)
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            'assets/Images/placeHolderImage.jpg'),
                                                        fit: BoxFit.cover),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              // final ImagePicker picker = ImagePicker();
                                                                              // final image = picker.pickImage(source: ImageSource.gallery);
                                                                              // print("image ===> $image");
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,

                                                                                /// On long tap, it will be available.
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag1 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag1?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality: 10, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality:
                                                                      //     10, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag1 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag1?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor.fontgray,
                                                      offset: Offset(
                                                        1,
                                                        1,
                                                      ),
                                                      blurRadius: 5,
                                                      // spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  image: _selectedimag2 != null
                                                      ? DecorationImage(
                                                          //  image: AssetImage('assets/Images/vincenzo.png'),
                                                          image: FileImage(
                                                              _selectedimag2!
                                                                  .selectedFile),
                                                          fit: BoxFit.cover)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Images/placeHolderImage.jpg'),
                                                          fit: BoxFit.cover)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality:
                                                                            //     10, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image1 = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            onTap:
                                                                                () async {
                                                                              // final ImagePicker picker = ImagePicker();
                                                                              // final image = picker.pickImage(source: ImageSource.gallery);
                                                                              // print("image ===> $image");
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,

                                                                                /// On long tap, it will be available.
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag2 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag3?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality:
                                                                      //     10, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image1 = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag2 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag2?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor.fontgray,
                                                      offset: Offset(
                                                        1,
                                                        1,
                                                      ),
                                                      blurRadius: 5,
                                                      // spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  image: _selectedimag3 != null
                                                      ? DecorationImage(
                                                          //  image: AssetImage('assets/Images/vincenzo.png'),
                                                          image: FileImage(
                                                              _selectedimag3!
                                                                  .selectedFile),
                                                          fit: BoxFit.cover)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Images/placeHolderImage.jpg'),
                                                          fit: BoxFit.cover)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality:
                                                                            //     10, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image2 = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            onTap:
                                                                                () async {
                                                                              // final ImagePicker picker = ImagePicker();
                                                                              // final image = picker.pickImage(source: ImageSource.gallery);
                                                                              // print("image ===> $image");
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,

                                                                                /// On long tap, it will be available.
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag3 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag3?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality:
                                                                      //     10, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image2 = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag3 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag3?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 90),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor.fontgray,
                                                      offset: Offset(
                                                        1,
                                                        1,
                                                      ),
                                                      blurRadius: 5,
                                                      // spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  image: _selectedimag4 != null
                                                      ? DecorationImage(
                                                          //  image: AssetImage('assets/Images/vincenzo.png'),
                                                          image: FileImage(
                                                              _selectedimag4!
                                                                  .selectedFile),
                                                          fit: BoxFit.cover)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Images/placeHolderImage.jpg'),
                                                          fit: BoxFit.cover)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality:
                                                                            //     10, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image3 = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            onTap:
                                                                                () async {
                                                                              // final ImagePicker picker = ImagePicker();
                                                                              // final image = picker.pickImage(source: ImageSource.gallery);
                                                                              // print("image ===> $image");
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,

                                                                                /// On long tap, it will be available.
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag4 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag4?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality:
                                                                      //     10, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image3 = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag4 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag4?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor.fontgray,
                                                      offset: Offset(
                                                        1,
                                                        1,
                                                      ),
                                                      blurRadius: 5,
                                                      // spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  image: _selectedimag5 != null
                                                      ? DecorationImage(
                                                          //  image: AssetImage('assets/Images/vincenzo.png'),
                                                          image: FileImage(
                                                              _selectedimag5!
                                                                  .selectedFile),
                                                          fit: BoxFit.cover)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Images/placeHolderImage.jpg'),
                                                          fit: BoxFit.cover)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality:
                                                                            //     10, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image4 = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            onTap:
                                                                                () async {
                                                                              // final ImagePicker picker = ImagePicker();
                                                                              // final image = picker.pickImage(source: ImageSource.gallery);
                                                                              // print("image ===> $image");
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,

                                                                                /// On long tap, it will be available.
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag5 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag6?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality:
                                                                      //     10, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image4 = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag5 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag6?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                          Container(
                                              height: screenHeight(context,
                                                  dividedBy: 8),
                                              width: screenHeight(context,
                                                  dividedBy: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: AppColor.fontgray,
                                                      offset: Offset(
                                                        1,
                                                        1,
                                                      ),
                                                      blurRadius: 5,
                                                      // spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  image: _selectedimag6 != null
                                                      ? DecorationImage(
                                                          //  image: AssetImage('assets/Images/vincenzo.png'),
                                                          image: FileImage(
                                                              _selectedimag6!
                                                                  .selectedFile),
                                                          fit: BoxFit.cover)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/Images/placeHolderImage.jpg'),
                                                          fit: BoxFit.cover)),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 8),
                                                    width: screenHeight(context,
                                                        dividedBy: 8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: AppColor
                                                                .fontgray,
                                                            offset: Offset(
                                                              1,
                                                              1,
                                                            ),
                                                            blurRadius: 5,
                                                            // spreadRadius: 1.0,
                                                          ),
                                                        ],
                                                        image: _selectedimag6
                                                                    ?.selectedFile !=
                                                                null
                                                            ? DecorationImage(
                                                                //  image: AssetImage('assets/Images/vincenzo.png'),
                                                                image: FileImage(
                                                                    _selectedimag6!
                                                                        .selectedFile),
                                                                fit:
                                                                    BoxFit.fill)
                                                            : const DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/placeHolderImage.jpg'),
                                                                fit: BoxFit
                                                                    .fill)),
                                                  ),
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 0.0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height:
                                                                  screenHeight(
                                                                      context,
                                                                      dividedBy:
                                                                          3),
                                                              decoration: const BoxDecoration(
                                                                  color: AppColor
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              15),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                70)),
                                                                    child:
                                                                        const Text(
                                                                      'Add Media',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Roboto',
                                                                          fontSize:
                                                                              25,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              GestureDetector(
                                                                            // onTap: () async {
                                                                            //   final ImagePicker picker =
                                                                            //   ImagePicker();
                                                                            //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
                                                                            //   print("pickedfile ==> ${pickedFile?.path}");
                                                                            //   var result = await FlutterImageCompress
                                                                            //       .compressAndGetFile(
                                                                            //     pickedFile!.path,
                                                                            //     pickedFile.path + '_compressed.jpg',
                                                                            //     quality:
                                                                            //     100, // Adjust the quality as needed
                                                                            //   );
                                                                            //   image5 = File(result!.path);
                                                                            //   setState(() {});
                                                                            //   Navigator.pop(context);
                                                                            // },
                                                                            onTap:
                                                                                () async {
                                                                              ImagePickerPlus picker = ImagePickerPlus(context);
                                                                              SelectedImagesDetails? details = await picker.pickBoth(
                                                                                source: ImageSource.camera,
                                                                                multiSelection: true,
                                                                                galleryDisplaySettings: GalleryDisplaySettings(
                                                                                  appTheme: AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                                  cropImage: true,
                                                                                  showImagePreview: true,
                                                                                ),
                                                                              );
                                                                              print('Details ===> ${details}');
                                                                              if (details != null) {
                                                                                // compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                                _selectedimag6 = details.selectedFiles[0];
                                                                                Navigator.pop(context);
                                                                                setState(() {});
                                                                                print('selectedByte ==> ${_selectedimag6?.selectedFile}');
                                                                              }
                                                                              // if (details != null) await displayDetails(details);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/camera.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Camera',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child:
                                                                        GestureDetector(
                                                                      // onTap: () async {
                                                                      //   final ImagePicker picker =
                                                                      //   ImagePicker();
                                                                      //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                                                                      //   print("pickedfile ==> ${pickedFile?.path}");
                                                                      //   var result = await FlutterImageCompress
                                                                      //       .compressAndGetFile(
                                                                      //     pickedFile!.path,
                                                                      //     pickedFile.path + '_compressed.jpg',
                                                                      //     quality: 100, // Adjust the quality as needed
                                                                      //   );
                                                                      //   image5 = File(result!.path);
                                                                      //   setState(() {});
                                                                      //   Navigator.pop(context);
                                                                      // },
                                                                      onTap:
                                                                          () async {
                                                                        ImagePickerPlus
                                                                            picker =
                                                                            ImagePickerPlus(context);
                                                                        SelectedImagesDetails?
                                                                            details =
                                                                            await picker.pickBoth(
                                                                          source:
                                                                              ImageSource.gallery,

                                                                          /// On long tap, it will be available.
                                                                          multiSelection:
                                                                              true,
                                                                          galleryDisplaySettings:
                                                                              GalleryDisplaySettings(
                                                                            appTheme:
                                                                                AppTheme(focusColor: Colors.white, primaryColor: Colors.black),
                                                                            cropImage:
                                                                                true,
                                                                            showImagePreview:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        print(
                                                                            'Details ===> ${details}');
                                                                        if (details !=
                                                                            null) {
                                                                          //compressToHighQuality(File(details.selectedFiles[0].toString()));
                                                                          _selectedimag6 =
                                                                              details.selectedFiles[0];
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {});
                                                                          print(
                                                                              'selectedByte ==> ${_selectedimag6?.selectedFile}');
                                                                        }
                                                                        // if (details != null) await displayDetails(details);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                screenHeight(context, dividedBy: 17),
                                                                            width:
                                                                                screenWidth(context, dividedBy: 2),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                  height: screenHeight(context, dividedBy: 40),
                                                                                  width: screenWidth(context, dividedBy: 15),
                                                                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/placeholder.png'))),
                                                                                ),
                                                                                const Text(
                                                                                  'Photos',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    height: 0,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        vertical: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: screenHeight(
                                                                              context,
                                                                              dividedBy: 17),
                                                                          width: screenWidth(
                                                                              context,
                                                                              dividedBy: 2),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: screenWidth(context, dividedBy: 40)),
                                                                                height: screenHeight(context, dividedBy: 40),
                                                                                width: screenWidth(context, dividedBy: 15),
                                                                                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/video.png'))),
                                                                              ),
                                                                              const Text(
                                                                                'Videos',
                                                                                style: TextStyle(fontFamily: 'Roboto', fontSize: 17, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        width: screenHeight(
                                                            context,
                                                            dividedBy: 30),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            12)),
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/Images/add.png'),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 80),
                                      ),
                                      Text(
                                        'Pitch Deck'.tr(),
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight(context,
                                                dividedBy: 80)),
                                        // height: screenHeight(context, dividedBy: 3.5),
                                        width: screenWidth(context),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                              vertical: screenHeight(context,
                                                  dividedBy: 50)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DottedBorder(
                                                color: AppColor.skyBlue,
                                                strokeWidth: 1,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles(
                                                      type: FileType.custom,
                                                      // allowMultiple: true,
                                                      allowedExtensions: [
                                                        'jpg',
                                                        'pdf',
                                                        'doc'
                                                      ],
                                                    );
                                                    print("fille1 ======> " +
                                                        result!.count
                                                            .toString());
                                                    if (filelist.length < 3) {
                                                      filelist.add(result!.files
                                                          .toString());
                                                      if (filelist.length ==
                                                          1) {
                                                        file1 =
                                                            result.files.first;
                                                        openFile1 = result
                                                            .paths.first
                                                            .toString();
                                                        files1 = result
                                                            .names.first
                                                            .toString();
                                                        print("fille1 ======> " +
                                                            file1.toString());
                                                        print("fille1 ======> " +
                                                            result.count
                                                                .toString());
                                                      } else if (filelist
                                                              .length ==
                                                          2) {
                                                        openFile2 = result
                                                            .paths.first
                                                            .toString();
                                                        files2 = result
                                                            .names.first
                                                            .toString();
                                                        file2 =
                                                            result.files.first;
                                                        print("fille2 ======> " +
                                                            file2.toString());
                                                      } else if (filelist
                                                              .length ==
                                                          3) {
                                                        openFile3 = result
                                                            .paths.first
                                                            .toString();
                                                        files3 = result
                                                            .names.first
                                                            .toString();
                                                        file3 =
                                                            result.files.first;
                                                        print("fille3 ======> " +
                                                            file3.toString());
                                                      }
                                                    } else {
                                                      flutterToast(
                                                          'Only 3 items Add',
                                                          false);
                                                    }

                                                    // if(file1.bytes == null){
                                                    //   file1 = ;
                                                    //
                                                    // } else if(file2.bytes == null){
                                                    //   file2 = result!.files.first;
                                                    //   print("fille2 ======> " + file2.toString());
                                                    // } else {
                                                    //   file3 = result!.files.first;
                                                    //   print("fille3 ======> " + file3.toString());
                                                    // }

                                                    setState(() {});
                                                  },
                                                  child: SizedBox(
                                                    height: screenHeight(
                                                        context,
                                                        dividedBy: 13),
                                                    width: screenWidth(context,
                                                        dividedBy: 3),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: screenHeight(
                                                              context,
                                                              dividedBy: 25),
                                                          width: screenWidth(
                                                              context,
                                                              dividedBy: 10),
                                                          decoration: const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/Images/upload.png'))),
                                                        ),
                                                        const Text(
                                                          'Browse file to upload',
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .skyBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 10,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  AppColor
                                                                      .skyBlue,
                                                              fontFamily:
                                                                  'Roboto'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              filelist.length == 1
                                                  ? InkWell(
                                                      onTap: () {
                                                        print(
                                                            "data:-......${openFile1.toString()}");
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  pdfviewshow(
                                                                      pdfUrl:
                                                                          openFile1),
                                                            ),);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: screenHeight(
                                                                context,
                                                                dividedBy:
                                                                    100)),
                                                        height: screenHeight(
                                                            context,
                                                            dividedBy: 15),
                                                        width: screenWidth(
                                                            context,
                                                            dividedBy: 1.3),
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffEFF4FF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth(
                                                                      context,
                                                                      dividedBy:
                                                                          55)),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    right: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            90)),
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            27),
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/Images/file.png'))),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            23),
                                                                width: screenWidth(
                                                                    context,
                                                                    dividedBy:
                                                                        1.55),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          files1,
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: AppColor.dropdownfont),
                                                                        ),
                                                                        const Text(
                                                                          '96.47 KB',
                                                                          style: TextStyle(
                                                                              fontFamily: 'Roboto',
                                                                              fontSize: 8,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xff838383)),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              addFolderNameDialog(filelist[0]),
                                                                        );
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: AppColor
                                                                            .skyBlue,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : filelist.length == 2
                                                      ? Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                print(
                                                                    "data:-......${openFile1.toString()}");
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => pdfviewshow(
                                                                            pdfUrl:
                                                                            openFile1),
                                                                  ),);
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            100)),
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xffEFF4FF),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                6)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: screenWidth(
                                                                          context,
                                                                          dividedBy:
                                                                              55)),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            right: screenWidth(
                                                                                context,
                                                                                dividedBy: 90)),
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                27),
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                                image: DecorationImage(image: AssetImage('assets/Images/file.png'))),
                                                                      ),
                                                                      SizedBox(
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                23),
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                1.55),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  files1,
                                                                                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                                const Text(
                                                                                  '96.47 KB',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 8, fontWeight: FontWeight.w500, color: Color(0xff838383)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => addFolderNameDialog(filelist[0]),
                                                                                );
                                                                              },
                                                                              child:
                                                                                  const Icon(
                                                                                Icons.close,
                                                                                color: AppColor.skyBlue,
                                                                                size: 15,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                print(
                                                                    "data:-......${openFile1.toString()}");
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        pdfviewshow(
                                                                            pdfUrl:
                                                                            openFile2),
                                                                  ),);
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets.only(
                                                                    top: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            100)),
                                                                height:
                                                                    screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                width:
                                                                    screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                decoration: BoxDecoration(
                                                                    color: const Color(
                                                                        0xffEFF4FF),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                6)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: screenWidth(
                                                                          context,
                                                                          dividedBy:
                                                                              55)),
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            right: screenWidth(
                                                                                context,
                                                                                dividedBy: 90)),
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                27),
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                15),
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                                image: DecorationImage(image: AssetImage('assets/Images/file.png'))),
                                                                      ),
                                                                      SizedBox(
                                                                        height: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                23),
                                                                        width: screenWidth(
                                                                            context,
                                                                            dividedBy:
                                                                                1.55),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  files2,
                                                                                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                ),
                                                                                const Text(
                                                                                  '96.47 KB',
                                                                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 8, fontWeight: FontWeight.w500, color: Color(0xff838383)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => addFolderNameDialog(filelist[1]),
                                                                                );
                                                                              },
                                                                              child:
                                                                                  const Icon(
                                                                                Icons.close,
                                                                                color: AppColor.skyBlue,
                                                                                size: 15,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : filelist.length == 3
                                                          ? Column(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    print(
                                                                        "data:-......${openFile1.toString()}");
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            pdfviewshow(
                                                                                pdfUrl:
                                                                                openFile1),
                                                                      ),);
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    height: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                    width: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xffEFF4FF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: screenWidth(
                                                                              context,
                                                                              dividedBy:
                                                                                  55)),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: screenWidth(context, dividedBy: 90)),
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 27),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 15),
                                                                            decoration:
                                                                                const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/file.png'))),
                                                                          ),
                                                                          SizedBox(
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 23),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 1.55),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      files1,
                                                                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                    ),
                                                                                    const Text(
                                                                                      '96.47 KB',
                                                                                      style: TextStyle(fontFamily: 'Roboto', fontSize: 8, fontWeight: FontWeight.w500, color: Color(0xff838383)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => addFolderNameDialog(filelist[0]),
                                                                                    );
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.close,
                                                                                    color: AppColor.skyBlue,
                                                                                    size: 15,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    print(
                                                                        "data:-......${openFile1.toString()}");
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            pdfviewshow(
                                                                                pdfUrl:
                                                                                openFile2),
                                                                      ),);
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    height: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                    width: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xffEFF4FF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: screenWidth(
                                                                              context,
                                                                              dividedBy:
                                                                                  55)),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: screenWidth(context, dividedBy: 90)),
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 27),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 15),
                                                                            decoration:
                                                                                const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/file.png'))),
                                                                          ),
                                                                          SizedBox(
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 23),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 1.55),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      files2,
                                                                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                    ),
                                                                                    const Text(
                                                                                      '96.47 KB',
                                                                                      style: TextStyle(fontFamily: 'Roboto', fontSize: 8, fontWeight: FontWeight.w500, color: Color(0xff838383)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => addFolderNameDialog(filelist[1]),
                                                                                    );
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.close,
                                                                                    color: AppColor.skyBlue,
                                                                                    size: 15,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    print(
                                                                        "data:-......${openFile1.toString()}");
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            pdfviewshow(
                                                                                pdfUrl:
                                                                                openFile3),
                                                                      ),);
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: screenHeight(
                                                                            context,
                                                                            dividedBy:
                                                                                100)),
                                                                    height: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            15),
                                                                    width: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            1.3),
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(
                                                                            0xffEFF4FF),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                6)),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: screenWidth(
                                                                              context,
                                                                              dividedBy:
                                                                                  55)),
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: screenWidth(context, dividedBy: 90)),
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 27),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 15),
                                                                            decoration:
                                                                                const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/file.png'))),
                                                                          ),
                                                                          SizedBox(
                                                                            height: screenHeight(
                                                                                context,
                                                                                dividedBy: 23),
                                                                            width: screenWidth(
                                                                                context,
                                                                                dividedBy: 1.55),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      files3,
                                                                                      style: const TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.dropdownfont),
                                                                                    ),
                                                                                    const Text(
                                                                                      '96.47 KB',
                                                                                      style: TextStyle(fontFamily: 'Roboto', fontSize: 8, fontWeight: FontWeight.w500, color: Color(0xff838383)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => addFolderNameDialog(filelist[2]),
                                                                                    );
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.close,
                                                                                    color: AppColor.skyBlue,
                                                                                    size: 15,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Bio'.tr(),
                                        style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 14,
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight(context,
                                                dividedBy: 90)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
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
                                              horizontal: screenWidth(context,
                                                  dividedBy: 25),
                                              vertical: screenHeight(context,
                                                  dividedBy: 150)),
                                          child: TextField(
                                            maxLength: 250,
                                            minLines: 1,
                                            maxLines: 7,
                                            controller: _bio,
                                            cursorColor: AppColor.fontdarkgray,
                                            style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColor.dropdownfont),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'Enter some words of your Profile'
                                                        .tr(),
                                                hintStyle: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15)),
                                          ),
                                        ),
                                      ),
                                      BlocBuilder<BusinessProfileCubit,
                                          BusinessProfileState>(
                                        builder: (context, state) {
                                          if (state is BusinessProfileLoading) {
                                            return CustomBottonLoader();
                                          }
                                          return Custom_botton(
                                            context,
                                            text: 'Next',
                                            onTap: () {
                                              if (image == null) {
                                                flutterToast(
                                                    "Please Enter atlest 2 image or video",
                                                    false);
                                              } else if (image1 == null) {
                                                flutterToast(
                                                    "Please Enter 1 more image or video",
                                                    false);
                                              } else if (file1 == null) {
                                                flutterToast(
                                                    "Please Enter atlest 1 file like pdf,doc,etc",
                                                    false);
                                              } else {
                                                businessProfileCubit
                                                        .BusinessProfileService(
                                                            photo_1: image ??
                                                                File(''),
                                                            bio: _bio.text,
                                                            file_2: file2 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0),
                                                            file_3: file3 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0),
                                                            context: context,
                                                            photo_2: image1 ??
                                                                File(''),
                                                            photo_3: image2 ??
                                                                File(''),
                                                            photo_4: image3 ??
                                                                File(''),
                                                            photo_5: image4 ??
                                                                File(''),
                                                            photo_6: image5 ??
                                                                File(''),
                                                            file_1: file1 ??
                                                                PlatformFile(
                                                                    name: "",
                                                                    size: 0))
                                                    .then(
                                                  (value) {
                                                    setState(() {
                                                      ind++;
                                                    });
                                                  },
                                                );
                                              }
                                            },
                                            height: screenHeight(context,
                                                dividedBy: 20),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ind == 4
                                ? SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth(context, dividedBy: 15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 8),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: custom_header(
                                                      text:
                                                          "How would you best describe yourself? Select up to 3 of the following:")),
                                              skip_button(
                                                context,
                                                onTap: () {
                                                  if (selectedlookingFor
                                                      .isEmpty) {
                                                    flutterToast(
                                                        "Please Enter select a atlest 1 tag",
                                                        false);
                                                  } else {
                                                    describeYourSelfCubit
                                                            .DescribeYourSelfService(
                                                                array:
                                                                    selectedlookingFor,
                                                                context:
                                                                    context)
                                                        .then((value) {
                                                      setState(() {
                                                        ind++;
                                                      });
                                                    });
                                                  }
                                                  setState(() {
                                                    ind++;
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 50),
                                          ),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 1.7),
                                            child: Wrap(
                                              spacing: 200,
                                              runSpacing: 10,
                                              children: lookingFor
                                                      .map((e) => InkWell(
                                                            overlayColor:
                                                                const MaterialStatePropertyAll(
                                                                    Colors
                                                                        .white),
                                                            onTap: () {
                                                              setState(() {
                                                                selectedlookingFor
                                                                        .contains(
                                                                            e)
                                                                    ? selectedlookingFor
                                                                        .remove(
                                                                            e)
                                                                    : selectedlookingFor.length <
                                                                            3
                                                                        ? selectedlookingFor
                                                                            .add(
                                                                                e)
                                                                        : selectedlookingFor
                                                                            .remove(e);
                                                              });
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: selectedlookingFor.contains(e)
                                                                            ? const Color(
                                                                                0xff6D9Aff)
                                                                            : AppColor
                                                                                .fontgray,
                                                                        width:
                                                                            2.5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            30),
                                                                    vertical: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            280),
                                                                  ),
                                                                  child: Text(
                                                                    e,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: selectedlookingFor.contains(e)
                                                                            ? AppColor.black
                                                                            : AppColor.fontgray),
                                                                  ),
                                                                )),
                                                          ))
                                                      .toList() ??
                                                  [],
                                            ),
                                          ),
                                          Custom_botton(
                                            context,
                                            text: 'Done',
                                            onTap: () {
                                              if (selectedlookingFor.isEmpty) {
                                                flutterToast(
                                                    "Please Enter select a atlest 1 tag",
                                                    false);
                                              } else {
                                                describeYourSelfCubit
                                                        .DescribeYourSelfService(
                                                            array:
                                                                selectedlookingFor,
                                                            context: context)
                                                    .then((value) {
                                                  setState(() {
                                                    ind++;
                                                  });
                                                });
                                              }
                                            },
                                            height: screenHeight(context,
                                                dividedBy: 25),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenWidth(context, dividedBy: 15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 8),
                                          ),
                                          // custom_stepper(context, positaion: 6),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: custom_header(
                                                      text:
                                                          "Who are you looking to connect with? Select up to 3 of the following:")),
                                              skip_button(
                                                context,
                                                // onTap: () {
                                                //   Navigator.push(context,
                                                //       MaterialPageRoute(
                                                //     builder: (context) {
                                                //       return const Home_screen();
                                                //     },
                                                //   ));
                                                // },
                                                onTap: () {
                                                  if (selectedlookingFor1
                                                          .length <=
                                                      0) {
                                                    flutterToast(
                                                        "Select atlist 1 looking for tag",
                                                        false);
                                                  } else {
                                                    connectwithCubit
                                                            .ConnectwithService(
                                                                array:
                                                                    selectedlookingFor,
                                                                context:
                                                                    context)
                                                        .then(
                                                      (value) {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return const Home_screen();
                                                          },
                                                        ));
                                                      },
                                                    );
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 50),
                                          ),
                                          SizedBox(
                                            height: screenHeight(context,
                                                dividedBy: 1.7),
                                            child: Wrap(
                                              spacing: 200,
                                              runSpacing: 10,
                                              children: lookingFor
                                                      .map((e) => InkWell(
                                                            overlayColor:
                                                                const MaterialStatePropertyAll(
                                                                    Colors
                                                                        .white),
                                                            onTap: () {
                                                              setState(() {
                                                                selectedlookingFor1
                                                                        .contains(
                                                                            e)
                                                                    ? selectedlookingFor1
                                                                        .remove(
                                                                            e)
                                                                    : selectedlookingFor1.length <
                                                                            3
                                                                        ? selectedlookingFor1
                                                                            .add(
                                                                                e)
                                                                        : selectedlookingFor1
                                                                            .remove(e);
                                                              });
                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: selectedlookingFor1.contains(e)
                                                                            ? const Color(
                                                                                0xff6D9Aff)
                                                                            : AppColor
                                                                                .fontgray,
                                                                        width:
                                                                            2.5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    horizontal: screenWidth(
                                                                        context,
                                                                        dividedBy:
                                                                            30),
                                                                    vertical: screenHeight(
                                                                        context,
                                                                        dividedBy:
                                                                            280),
                                                                  ),
                                                                  child: Text(
                                                                    e,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        color: selectedlookingFor1.contains(e)
                                                                            ? AppColor.black
                                                                            : AppColor.fontgray),
                                                                  ),
                                                                )),
                                                          ))
                                                      .toList() ??
                                                  [],
                                            ),
                                          ),
                                          Custom_botton(context, text: 'Done',
                                              onTap: () {
                                            if (selectedlookingFor1.length <=
                                                0) {
                                              flutterToast(
                                                  "Select atlist 1 looking for tag",
                                                  false);
                                            } else {
                                              connectwithCubit.ConnectwithService(
                                                      array:
                                                          selectedlookingFor1,
                                                      context: context)
                                                  .then(
                                                (value) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const Home_screen();
                                                    },
                                                  ));
                                                },
                                              );
                                            }
                                          },
                                              //     onTap: () async {
                                              //         Navigator.push(context,
                                              //             MaterialPageRoute(
                                              //               builder: (context) {
                                              //                 return const Home_screen();
                                              //               },
                                              //             ));
                                              //
                                              // },
                                              height: screenHeight(context,
                                                  dividedBy: 25))
                                        ],
                                      ),
                                    ),
                                  ),
            Positioned(
                top: screenHeight(context, dividedBy: 30),
                left: screenWidth(context, dividedBy: 15),
                right: screenWidth(context, dividedBy: 15),
                child: SizedBox(
                  height: screenHeight(context, dividedBy: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              ind < 1 ? Navigator.pop(context) : ind--;
                              print(ind);
                            });
                          },
                          child: const Icon(Icons.arrow_back_ios_sharp)),
                      custom_stepper(context, positaion: ind)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
