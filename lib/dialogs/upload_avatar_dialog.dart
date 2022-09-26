import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectnwork/constants.dart';
import 'package:connectnwork/repos/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showUploadAvatarDialog() async {
  ImagePicker picker = ImagePicker();
  late XFile? image;

  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () async {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                image = await picker.pickImage(
                  source: ImageSource.camera,
                );

                File imageFile = File(image!.path);
                Uint8List imagebytes = await imageFile.readAsBytes();
                String base64string = base64.encode(imagebytes);

                UserRepository.update(picture: base64string);

                myProfile = await UserRepository.get();

                navigatorKey.currentState!.pop();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () async {
                navigatorKey.currentState!.pop();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  File imageFile = File(image!.path);
                  Uint8List imagebytes = await imageFile.readAsBytes();
                  String base64string = base64.encode(imagebytes);

                  UserRepository.update(picture: base64string);

                  myProfile = await UserRepository.get();
                }

                navigatorKey.currentState!.pop();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () {
              navigatorKey.currentState!.pop();
            },
          ),
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                image = await picker.pickImage(
                  source: ImageSource.camera,
                );

                File imageFile = File(image!.path);
                Uint8List imagebytes = await imageFile.readAsBytes();
                String base64string = base64.encode(imagebytes);

                UserRepository.update(picture: base64string);

                myProfile = await UserRepository.get();

                navigatorKey.currentState!.pop();
              },
            ),
            ListTile(
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                File imageFile = File(image!.path);
                Uint8List imagebytes = await imageFile.readAsBytes();
                String base64string = base64.encode(imagebytes);

                UserRepository.update(picture: base64string);

                myProfile = await UserRepository.get();

                navigatorKey.currentState!.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
