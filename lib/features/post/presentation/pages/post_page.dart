import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:volunteer_connection/config/app_colors.dart';
import 'package:volunteer_connection/features/post/location_handler.dart';
import 'package:volunteer_connection/themes/app_colors.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:volunteer_connection/config/constanst_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String city = 'Quảng Trị';
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  @override
  void initState() {
    // _getCurrentPosition();
    super.initState();
  }

  void selectedImage() async {
    List<XFile> selectedImage = await imagePicker.pickMultiImage(
      imageQuality: 60, // Có thể điều chỉnh chất lượng ảnh
    );

    if (selectedImage != null &&
        (imageFileList.length + selectedImage.length) <= 5) {
      imageFileList.addAll(selectedImage);
    } else if (selectedImage != null &&
        (imageFileList.length + selectedImage.length) > 5) {
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

  Future<String?> getNameFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nameLocal');
  }

  Future<String?> fetchData() async {
    try {
      String? name = await getNameFromLocal();
      return name;
    } catch (e) {
      print('Error retrieving name from local storage: $e');
      return null; // Return null if there's an error
    }
  }

  /* URL ẢNH 
  - tất cả file ảnh được chọn sẽ lưu ở imageFileList
  - sau khi upload ảnh trả vể url thì bổ sung thêm ở dòng 113, thêm trường image chứa url của ảnh theo dạng sau 
  "images": [
        {
            "src": "https://example.com/image1.jpg",
            "width": 800,
            "height": 600
        },
        {
            "src": "https://example.com/image2.jpg",
            "width": 800,
            "height": 600
        }
    ]
  - tới dòng 169 thêm image để gọi hàm

  */
  Future<String> _handlePostCreation(
      String title, String location, List<String> description) async {
    // Dữ liệu cho post
    final Map<String, dynamic> postData = {
      'title': title,
      'location': location,
      'description': description,
    };
    final url1 = Uri.parse(ConstanstConfig.createPost);
    // final url2 = Uri.parse(ConstanstConfig.review1);

    try {
      // Gửi yêu cầu POST để tạo bài viết
      final response = await http.post(
        url1,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody['data']);
        final String postId = responseBody['data']['_id'];
        print(postId);

        // Gọi API để review post
        final reviewResponse = await http.put(
          Uri.parse('${ConstanstConfig.review}/$postId'),
        );

        if (reviewResponse.statusCode == 200) {
          print("ok api review");
          return "success";
          // Thành công
          // print('Đăng bài ok');
        } else {
          // Xử lý lỗi khi review post không thành công
          print('Review post failed: ${reviewResponse.statusCode}');
        }
      } else {
        // Xử lý lỗi khi tạo post không thành công
        print('Create post failed: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi khi có ngoại lệ
      print('Error: $e');
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            onTap: () async {
              // logData();
              // THÊM THAM SỐ IMAGE VÀO _handlePostCreation
              final result = await _handlePostCreation(
                  // "abc", addressController.text, [contentController.text]);
                  organizationController.text,
                  addressController.text,
                  [contentController.text]);
              print(result);
              if (result == "success") {
                // Dang bai thanh cong thi get thong tin show o newfeed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đăng bài thành công'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nội dung bài đăng không hợp lệ!'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
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
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            Form(
              child: TextFormField(
                controller: addressController,
                onChanged: (value) {},
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                    ),
                    hintText: "Vị trí của bạn",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2)),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Position? currentPosition =
                          await LocationHandler.getCurrentPosition();
                      String? currentAddress =
                          await LocationHandler.getAddressFromLatLng(
                              currentPosition!);
                      setState(() {
                        addressController.text =
                            currentAddress ?? "Unknown Address";
                      });
                      // setState(() {});
                      // print(currentPosition);
                      print(currentAddress);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/cursor_arrow.svg",
                      height: 16,
                    ),
                    label: const Text("Sử dụng vị trí hiện tại"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey_F4F7FA,
                      foregroundColor: AppColors.black_33383C,
                      elevation: 0,
                      fixedSize: const Size(double.maxFinite, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //
            FutureBuilder<String?>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is loading
                  return const CircularProgressIndicator(); // or any other loading indicator
                } else if (snapshot.hasError) {
                  // If there's an error in retrieving data
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If the data is successfully retrieved
                  final data = snapshot.data;
                  organizationController =
                      TextEditingController(text: data ?? "");
                  return SizedBox(
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
                        fillColor: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 4,
              thickness: 4,
              color: Appcolors.backgruondSecondColor,
            ),
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
