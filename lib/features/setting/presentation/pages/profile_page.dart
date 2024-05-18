import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volunteer_connection/common/custom_button_auth.dart';
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
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _placeOfOrigin = TextEditingController();
  late AuthProvider _auth;
  int index = -1;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers after the first frame to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _auth = Provider.of<AuthProvider>(context, listen: false);
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    setState(() {
      _userName.text = _auth.user.name;
      _email.text = _auth.user.email;
      _phone.text = _auth.user.phone;
      _placeOfOrigin.text = _auth.user.placeOfOrigin;
    });
  }

  Future<void> _updateUser() async {
    String result = await _auth.updateUser(
      _auth.user.id,
      _userName.text,
      _email.text,
      _phone.text,
      _placeOfOrigin.text,
    );

    if (result == "success") {
      // Update the controllers' text with the new values from the provider
      setState(() {
        _initializeControllers();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update thành công'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update Lỗi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: const AssetImage(AppAssets.user),
                backgroundColor: Colors.greenAccent[100],
              ),
              customTextFieldEdit(
                  controller: _userName, index: index, indexSelected: 0),
              customTextFieldEdit(
                  controller: _email, index: index, indexSelected: 1),
              customTextFieldEdit(
                  controller: _phone, index: index, indexSelected: 2),
              customTextFieldEdit(
                  controller: _placeOfOrigin, index: index, indexSelected: 3),
              const SizedBox(
                height: 80,
              ),
              CustomButtonAuth(
                width: width * 0.9,
                title: "Update",
                func: () async {
                  await _updateUser();
                },
              )
            ],
          ),
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
          this.index = indexSelected;
        });
      },
    );
  }

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _phone.dispose();
    _placeOfOrigin.dispose();
    super.dispose();
  }
}
