import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:flutter/cupertino.dart';

class ImageChooserDialog {
  showImageChooserDialog({
    required VoidCallback takePhotoCallback,
    required VoidCallback selectPhotoCallback,
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: takePhotoCallback,
            child: BaseText(
              text: 'Take Photo',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: selectPhotoCallback,
            child: BaseText(
              text: 'Gallery',
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: BaseText(
            text: 'Cancel',
            fontSize: 18,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
