import 'package:animate_do/animate_do.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Screen_Pages/set_password_page.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/chatdata_cubits.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

class SignUp_page extends StatefulWidget {
  const SignUp_page({super.key});

  @override
  State<SignUp_page> createState() => _SignUp_pageState();
}

class _SignUp_pageState extends State<SignUp_page> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _eMail = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _date = TextEditingController();
  ChatDataCubit chatDataCubit = ChatDataCubit();
  RegExp regExp =  RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  String gender = '';
  bool popup = false;
  bool popup1 = false;
  bool calendar = false;
  bool calendar1 = false;
  bool select = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
  }
  final translator = GoogleTranslator();

  Future<String> translateText(String text) async {
    // Translate the text to the target language
    Translation translation =
    await translator.translate(text, to: 'en');

    // Return the translated text
    return translation.text;
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
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context, dividedBy: 15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(context, dividedBy: 10),
                    ),
                    custom_header(text: "Sign Up"),
                    custom_discription(text: "counter1"),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 50),
                    ),
                    custom_textfield_header(text: 'First Name'),
                    Custom_textfield(context,
                        show_icon: false,
                        onPress: () {},
                        hint: 'Enter your first name',
                        controller: _firstName,
                        hidetext: false,
                        readOnly: false),
                    custom_textfield_header(text: 'Last Name'),
                    Custom_textfield(context,
                        show_icon: false,
                        onPress: () {},
                        hint: 'Enter your last name',
                        controller: _lastName,
                        hidetext: false,
                        readOnly: false),
                    custom_textfield_header(text: 'Gender'),
                    Custom_textfield(context, show_icon: true, onTap: () {
                      setState(() {
                        popup = !popup;
                      });
                    }, onPress: () {
                      setState(() {
                        popup = !popup;
                      });
                    },
                        image: popup
                            ? 'assets/Images/Vector.png'
                            : 'assets/Images/right_arrow.png',
                        hint: 'Select Gender',
                        controller: _gender,
                        hidetext: false,
                        readOnly: true),
                    popup
                        ? FadeInDown(
                            animate: true,
                            from: 7,
                            child: Container(
                              height: screenHeight(context, dividedBy: 10),
                              width: screenWidth(context),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        1,
                                        1,
                                      ),
                                      blurRadius: 4,
                                      spreadRadius: 0.0,
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 25),
                                        child: Radio(
                                          value: "Female",
                                          groupValue: gender,
                                          activeColor: AppColor.skyBlue,
                                          onChanged: (value) {
                                            setState(() {
                                              gender = value!;
                                              _gender.text = gender;
                                              popup = !popup;
                                              print("value :$value");
                                            });
                                          },
                                        ),
                                      ),
                                      const Text(
                                        "Female",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303030),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: screenHeight(context,
                                            dividedBy: 25),
                                        child: Radio(
                                          value: "Male",
                                          groupValue: gender,
                                          activeColor: AppColor.skyBlue,
                                          onChanged: (value) {
                                            setState(() {
                                              gender = value!;
                                              _gender.text = gender;
                                              popup = !popup;
                                              print("value :$value");
                                            });
                                          },
                                        ),
                                      ),
                                      const Text(
                                        "Male",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff303030),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Roboto'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    custom_textfield_header(text: 'Date of Birth'),
                    Custom_textfield(context,
                        show_icon: true,
                        onTap: () {
                          BottomPicker.date(
                            title: 'Set your Birthday',
                            dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: _focusedDay,
                            gradientColors: [AppColor.skyBlue,AppColor.whiteskyBlue],
                            titlePadding: EdgeInsets.only(top: screenHeight(context,dividedBy: 100)),
                            height: screenHeight(context,dividedBy: 3),
                            dismissable: true,
                            displayCloseIcon: false,
                            maxDateTime: DateTime(2050),
                            minDateTime: DateTime(1980),
                            pickerTextStyle: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            titleStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                color: AppColor.black),
                            titleAlignment: CrossAxisAlignment.center,
                            onChange: (index) {

                            },
                            onSubmit: (index) {
                              _date.text = DateFormat('dd MMMM yyyy').format(index);
                            },
                            bottomPickerTheme: BottomPickerTheme.plumPlate,
                          ).show(context);
                        },
                        image: 'assets/Images/calendar.png',
                        onPress: () {
                          BottomPicker.date(
                            title: 'Set your Birthday',
                            dateOrder: DatePickerDateOrder.dmy,
                            initialDateTime: _focusedDay,
                            gradientColors: [AppColor.skyBlue,AppColor.whiteskyBlue],
                            titlePadding: EdgeInsets.only(top: screenHeight(context,dividedBy: 100)),
                            height: screenHeight(context,dividedBy: 3),
                            dismissable: true,
                            displayCloseIcon: false,
                            maxDateTime: DateTime(2050),
                            minDateTime: DateTime(1980),
                            pickerTextStyle: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            titleStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                                color: AppColor.black),
                            titleAlignment: CrossAxisAlignment.center,
                            onChange: (index) {

                            },
                            onSubmit: (index) {
                              _date.text = DateFormat('dd MMMM yyyy').format(index);
                            },
                            bottomPickerTheme: BottomPickerTheme.plumPlate,
                          ).show(context);
                        },
                        hint: 'Select'.tr(),
                        controller: _date,
                        hidetext: false,
                        readOnly: true),
                    custom_textfield_header(text: 'Phone Number'),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenHeight(context, dividedBy: 75)),
                      height: screenHeight(context, dividedBy: 20),
                      // width: screenWidth(context,dividedBy: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.fontgray,
                              offset: Offset(
                                1,
                                1,
                              ),
                              blurRadius: 4,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: TextField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        cursorColor: const Color(0xffB3B3B3),
                        style: const TextStyle(fontSize: 14),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            // contentPadding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 25)),
                            border: InputBorder.none,
                            //  suffixIcon: const Image(image: AssetImage('assets/Images/unhide.png')),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    print(
                                        'Select country: ${country.phoneCode}');
                                    countryCodeSelect = country.phoneCode;
                                  //  countryCodeflagsvg = country.flagEmoji;
                                    //flutterToast(country.displayNameNoCountryCode, true);
                                    setState(() {});
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: screenWidth(context, dividedBy: 25)),
                                alignment: Alignment.center,
                                width: screenWidth(context, dividedBy: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 1)
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 70)),
                                      Text(
                                        "+$countryCodeSelect",
                                        style: TextStyle(
                                            fontSize:
                                                countryCodeSelect.length <= 3
                                                    ? 13
                                                    : 14,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.dropdownfont),
                                      ),
                                      const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: AppColor.dropdownfont,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width:
                                            screenWidth(context, dividedBy: 70),
                                      )
                                    ]),
                              ),
                            ),
                            hintText: 'Phone Number'.tr(),
                            hintStyle: const TextStyle(
                                color: Color(0xffB3B3B3),
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    custom_textfield_header(text: 'E-mail'),
                    Custom_textfield(context,
                        show_icon: false,
                        onPress: () {},
                        hint: 'Enter your email',
                        controller: _eMail,
                        hidetext: false,
                        readOnly: false),
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          select = !select;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            height: screenHeight(context, dividedBy: 45),
                            width: screenHeight(context, dividedBy: 45),
                            color: const Color(0xffD4E2FF),
                            child: Center(
                              child: select
                                  ? Container(
                                      height:
                                          screenHeight(context, dividedBy: 65),
                                      width:
                                          screenHeight(context, dividedBy: 65),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/Images/check.png'),
                                              fit: BoxFit.fill)),
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth(context, dividedBy: 50),
                          ),
                          Text(
                            'Agree to our EULA / T&Cs',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                color: select
                                    ? const Color(0xff303030)
                                    : const Color(0xffB3B3B3)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context, dividedBy: 25),
                    ),
                    Center(
                      child: Custom_botton(
                        context,
                        text: 'Next',

                        onTap: () {

                          if (_firstName.text.isEmpty) {
                            flutterToast("Please Enter FirstName", false);
                          } else if (_lastName.text.isEmpty) {
                            flutterToast("Please Enter LastName", false);
                          } else if (gender.isEmpty) {
                            flutterToast("Please Enter Gender", false);
                          } else if (_date.text.isEmpty) {
                            flutterToast("Please Enter Date of Birth", false);
                          } else if (_phoneNumber.text.isEmpty) {
                            flutterToast("Please Enter Your Phonenumber", false);
                          } else if(10 > _phoneNumber.text.length){
                            flutterToast("Please Enter valid number", false);
                          }else if (_eMail.text.isEmpty) {
                            flutterToast("Please Enter your email", false);
                          } else  if (select == false) {
                            flutterToast("Please Agree to the terms & conditions ", false);
                          } else if(regExp.hasMatch(_eMail.text)){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Set_Password(
                                  firstname: _firstName.text.trim(),
                                  lastname: _lastName.text.trim(),
                                  gender: gender,
                                  dob: _date.text,
                                  number: _phoneNumber.text,
                                  email: _eMail.text,
                                  T_C: select,
                                );
                              },
                            ));
                          } else {
                            flutterToast("Please Enter valid Email ", false);
                          }
                        },
                        height: screenHeight(context, dividedBy: 570),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context, dividedBy: 35)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(
                            "Already have an account?".tr(),
                            style: const TextStyle(
                                color: Color(0xff888888),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          InkWell(
                              onTap: () async {
                                // changeLang(_firstName.text);
                                // chatDataCubit.ChatDataService(array: [
                                //   {
                                //     "firstName": await translateText(_firstName.text.trim()),
                                //     "lastName":await translateText(_lastName.text.trim()),
                                //     "gender": await translateText(gender.trim()),
                                //     "dateOfBirth":await translateText(_date.text.trim()),
                                //     "phoneNumber": await translateText(_phoneNumber.text.trim()),
                                //     "email": await translateText(_eMail.text),
                                //   },
                                // ], context: context);
                                Navigator.pop(context);
                              },
                              child:  Text(
                                "Log In".tr(),
                                style: const TextStyle(
                                    color: Color(0xff231F20),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Roboto'),
                              )),
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
