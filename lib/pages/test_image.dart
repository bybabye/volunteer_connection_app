import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:volunteer_connection/config/constanst_config.dart';

class TestImage extends StatefulWidget {
  const TestImage({super.key});

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadImage(File image) async {
    final mimeType = lookupMimeType(image.path);
    final fileName = path.basename(image.path);

    FormData formData = FormData.fromMap({
      "images": await MultipartFile.fromFile(image.path,
          filename: fileName, contentType: MediaType.parse(mimeType!)),
    });
    print('${ConstanstConfig.postImage}663f787460939b6ce9652bbe');
    try {
      Response response = await _dio.post(
          '${ConstanstConfig.postImage}663f787460939b6ce9652bbe',
          data: formData);
      if (response.statusCode == 200) {
        print('Image uploaded successfully $response');
      } else {
        print('Image upload failed');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  _uploadImage(_image!);
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
