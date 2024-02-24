import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Screen_Pages/forgot_password.dart';
import 'package:pair_me/Screen_Pages/sign_up_page.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_loader.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/login_cubit.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';

String countryCodeSelect = '1';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool showpassword = true;
  final TextEditingController _Email = TextEditingController();
  final TextEditingController _Password = TextEditingController();
  SharedPrefsService prefsService = SharedPrefsService();
  LoginCubit loginCubit = LoginCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCubit = BlocProvider.of<LoginCubit>(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Background_Img(context),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight(context,dividedBy: 10),),
                    custom_header(text: "Login"),
                    custom_discription(text: "counter1"),
                    SizedBox(height: screenHeight(context,dividedBy: 50),),
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
                        controller: _Email,
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
                                    // countryCodeflagsvg = country.flagEmoji;
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
                            // SvgPicture.asset(
                            //     'assets/Images/hide.svg',height: 10,width: 10,
                            //   //  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                            //     //semanticsLabel: 'A red up arrow'
                            // ),
                            hintText: 'Phone Number'.tr(),
                            hintStyle: const TextStyle(
                                color: Color(0xffB3B3B3),
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    custom_textfield_header(text: 'Password'),
                    Custom_textfield(context, show_icon: true, onPress: () {
                        setState(() {
                          showpassword = !showpassword;
                          print('show_Password :$_Password');
                        });
                      }, image: showpassword  ? 'assets/Images/visibility_off.png': 'assets/Images/visibility.png', hint: 'Enter your password', controller: _Password, hidetext: showpassword, readOnly: false),
                    Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(context,
                                dividedBy: 90)),
                        child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return const Forget_Password();
                                  },));
                                },
                                child: Text('Forgot Password?'.tr(),style: const TextStyle(fontFamily: 'Roboto',fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xff437DFF)) ,),
                              ),
                            ]),
                      ),
                    BlocBuilder<LoginCubit,LoginState>(builder: (context, state) {
                      if(state is LoginLoading){
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 13)),
                          child: Center(child: customLoader(),),
                        );
                      }
                      return Center(
                        child: Custom_botton(context, text: 'Login', onTap: () async {
                          if(_Email.text.isEmpty){
                            flutterToast('Please Enter Valid Phone number', false);
                          } else if(_Password.text.isEmpty) {
                            flutterToast('Please Enter Password', false);
                          } else {
                            loginCubit.LoginService(phoneNumber: _Email.text, otp: _Password.text, context: context);
                          }
                        }, height: screenHeight(context,dividedBy: 13),),
                      );
                    },),
                    Row(children: <Widget>[
                        Expanded(
                          child:  Container(
                              margin: const EdgeInsets.only(left: 30.0, right: 20.0),
                              child: const Divider(
                                color: Color(0xff888888),
                                height: 36,
                              )),
                        ),
                        const Text("OR",style: TextStyle(color: Color(0xff888888),fontWeight: FontWeight.w400,fontFamily: 'Roboto'),),
                        Expanded(
                          child:  Container(
                              margin: const EdgeInsets.only(left: 20.0, right: 30.0),
                              child: const Divider(
                                color: Color(0xff888888),
                                height: 36,
                              )),
                        ),
                      ]),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: screenHeight(context,dividedBy: 60)),
                      height: screenHeight(context,dividedBy: 20),
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(9),
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
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                          //  margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: screenHeight(context,dividedBy: 40),
                            width: screenHeight(context,dividedBy: 40),
                            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Images/google.png'))),
                          ),
                           SizedBox(width: screenWidth(context,dividedBy: 40),),
                           Text("Login with Google".tr(),style: const TextStyle(color: Color(0xff888888),fontWeight: FontWeight.w400,fontFamily: 'Roboto'),),
                        ],
                      ),
                    ),
                    Center(
                        child: Container(
                          height: screenHeight(context,dividedBy: 20),
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(9),
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
                              ]
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                               // margin: const EdgeInsets.symmetric(horizontal: 5),
                                height: screenHeight(context,dividedBy: 37),
                                width: screenHeight(context,dividedBy: 60),
                                decoration: const BoxDecoration(
                                 // color: Colors.red,
                                    image: DecorationImage(image: AssetImage('assets/Images/facebook.png'),fit: BoxFit.fitHeight)),
                              ),
                              SizedBox(width: screenWidth(context,dividedBy: 50),),
                               Text("Login with Facebook".tr(),style: const TextStyle(color: Color(0xff888888),fontWeight: FontWeight.w400,fontFamily: 'Roboto'),),

                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical:screenHeight(context,dividedBy: 25) ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Don’t have an account?".tr(),style: TextStyle(color: Color(0xff888888),fontSize: 15  ,fontWeight: FontWeight.w400,fontFamily: 'Roboto'),),
                          InkWell(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const SignUp_page();
                            },));
                          },
                              child: Text("Sign Up".tr(),style: TextStyle(color: Color(0xff231F20),fontSize: 15  ,fontWeight: FontWeight.w600,fontFamily: 'Roboto'),)),
                      ],),
                    )
                  ],),
              ),
            ),
          ],
        )

      ),
    );
  }
}
