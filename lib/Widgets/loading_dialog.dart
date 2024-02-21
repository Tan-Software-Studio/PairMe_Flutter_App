import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../helper/App_Colors.dart';

void showLoadingDialog({required BuildContext context}) {
  Future.delayed(
    Duration.zero,
    () {
      showDialog(
          context: context,
          builder: (context) =>  Center(
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SpinKitSpinningLines(
                  color: AppColor.skyBlue,
                  size: 50.0,
                ),
              ),
            ),
          ),);
    },
  );
}

void hideLoadingDialog({bool istrue = false,required BuildContext context}) {
  Navigator.of(context).pop();
}
