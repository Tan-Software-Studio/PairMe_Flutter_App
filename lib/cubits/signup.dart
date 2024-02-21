import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pair_me/Screen_Pages/login_page.dart';
import 'package:pair_me/Screen_Pages/social_sign_in/coplete_profile_screen.dart';
import 'package:pair_me/Screen_Pages/verification_code.dart';
import 'package:pair_me/Widgets/flutter_toast.dart';
import 'package:pair_me/Widgets/loading_dialog.dart';
import 'package:pair_me/helper/Apis.dart';
import 'package:pair_me/helper/Size_page.dart';
import 'package:pair_me/helper/pref_Service.dart';

import '../Screen_Pages/bottom_bar/home_screen.dart';

abstract class SignUpState {}

class SignUpInitials extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpError extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitials());

  Future<void> signUpService(
      {required String email,
      required String firstname,
      required String lastname,
      required String gender,
      required String dob,
      required String phoneNumber,
      String password = "",
      String confirmPassword = "",
      required bool terms,
      required bool isGoogleSignIn,
      required bool isFacebookSignIn,
      required BuildContext context}) async {
    emit(SignUpLoading());
    final dio = Dio();
    SharedPrefsService prefsService = SharedPrefsService();
    Map<String, dynamic> body = {
      "firstName": firstname,
      "lastName": lastname,
      "gender": gender,
      "dateOfBirth": dob,
      "phoneNumber": phoneNumber,
      "countryCode": countryCodeSelect,
      "email": email,
      "teamsAndCondition": terms,
      "isGoogleSignin": isGoogleSignIn,
      "isFacebookSignin": isFacebookSignIn,
      if (isGoogleSignIn != true && isFacebookSignIn != true) "password": password,
      if (isGoogleSignIn != true && isFacebookSignIn != true) "confirmPassword": confirmPassword,
      "language":Language

    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.signUp, data: jsonEncode(body));
      print("Response ===> ${response.data}");
      final hello = response.data;
      print(hello);
      if (hello['status'] == true) {
        print("Response ===> ${response.data}");
        emit(SignUpSuccess());
        Authtoken = "Bearer ${hello['Token']}";
        prefsService.setStringData("Authtoken", Authtoken);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Verification_code(
              Forggot: false,
              Number: phoneNumber,
            );
          },
        ));
        flutterToast(hello['message'], true);
      } else {
        emit(SignUpError());
        flutterToast(hello['message'], false);
      }
    } on Exception catch (e) {
      print("fail ====> " + e.toString());
      emit(SignUpError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }

  Future signInWithGoogle({isLoader = false, required BuildContext context}) async {
    print("in function");
    if (isLoader) {
      showLoadingDialog(context: context);
    }
    try {
      await signOutGoogle();
      GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);

      UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = authResult.user;
      if (user != null) {
        final User? currentUser = FirebaseAuth.instance.currentUser;

        assert(user.uid == currentUser!.uid);

        bool isNewUser = authResult.additionalUserInfo!.isNewUser;
        debugPrint("google sign-in isNewUser *** $isNewUser");
        debugPrint("google sign-in isNewUser *** $currentUser");

        if (isNewUser) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CompleteProfile(
                firstname: currentUser!.displayName!.toString().split(" ").first,
                lastname: currentUser!.displayName!.toString().split(" ").last,
                email:  currentUser.providerData.first.email!,
                isGoogleSignIn: true,
                isFacebookSignIn: false,
              );
            },
          ));
        } else {
          await signInWithGoogleOrFacebook(
            firstname: currentUser!.displayName!.toString().split(" ").first,
            lastname: currentUser!.displayName!.toString().split(" ").last,
            email: currentUser.providerData.first.email!,
            context: context,
            isGoogleSignIn: true,
            isFacebookSignIn: false,
          );
        }
      }

      if (isLoader) {
        hideLoadingDialog(context: context);
      }
    } catch (e) {
      if (isLoader) {
        hideLoadingDialog(context: context);
      }
      debugPrint("google sign in *** $e");
      return false;
    }
  }

  Future signInWithFacebook({isLoader = false, required BuildContext context}) async {
    print("in function");
    if (isLoader) {
      showLoadingDialog(context: context);
    }
    try {
      await signOutFacebook();
      FacebookAuth facebookAuth = FacebookAuth.instance;

      final LoginResult loginResult = await facebookAuth.login();

      print("fb status ====== ${loginResult.status}");

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      print("authResult res ======${authResult}");
      print("authResult res ======${authResult.user}");


      User? user = authResult.user;

      debugPrint("facebook sign-in  ***-=-=-= ${user!.email}");
      debugPrint("facebook sign-in  ***-=-=-= ${user!.displayName}");

      bool isNewUser = authResult.additionalUserInfo!.isNewUser;
      debugPrint("facebook sign-in isNewUser *** $isNewUser");
      debugPrint("facebook sign-in isNewUser *** ${user.providerData.first.email}");

      if (isNewUser) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CompleteProfile(
              firstname: user!.displayName!.toString().split(" ").first,
              lastname: user!.displayName!.toString().split(" ").last,
              email: user.providerData.first.email!,
              isGoogleSignIn: false,
              isFacebookSignIn: true,
            );
          },
        ));
      } else {
        await signInWithGoogleOrFacebook(
          firstname: user!.displayName!.toString().split(" ").first,
          lastname: user!.displayName!.toString().split(" ").last,
          email: user.providerData.first.email!,
          context: context,
          isGoogleSignIn: false,
          isFacebookSignIn: true,
        );
      }
      debugPrint('signInWithfacebooksucceeded: $user');
      if (isLoader) {
        hideLoadingDialog(context: context);
      }
    } catch (e) {
      if (isLoader) {
        hideLoadingDialog(context: context);
      }
      debugPrint("facebook sign in Exception $e");
      return false;
    }
  }

  Future<void> signOutGoogle({isLoader = false}) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  Future<void> signOutFacebook({isLoader = false}) async {
    FacebookAuth facebookAuth = FacebookAuth.instance;
    await facebookAuth.logOut();
  }

  Future<void> signInWithGoogleOrFacebook({
    required String email,
    required String firstname,
    required bool isGoogleSignIn,
    required bool isFacebookSignIn,
    required String lastname,
    required BuildContext context,
  }) async {
    emit(SignUpLoading());
    final dio = Dio();
    SharedPrefsService prefsService = SharedPrefsService();
    Map<String, dynamic> body = {
      "email": email,
    };
    print("Body is $body");
    try {
      final response = await dio.post(apis.signInWithGoogleOrFacebook, data: jsonEncode(body));
      print("Response ===> ${response.data}");
      final hello = response.data;
      print(hello);
      if (hello['message'] == "This User Not Existing") {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return CompleteProfile(
              firstname: firstname.split(" ").first,
              lastname: lastname.split(" ").last,
              email: email,
              isGoogleSignIn: isGoogleSignIn,
              isFacebookSignIn: isFacebookSignIn,
            );
          },
        ));
      } else {
        if (hello['status'] == true) {
          print("Response ===> ${response.data}");
          emit(SignUpSuccess());
          Authtoken = "Bearer ${hello['Token']}";
          prefsService.setStringData("Authtoken", Authtoken);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Home_screen(),
              ),
              (route) => false);
          flutterToast(hello['message'], true);
        } else {
          emit(SignUpError());
          flutterToast(hello['message'], false);
        }
      }
    } on Exception catch (e) {
      print("fail ====> " + e.toString());
      emit(SignUpError());
      flutterToast("Something went wrong!", false);
      // TODO
    }
  }
}
//Signup Successfully
