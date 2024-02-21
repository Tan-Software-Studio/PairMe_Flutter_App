import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/cubits/translation_cubit.dart';

// import 'package:zego_zimkit/zego_zimkit.dart';

// import '../zego_call/zego_zimkit.dart';

class HomePagePopupMenuButton extends StatefulWidget {
  const HomePagePopupMenuButton({Key? key}) : super(key: key);

  @override
  State<HomePagePopupMenuButton> createState() => _HomePagePopupMenuButtonState();
}

class _HomePagePopupMenuButtonState extends State<HomePagePopupMenuButton> {
  final userIDController = TextEditingController();
  final groupNameController = TextEditingController();
  final groupUsersController = TextEditingController();
  final groupIDController = TextEditingController();
  TranslationCubit translationCubit = TranslationCubit();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      position: PopupMenuPosition.under,
      icon: const Icon(CupertinoIcons.add_circled),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'English',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('English', maxLines: 1)),
            onTap: () async {
              await translationCubit.changeLanguage(
                language: 'english',
              );
            },
          ),
          PopupMenuItem(
            value: 'Spanish',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('Spanish', maxLines: 1)),
            onTap: () async {
              await translationCubit.changeLanguage(language: 'spanish');
            },
          ),
          PopupMenuItem(
            value: 'Hindi',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('Hindi', maxLines: 1)),
            onTap: () async {
              await translationCubit.changeLanguage(
                language: 'hindi',
              );
            },
          ),
          PopupMenuItem(
            value: 'Mandarin',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('Mandarin', maxLines: 1)),
            onTap: () async {
              await translationCubit.changeLanguage(
                language: 'mandarin',
              );
            },
          ),
          PopupMenuItem(
            value: 'Cantonese',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('Cantonese', maxLines: 1)),
            onTap: () async {
              await translationCubit.changeLanguage(
                language: 'cantonese',
              );
            },
          ),
/*          PopupMenuItem(
            value: 'New Chat',
            child:
                const ListTile(leading: Icon(CupertinoIcons.chat_bubble_2_fill), title: Text('New Chat', maxLines: 1)),
            onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
          ),
          PopupMenuItem(
            value: 'New Group',
            child: const ListTile(leading: Icon(CupertinoIcons.person_2_fill), title: Text('New Group', maxLines: 1)),
            onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
          ),
          PopupMenuItem(
            value: 'Join Group',
            child: const ListTile(leading: Icon(Icons.group_add), title: Text('Join Group', maxLines: 1)),
            onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
          ),*/
        ];
      },
    );
  }
}
