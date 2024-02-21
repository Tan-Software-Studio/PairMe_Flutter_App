// import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Screen_Pages/splash_Screen.dart';
import 'package:pair_me/cubits/Buisness_profile.dart';
import 'package:pair_me/cubits/City&state.dart';
import 'package:pair_me/cubits/Delete_logout_user.dart';
import 'package:pair_me/cubits/Describe_yourself_cubit.dart';
import 'package:pair_me/cubits/Filter_user.dart';
import 'package:pair_me/cubits/Professional_details_update.dart';
import 'package:pair_me/cubits/ReSend_Otp_cubit.dart';
import 'package:pair_me/cubits/Reset_Password.dart';
import 'package:pair_me/cubits/Verify.dart';
import 'package:pair_me/cubits/acceptORrejectnotification.dart';
import 'package:pair_me/cubits/accept_req_msg_user.dart';
import 'package:pair_me/cubits/address_update.dart';
import 'package:pair_me/cubits/adsress_drtails.dart';
import 'package:pair_me/cubits/block_req_msg_user.dart';
import 'package:pair_me/cubits/business_add_update.dart';
import 'package:pair_me/cubits/business_address_cubit.dart';
import 'package:pair_me/cubits/change_password.dart';
import 'package:pair_me/cubits/chatdata_cubits.dart';
import 'package:pair_me/cubits/clearAllNotification_cubit.dart';
import 'package:pair_me/cubits/connect_user.dart';
import 'package:pair_me/cubits/connect_with_cubit.dart';
import 'package:pair_me/cubits/connected_user_data.dart';
import 'package:pair_me/cubits/delete_msg_users.dart';
import 'package:pair_me/cubits/forggot_password.dart';
import 'package:pair_me/cubits/login_cubit.dart';
import 'package:pair_me/cubits/message_data_cubit.dart';
import 'package:pair_me/cubits/message_req_id.dart';
import 'package:pair_me/cubits/message_user.dart';
import 'package:pair_me/cubits/notification_cubit.dart';
import 'package:pair_me/cubits/professional_details_cubit.dart';
import 'package:pair_me/cubits/profile_update.dart';
import 'package:pair_me/cubits/reject_user.dart';
import 'package:pair_me/cubits/remove_connect_user.dart';
import 'package:pair_me/cubits/show_all_users.dart';
import 'package:pair_me/cubits/show_message_requests.dart';
import 'package:pair_me/cubits/signup.dart';
import 'package:pair_me/cubits/undo_users_cubit.dart';
import 'package:pair_me/cubits/user_profile_cubit.dart';
import 'package:pair_me/cubits/user_update_cubit.dart';
import 'package:pair_me/cubits/verify_forgot_otp.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/constant.dart';
import 'package:pair_me/zego_chat/login_page.dart';
import 'package:pair_me/zego_chat/zego_zimkit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC2_y0JdEfnvqoSiHnclxQn-g_DA-WMn2U',
      appId: '1:658934152118:android:8a784db8774c4944f85f17',
      messagingSenderId: '658934152118',
      projectId: 'pair-me-76d51',
    ),
  ):await Firebase.initializeApp();

  ZIMKit().init(
    appID: appID, // your appid
    appSign: appSign, // your appSign
  );
  final navigatorKey = GlobalKey<NavigatorState>();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) async {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    await EasyLocalization.ensureInitialized();
    // final options = ChatOptions(
    //   appKey: AgoraAppkey,
    //   autoLogin: false,
    // );
    // await ChatClient.getInstance.init(options);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) async {
      runApp(EasyLocalization(
          supportedLocales: const [
            Locale('en'), // English
            Locale('hi'), // Hindi
            Locale('es'), // Spanish
            Locale('zh', 'CN'), // Simplified Chinese mandarin
            Locale('zh', 'TW'), // Traditional Chinese cantesos
          ],
          fallbackLocale: const Locale('en'),
          path: 'assets/Language',
          child: MyApp(
            navigatorKey: navigatorKey,
          )));
    });
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => VerifyCubit()),
        BlocProvider(create: (context) => CityStateCubit()),
        BlocProvider(create: (context) => AdressDetailsCubit()),
        BlocProvider(create: (context) => ProfessionalDetailsCubit()),
        BlocProvider(create: (context) => BusinessDetailsCubit()),
        BlocProvider(create: (context) => ConnectwithCubit()),
        BlocProvider(create: (context) => DescribeYourSelfCubit()),
        BlocProvider(create: (context) => UserDetailsCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
        BlocProvider(create: (context) => BusinessProfileCubit()),
        BlocProvider(create: (context) => ForgotPasswordCubit()),
        BlocProvider(create: (context) => ResendOtpCubit()),
        BlocProvider(create: (context) => VerifyForgotOtpCubit()),
        BlocProvider(create: (context) => AddressDetailsCubit()),
        BlocProvider(create: (context) => BusinessaddressUpdatesCubit()),
        BlocProvider(create: (context) => BusinessprofileupdateCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => AllUsersDetailsCubit()),
        BlocProvider(create: (context) => RejectUserCubit()),
        BlocProvider(create: (context) => ConnectUserCubit()),
        BlocProvider(create: (context) => FilterUserCubit()),
        BlocProvider(create: (context) => DeleteUserCubit()),
        BlocProvider(create: (context) => LogoutUserCubit()),
        BlocProvider(create: (context) => UserUpdateCubit()),
        BlocProvider(create: (context) => UndoUsersCubit()),
        BlocProvider(create: (context) => ProfessionalDetailsUpdateCubit()),
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => MessageCubit()),
        BlocProvider(create: (context) => ClearAllNotificationCubit()),
        BlocProvider(create: (context) => AcceptorRejectCubit()),
        BlocProvider(create: (context) => ConnectedUsersCubit()),
        BlocProvider(create: (context) => RemoveUserCubit()),
        BlocProvider(create: (context) => MessageUserCubit()),
        BlocProvider(create: (context) => MsgReqbyIDCubit()),
        BlocProvider(create: (context) => AllMessageRequestCubit()),
        BlocProvider(create: (context) => RemoveMsgUserCubit()),
        BlocProvider(create: (context) => AcceptReqMsgUserCubit()),
        BlocProvider(create: (context) => BlockUserCubit()),
        BlocProvider(create: (context) => ChatDataCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: widget.navigatorKey,

        debugShowCheckedModeBanner: false,
        locale: context.locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.skyBlue),
          useMaterial3: true,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              ZegoUIKitPrebuiltCallMiniOverlayPage(
                showUserName: true,
                contextQuery: () {
                  return widget.navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },
        home: const SpleshScreen(),
        // home: const LoginPage(),
      ),
    );
  }
}
