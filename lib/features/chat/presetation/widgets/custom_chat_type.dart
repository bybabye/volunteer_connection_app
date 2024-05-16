import 'package:flutter/material.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomChatType extends StatefulWidget {
  const CustomChatType({Key? key}) : super(key: key);

  @override
  State<CustomChatType> createState() => _CustomChatTypeState();
}

class _CustomChatTypeState extends State<CustomChatType>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double width;

  bool _isSliding = false;
  bool _isForward = true;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Thời gian của animation
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(
            () {}); // Gọi setState để cập nhật giao diện khi animation thay đổi
      });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width * 0.7;

    return Stack(
      children: [
        // Container A
        GestureDetector(
          onTapUp: (details) {
            _toggleSlide(); // Bắt đầu hoặc đảo ngược animation của container B
          },
          child: Container(
            width: width,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000), // Màu đen với độ trong suốt 25%
                  offset: Offset(4, 4), // Độ lệch theo trục x và y
                  blurRadius: 20, // Độ mờ
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Group",
                  style: AppStyles.h3.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Private",
                  style: AppStyles.h3.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        // Container B
        Positioned(
          left: _animation.value *
              width /
              2, // Điều chỉnh vị trí của container B dựa trên giá trị của animation
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: width / 2,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: _animation.value * width / 2 >= 98.1
                  ? Center(
                      child: Text("Private",
                          style: AppStyles.h3
                              .copyWith(fontWeight: FontWeight.w500)))
                  : Center(
                      child: Text("Group",
                          style: AppStyles.h3
                              .copyWith(fontWeight: FontWeight.w500))),
            ),
          ),
        ),
      ],
    );
  }

  // Hàm để bắt đầu hoặc đảo ngược animation của container B
  void _toggleSlide() {
    if (_isSliding) {
      _controller
          .reverse(); // Đảo ngược animation nếu container B đang trong quá trình di chuyển
    } else {
      _controller
          .forward(); // Bắt đầu animation nếu container B đang không di chuyển
    }
    _isSliding = !_isSliding; // Đảo ngược trạng thái của container B
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
