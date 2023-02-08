import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File) onPick;

  const UserImagePicker({Key? key, required this.onPick}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150
    );
    if (pickedImage == null) {
      return;
    }

    final pickedImageFile = File(pickedImage.path);
    setState(() => _pickedImage = pickedImageFile);

    widget.onPick(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    final pickedImage = _pickedImage;

    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage == null ? null : FileImage(pickedImage),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add image'),
        ),
      ],
    );
  }
}
