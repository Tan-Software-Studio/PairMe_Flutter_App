import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

class Language_Screen extends StatefulWidget {
  const Language_Screen({super.key});

  @override
  State<Language_Screen> createState() => _Language_ScreenState();
}

class _Language_ScreenState extends State<Language_Screen> {
  bool language = false;
  bool show_box = false;
  String _selected_language = '';
  final List _language = [
    'English',
    'Spanish',
    'Hindi',
    'Cantonese',
    'Mandarin',
  ];
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
             Padding(
               padding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy:15)),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: screenHeight(context,dividedBy: 10),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     custom_header(text: 'Language'),
                    // custom_header(text: AppLocalization.of(context).getTranslatedValue("Language").toString()),
                     skip_button(context, onTap: () {
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login_page(),), (route) => false);
                     },)
                   ],
                 ),
                 custom_discription(text: 'counter'),
                 SizedBox(height: screenHeight(context,dividedBy: 50),),
                 Container(
                   height: screenHeight(context,dividedBy: 20),
                   width: screenWidth(context,dividedBy: 1.15),
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
                       ]
                   ),
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 30)),
                     child:   InkWell(
                       onTap: () {
                         setState(() {
                           language = !language;
                           if(language == false){
                             show_box = !show_box;
                             Timer(const Duration(milliseconds: 600), () {
                               setState(() {
                                 show_box = !show_box;
                               });
                             });
                           }

                         });
                       },
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          _selected_language == '' ?   Text("Select".tr(),style: TextStyle(color: AppColor.fontgray,fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Roboto"),):
                            Text(_selected_language.tr(),style: const TextStyle(color: AppColor.black,fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Roboto"),),
                           language ? const Icon(Icons.keyboard_arrow_down_outlined,size: 25,color: AppColor.fontgray,) : const Icon(Icons.arrow_forward_ios_sharp,size: 15,color: AppColor.fontgray,)
                         ],
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: screenHeight(context,dividedBy: 60),),
                 language ?
                 FadeInDown(
                   animate: true,
                   from: 10,
                   child: Container(
                     height: screenHeight(context,dividedBy: 6.7),
                     width: screenWidth(context,dividedBy: 1.15),
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
                         ]
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                       child: ListView.builder(
                         physics: const ClampingScrollPhysics(),
                         itemCount: _language.length,
                         padding: EdgeInsets.zero,
                         itemBuilder: (context, index) {
                         return Padding(
                           padding: EdgeInsets.only(bottom: screenHeight(context,dividedBy: 200)),
                           child: InkWell(
                             onTap: () {
                               setState(() {
                                 _selected_language = _language[index];
                                 language = !language;
                                 if(language == false){
                                   show_box = !show_box;
                                   if(_selected_language == 'English') {
                                     context.setLocale(const Locale('en'));
                                     Language = "english";
                                   }
                                   if(_selected_language == 'Spanish') {
                                     context.setLocale(const Locale('es'));
                                     Language = "spanish";
                                   }
                                   if(_selected_language == 'Hindi') {
                                     context.setLocale(const Locale('hi'));
                                     Language = "hindi";
                                   }
                                   if(_selected_language == 'Cantonese') {
                                     context.setLocale(const Locale('zh', 'TW'));
                                     Language = "cantonese";
                                   }
                                   if(_selected_language == 'Mandarin') {
                                     context.setLocale(const Locale('zh', 'CN'));
                                     Language = "mandarin";
                                   }
                                  // _selected_language == 'English' ? context.setLocale(const Locale('en')) :_selected_language == 'Spanish' ? context.setLocale(Locale('sp')) : context.setLocale(Locale('man'));
                                   Timer(const Duration(milliseconds: 600), () {
                                     setState(() {
                                       show_box = !show_box;
                                     });
                                   });
                                 }
                               });
                             },
                               child: custom_text(text: _language[index], color: AppColor.dropdownfont)),
                         );
                       },)
                     ),
                   ),
                 ) : show_box ?
                 FadeOutUp(
                   animate: true,
                   from: 10,
                   child: Container(
                     height: screenHeight(context,dividedBy: 6.7),
                     width: screenWidth(context,dividedBy: 1.15),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(7),
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
                         ]
                     ),
                     child: Padding(
                         padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                         child: ListView.builder(
                           itemCount: _language.length,
                           padding: EdgeInsets.zero,
                           itemBuilder: (context, index) {
                             return Padding(
                               padding: EdgeInsets.only(bottom: screenHeight(context,dividedBy: 200)),
                               child: custom_text(text: _language[index], color: AppColor.dropdownfont),
                             );
                           },)
                     ),
                   ),
                 ) : const SizedBox(),
                 const Spacer(),
                 Custom_botton(context, text: "Next", onTap: () {
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_page(),), (route) => false);
                 }, height: screenHeight(context,dividedBy: 20))
               ],),
             ),
         ],)

      ),
    );
  }
}
