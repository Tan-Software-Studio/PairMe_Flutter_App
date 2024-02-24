import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

Widget Custom_textfield(BuildContext context,
    {required bool show_icon,
    int? mxline,
    required bool readOnly,
    Function()? onPress,
    Function(String)? onChanged,
    Function()? onTap,
    bool number = false,
    String? image,
    required String hint,
    required bool hidetext,
    required TextEditingController controller}) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(
        bottom: screenHeight(context, dividedBy: 70),
        top: screenHeight(context, dividedBy: 100)),
    height: screenHeight(context, dividedBy: 20),
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
    child: Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0,bottom: 0),
        child: TextField(

          onTap: onTap,
          onChanged: onChanged,
          enabled: true,
          maxLines: mxline ?? 1,
          minLines: 1,
          textAlign: TextAlign.justify,
          readOnly: readOnly,
          keyboardType: number ? TextInputType.number : TextInputType.text,
          controller: controller,
          cursorColor: const Color(0xffB3B3B3),
          style: const TextStyle(fontSize: 14),
          textInputAction: TextInputAction.next,
          obscureText: show_icon ? hidetext : false,
          decoration: show_icon
              ? InputDecoration(
                  // contentPadding: EdgeInsets.only(
                  //     left: screenWidth(context, dividedBy: 25),
                  //    // top: screenHeight(context, dividedBy: 150),
                  //     right: show_icon ? 0 : screenWidth(context, dividedBy: 25)),
                  border: InputBorder.none,
                  isDense: true,


                  //  suffixIcon: const Image(image: AssetImage('assets/Images/unhide.png')),
                  suffixIcon: IconButton(
                      splashRadius: 1,
                      style: const ButtonStyle(
                          overlayColor:
                              MaterialStatePropertyAll(Colors.transparent)),
                      onPressed: () {
                        onPress!();
                      },
                      icon: Image(
                        image: AssetImage(image!),
                        height: screenHeight(context, dividedBy: 40),
                        width: screenHeight(context, dividedBy: 40),
                      )),
                  // SvgPicture.asset(
                  //     'assets/Images/hide.svg',height: 10,width: 10,
                  //   //  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  //     //semanticsLabel: 'A red up arrow'
                  // ),
                  hintText: hint.tr(),
                  hintStyle: const TextStyle(
                      color: Color(0xffB3B3B3),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400))
              : InputDecoration(
              isDense: true,
                  // contentPadding: EdgeInsets.only(
                  //     left: screenWidth(context, dividedBy: 25),
                  //    // bottom: screenHeight(context, dividedBy: 150),
                  //     right: show_icon ? 0 : screenWidth(context, dividedBy: 25)),
                  border: InputBorder.none,
                  hintText: hint.tr(),
                  hintStyle: const TextStyle(
                      color: Color(0xffB3B3B3),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
        ),
      ),
    ),
  );
}
