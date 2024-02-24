import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Screen_Pages/address_details.dart';
import 'package:pair_me/Screen_Pages/verification_code.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/Widgets/custom_button.dart';
import 'package:pair_me/Widgets/custom_texts.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/Widgets/textfield.dart';
import 'package:pair_me/cubits/signup.dart';
import 'package:pair_me/helper/Size_page.dart';

class Set_Password extends StatefulWidget {
  String firstname,lastname,gender,dob,number,email;
  bool T_C;
  Set_Password({super.key,required this.firstname,required this.lastname,required this.gender,required this.dob,required this.number,required this.email,required this.T_C});

  @override
  State<Set_Password> createState() => _Set_PasswordState();
}

class _Set_PasswordState extends State<Set_Password> {
  SignUpCubit signUpCubit = SignUpCubit();
  final TextEditingController _Password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  RegExp regExp =  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool hidePassword = true;
  bool hideconfirmPassword = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpCubit = BlocProvider.of<SignUpCubit>(context);
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth(context,dividedBy: 15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight(context,dividedBy: 10),),
                  custom_header(text: "Set your Password"),
                  custom_discription(text: "counter1"),
                  SizedBox(height: screenHeight(context,dividedBy: 50),),
                  custom_textfield_header(text: 'Password'),
                  Custom_textfield(context, show_icon: true, onPress: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  }, image: hidePassword == false ? 'assets/Images/visibility_off.png': 'assets/Images/visibility.png', hint: 'Enter your password', controller: _Password, hidetext: hidePassword, readOnly: false),
                  custom_textfield_header(text: 'Confirm Password'),
                  Custom_textfield(context, show_icon: true, onPress: () {
                    setState(() {
                      hideconfirmPassword = !hideconfirmPassword;
                    });
                  },  hint: 'Enter your confirm password', image: hideconfirmPassword == false ? 'assets/Images/visibility_off.png': 'assets/Images/visibility.png',controller: _confirmPassword, hidetext: hideconfirmPassword, readOnly: false),
                  const Spacer(),
                  Custom_botton(context, text: 'Save',
                  // onTap: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //     return  Verification_code(Forggot: false, Number: widget.number,);
                  //   },));
                  // },
                    onTap: () {
                    if(_Password.text.isEmpty){
                      flutterToast("Please Enter Your Password", false);
                    }else if(regExp.hasMatch(_Password.text)){
                      if (_confirmPassword.text.isEmpty){
                        flutterToast("Please Enter Your Confirm Password", false);
                      }else if (_confirmPassword.text != _Password.text){
                        flutterToast("Please Enter Password And Confirm Password are same", false);
                      }else {
                        signUpCubit.signUpService(email: widget.email, firstname: widget.firstname, lastname: widget.lastname, phoneNumber: widget.number, password: _Password.text, confirmPassword: _confirmPassword.text, context: context, gender: widget.gender, dob: widget.dob, terms: widget.T_C);
                      }
                    }else {
                      flutterToast("please enter at lest 1 upper case and 1 lower case and 1 digit and 1 special carecter and at least 8 characters", false);
                    }
                  },
                    height: screenHeight(context,dividedBy: 20),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
