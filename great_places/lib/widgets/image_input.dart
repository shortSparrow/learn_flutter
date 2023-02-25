// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as system_path;

class ImageInput extends StatefulWidget {
  final void Function(File) onSelectImage;

  const ImageInput({super.key, required this.onSelectImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storeImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile != null) {
      setState(() {
        _storeImage = File(imageFile.path);
      });

      final appDirectory = await system_path.getApplicationDocumentsDirectory();

      final fileName = path.basename(imageFile.path);
      final savedImage =
          await _storeImage?.copy('${appDirectory.path}/$fileName');

      widget.onSelectImage(savedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storeImage != null
              ? Image.file(
                  _storeImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: OutlinedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture"),
            ),
          ),
        ),
      ],
    );
  }
}
