import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/common/custom_button_auth.dart';
import 'package:volunteer_connection/common/custom_circle_avatar.dart';
import 'package:volunteer_connection/common/custom_textfield_edit.dart';
import 'package:volunteer_connection/features/auth/presentation/providers/auth_provider.dart';

import '../../../../themes/app_assets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double height;
  late double width;
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _placeOfOrigin = TextEditingController();
  late AuthProvider _auth;
  int index = -1;
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<AuthProvider>(context, listen: false);
    _userName.text = _auth.user.name;
    _email.text = _auth.user.email;
    _dateOfBirth.text = _auth.user.blood;
    _placeOfOrigin.text = _auth.user.roles;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: const AssetImage(
                AppAssets.user,
              ),
              backgroundColor: Colors.greenAccent[100],
            ),
            customTextFieldEdit(
                controller: _userName, index: index, indexSelected: 0),
            customTextFieldEdit(
                controller: _email, index: index, indexSelected: 1),
            customTextFieldEdit(
                controller: _dateOfBirth, index: index, indexSelected: 2),
            customTextFieldEdit(
                controller: _placeOfOrigin, index: index, indexSelected: 3),
            const SizedBox(),
            CustomButtonAuth(
              width: width * 0.9,
              title: "Update",
              func: () => {},
            )
          ],
        ),
      ),
    );
  }

  Widget customTextFieldEdit(
      {required TextEditingController controller,
      required int index,
      required int indexSelected}) {
    return CustomTextField(
      controller: controller,
      index: index,
      indexSelected: indexSelected,
      onTap: () {
        setState(() {
          index = indexSelected;
        });
      },
    );
  }
}
