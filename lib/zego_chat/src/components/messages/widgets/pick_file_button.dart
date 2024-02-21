import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pair_me/zego_chat/src/services/services.dart';

// import 'package:zego_zimkit/src/services/services.dart';

class ZIMKitPickFileButton extends StatelessWidget {
  const ZIMKitPickFileButton({
    Key? key,
    required this.onFilePicked,
    this.type = FileType.any,
    this.icon,
  }) : super(key: key);

  final Function(List<PlatformFile> files) onFilePicked;
  final Widget? icon;
  final FileType type;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        ZIMKit().pickFiles(type: type).then(onFilePicked);
      },
      icon: icon ??
          Icon(
            Icons.attach_file,
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.64),
          ),
    );
  }
}
