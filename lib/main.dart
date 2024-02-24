import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair_me/Screen_Pages/Step_Screens.dart';
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
import 'package:pair_me/firebase_options.dart';
import 'package:pair_me/helper/App_Colors.dart';
import 'package:pair_me/helper/Size_page.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("message ===> $message");
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
        color: Colors.white,
        title: message.notification?.title ?? '',
        body: message.notification?.body,
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Colors.orange
      ),
  actionButtons: [
    NotificationActionButton(key: "ACCEPT", label: "Accept",color: Colors.greenAccent,autoDismissible: true),
    NotificationActionButton(key: "REJECT", label: "Reject",color: Colors.redAccent,autoDismissible: true),
  ]
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "call_channel",
        channelName: "call_channel",
        channelDescription: "channel of calling",
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone)
  ]);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final options = ChatOptions(
    appKey: AgoraAppkey,
    autoLogin: false,
  );
  await ChatClient.getInstance.init(options);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
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
        child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider(create: (context) => MessageUserCubit()),
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
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.skyBlue),
          useMaterial3: true,
        ),
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        home: const SpleshScreen(),
       // home: const StepScreen(),
      ),
    );
  }
}
