import 'package:flutter/material.dart';
import 'package:pair_me/Widgets/Background_img.dart';
import 'package:pair_me/cubits/translation_cubit.dart';
import 'package:pair_me/zego_chat/popup_menu.dart';
import 'package:pair_me/zego_chat/zego_zimkit.dart';

// import 'package:zego_zimkit/zego_zimkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool emojiShowing = false;
  bool showCard = false;
  TranslationCubit translationCubit = TranslationCubit();

  @override
  void initState() {
    // loginUser();
    showCard = false;
    super.initState();
  }

  loginUser() async {
    await ZIMKit().connectUser(
      id: '2222',
      name: 'sagar',
      /*avatarUrl:
            "https://blogger.googleusercontent.com/img/a/AVvXsEi4zbsikebIaYJUW5esbB4Co9gd2p91-EVENGDSutmgwaPqo-C9ES9R0oYSJqXg9iedKKUjJtH1ev98yX-M8-K0dmZD-qZj4y0Km_CV8-Knzhh8oidU2J067cRUBkANhs1zD9ntUhukTt4FcyVErltRdlQkvFYjrzAdhl-J3AQEnHTHqd7nw2ykkElVx8lS"*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Zego Chat'),
          actions: [HomePagePopupMenuButton()],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                  messageInputContainerDecoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inputBackgroundDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  messageContentBuilder: (context, message, defaultWidget) {
                    return defaultWidget;
                  },
                  messageListBackgroundBuilder: (context, defaultWidget) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Background_Img(context),
                        defaultWidget,
                      ],
                    );
                  },
                );
              },
            ));
          },
        ),
      ),
    );
  }
}
