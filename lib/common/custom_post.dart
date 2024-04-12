import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:volunteer_connection/common/custom_circle_avatar.dart';
import 'package:volunteer_connection/themes/app_styles.dart';

class CustomPost extends StatefulWidget {
  const CustomPost({
    super.key,
    required this.avatar,
    required this.userName,
    required this.time,
    required this.text,
    required this.address,
    required this.organization,
    required this.images,
    required this.width,
  });
  final String avatar;
  final String userName;
  final String time;
  final String text;
  final String address;
  final String organization;
  final List<String> images;
  final double width;

  @override
  State<CustomPost> createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customHeader(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.text,
                    style: AppStyles.h4
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.address,
                          style: AppStyles.h3,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.favorite_rounded,
                      color: Colors.orangeAccent,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.organization,
                          style: AppStyles.h3,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            width: widget.width,
            child: Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: Image.network(
                    "https://danviet.mediacdn.vn/2020/8/10/img8361-15970534817591653547950.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 44,
                    width: widget.width,
                    child: ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.format_align_justify_sharp,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Join Us",
                                      style: AppStyles.h3
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.message,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _customHeader() {
    return Row(
      children: [
        CustomCircleAvatar(size: 30, avatar: widget.avatar),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: AppStyles.h3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.time,
                style: AppStyles.h5.copyWith(color: Colors.black26),
              ),
            ],
          ),
        )
      ],
    );
  }
}
