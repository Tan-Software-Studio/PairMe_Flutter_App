import 'package:flutter/material.dart';
import 'package:pair_me/zego_chat/home.dart';
import 'package:pair_me/zego_chat/zego_zimkit.dart';

import 'call/call_function.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Users who use the same callID can in the same call.
  final userID = TextEditingController();
  final userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: userID,
                        decoration: const InputDecoration(labelText: 'user ID'),
                      ),
                      TextFormField(
                        controller: userName,
                        decoration: const InputDecoration(labelText: 'user name'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await ZIMKit().connectUser(id: userID.text, name: userName.text);
                          await onUserLogin(userID.text, userName.text);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        },
                        child: const Text('login'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
