import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  @override
  void initState() {
    super.initState();
  }

  // Select image v1
  // void selectedImage() async {
  //   List<XFile> selectedImage = await imagePicker.pickMultiImage(
  //     imageQuality: 60, // Có thể điều chỉnh chất lượng ảnh
  //   );
  //   if (imageFileList != null && imageFileList.length <= 5) {
  //     imageFileList.addAll(selectedImage);
  //   } else if (imageFileList != null && imageFileList.length > 5) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         backgroundColor: Colors.blue,
  //         content: Text('Chọn tối đa 5 ảnh !'),
  //       ),
  //     );
  //   }
  //   setState(() {});
  // }

  // Select image v2
  void selectedImage() async {
    List<XFile> selectedImage = await imagePicker.pickMultiImage(
      imageQuality: 60, // Có thể điều chỉnh chất lượng ảnh
    );
    if ((imageFileList.length + selectedImage.length) <= 5) {
      imageFileList.addAll(selectedImage);
    } else if ((imageFileList.length + selectedImage.length) > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Chọn tối đa 5 ảnh !'),
        ),
      );
    }
    setState(() {});
  }

  void deleteImage(int index) {
    setState(() {
      imageFileList.removeAt(index);
    });
  }

  void logData() {
    print('Nội dung bài viết: ${contentController.text}');
    print('Tổ chức: ${organizationController.text}');
    // print('Địa chỉ : ${city}');
    print('path ảnh gồm :');
    print('----------------------------------------');
    imageFileList.forEach((element) {
      print(element.path);
    });
    print('----------------------------------------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            onTap: () {
              logData();
            },
            child: const Text(
              'Đăng bài',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Noi dung post
            TextField(
              controller: contentController,
              autocorrect: false,
              enableSuggestions: false,
              maxLines: 7,
              decoration: InputDecoration(
                  hintText: "Hãy viết cái gì đó ...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2)),
            ),
            const SizedBox(
              height: 20,
            ),
            // GET LOCATION
            const SizedBox(
              height: 20,
            ),
            // Ten to chuc thien nguyen
            SizedBox(
              height: 50,
              child: TextField(
                controller: organizationController,
                autocorrect: false,
                enableSuggestions: false,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.handshake,
                      color: Colors.orange,
                    ),
                    hintText: "Tổ chức thiện nguyện Đà Nẵng",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Image of post
            SizedBox(
              height: 300,
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: imageFileList.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 6,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == imageFileList.length) {
                      return imageFileList.length < 5
                          ? GestureDetector(
                              onTap: selectedImage,
                              child: Container(
                                height: 80,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: const DashedBorder.fromBorderSide(
                                    dashLength: 10,
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                            )
                          : const SizedBox();
                    }
                    return Stack(
                      children: [
                        SizedBox(
                          height: 220,
                          width: 130,
                          child: Image.file(
                            File(imageFileList[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                            right: 5,
                            top: 5,
                            child: GestureDetector(
                              onTap: () {
                                deleteImage(index);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.close,
                                    size: 15,
                                    color: Colors.red,
                                  )),
                            ))
                      ],
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
