import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';

// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitPickMediaButton extends StatelessWidget {
  const ZIMKitPickMediaButton({
    Key? key,
    required this.onFilePicked,
    this.icon,
  }) : super(key: key);

  final Function(List<PlatformFile> files) onFilePicked;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        ZIMKit().pickFiles(type: FileType.media).then(onFilePicked);
      },
      icon: icon ??
          Icon(
            Icons.photo_library,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
          ),
    );
  }
}