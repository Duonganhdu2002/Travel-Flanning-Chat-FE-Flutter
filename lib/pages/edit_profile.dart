import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/config.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with AutomaticKeepAliveClientMixin<EditProfile> {
  Uint8List? imagePicker;
  LoginResponseModel? loginDetails;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    _loadLoginDetails();
    _addListeners();
  }

  void _loadLoginDetails() async {
    loginDetails = await SharedService.loginDetails();
    fullNameController.text = loginDetails?.fullname ?? "";
    emailController.text = loginDetails?.email ?? "";
    locationController.text = loginDetails?.location ?? "";
    phoneController.text = loginDetails?.phone ?? "";
    _validateForm();
    setState(() {});
  }

  void _addListeners() {
    fullNameController.addListener(_validateForm);
    emailController.addListener(_validateForm);
    locationController.addListener(_validateForm);
    phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    locationController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _updateUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      await UserService.updateUser(
        loginDetails,
        fullNameController,
        emailController,
        locationController,
        phoneController,
        context,
        imagePicker,
      );
      _loadLoginDetails();
    }
  }

  void _selectImage(BuildContext context) async {
    Uint8List? img =
        await UserService.pickCustomImage(ImageSource.gallery, context);
    if (img != null) {
      setState(() {
        imagePicker = img;
      });
      final newAvatarFileName =
          await UserService.saveAvatar(img, loginDetails!.id!);
      if (newAvatarFileName != null) {
        setState(() {
          loginDetails!.avatar =
              newAvatarFileName; // Cập nhật tên tệp ảnh đại diện
        });
      } else {
        // Xử lý trường hợp không tải lên ảnh được
        debugPrint("Failed to upload avatar");
      }
    } else {
      // Xử lý trường hợp không chọn được ảnh
      debugPrint("No image selected");
    }
  }

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String? avatar = loginDetails?.avatar;
    String? fullname = loginDetails?.fullname;
    return Scaffold(
      key: const PageStorageKey<String>('editProfile'),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: CustomBar(
        leftWidget: const BackIcon(),
        centerWidget1: const Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: InkWell(
          onTap: isFormValid ? () => _updateUser(context) : null,
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isFormValid ? Colors.amber : Colors.grey,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  if (imagePicker != null)
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(imagePicker!),
                      ),
                    )
                  else if (avatar != null)
                    ClipOval(
                      child: Image.network(
                        "${Config.apiURL}public/images/avatars/$avatar",
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    ClipOval(
                      child: Image.asset(
                        'lib/images/User_img.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      fullname ?? '',
                      style: const TextStyle(
                          color: Color(0xFF1B1E28),
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectImage(context),
                    child: const Text(
                      "Change Profile Picture",
                      style: TextStyle(fontSize: 18, color: Colors.amber),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    customTextField(
                      "Full Name",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      fullNameController,
                      (value) =>
                          value.isNotEmpty &&
                          RegExp(r"^[a-zA-Z\s]+$").hasMatch(value),
                    ),
                    customTextField(
                      "Email",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      emailController,
                      (value) =>
                          value.isNotEmpty &&
                          RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$").hasMatch(value),
                    ),
                    customTextField(
                      "Location",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      locationController,
                      (value) => value.isNotEmpty,
                    ),
                    customTextField(
                      "Mobile Number",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      phoneController,
                      (value) =>
                          value.isNotEmpty &&
                          RegExp(r"^[0-9]{10}$").hasMatch(value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customTextField(
    String lable,
    Color color,
    bool filled,
    BorderSide borderSide,
    BorderRadius borderRadius,
    TextEditingController controller,
    bool Function(String) validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            lable,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: filled,
            fillColor: color,
            border: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: borderRadius,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? Icon(
                    Icons.check,
                    color:
                        validator(controller.text) ? Colors.green : Colors.red,
                  )
                : null,
          ),
          validator: (value) {
            if (!validator(value ?? '')) {
              return 'Invalid $lable';
            }
            return null;
          },
          onChanged: (value) {
            setState(
                () {}); // This will re-render the widget to show/hide the check icon
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
