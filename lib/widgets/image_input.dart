import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.pickImage});

  final void Function(File) pickImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedPicture;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage == null) return;

    setState(() {
      _selectedPicture = File(pickedImage.path);
    });

    widget.pickImage(_selectedPicture!);
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = _selectedPicture == null
        ? TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take a picture'),
          )
        : GestureDetector(
            onTap: _takePicture,
            child: Image.file(
              _selectedPicture!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
