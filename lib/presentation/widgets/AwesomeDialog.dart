import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AwesomeDialogShow {
  static void showAwesomeDialog(
    BuildContext context, {
    required String title,
    bool btnOk = false,
    bool btnCancel = false,
    Function()? buttonOkOnTap,
    Function()? buttonCancelOnTap,
    Color? btnOkColor,
    Color? btnCancelColor,
    bool btnOkIcon = false,
    DialogType dialogType = DialogType.WARNING,
  }) {
    if (btnOk && !btnCancel) {
      AwesomeDialog(
        context: context,
        dialogType: dialogType,
        headerAnimationLoop: true,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        closeIcon: const Icon(Icons.close),
        title: title,
        btnOkOnPress: buttonOkOnTap,
        btnOkIcon: btnOkIcon ? Icons.check_circle : null,
        btnOkColor: btnOkColor,
      ).show();
    } else if (btnCancel) {
      AwesomeDialog(
        context: context,
        dialogType: dialogType,
        headerAnimationLoop: true,
        animType: AnimType.TOPSLIDE,
        showCloseIcon: true,
        closeIcon: const Icon(Icons.close),
        title: title,
        btnOkOnPress: buttonOkOnTap,
        btnOkIcon: btnOkIcon ? Icons.check_circle : null,
        btnOkColor: btnOkColor,
        btnCancelColor: btnCancelColor,
        btnCancelOnPress: buttonCancelOnTap,
      ).show();
    }
  }
}
