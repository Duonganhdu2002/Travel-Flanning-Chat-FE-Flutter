// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/models/update_request_model.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_app/ultils/app_bar.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  LoginResponseModel? loginDetails;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLoginDetails();
  }

  void _loadLoginDetails() async {
    loginDetails = await SharedService.loginDetails();
    fullNameController.text = loginDetails?.fullname ?? "";
    emailController.text = loginDetails?.email ?? "";
    locationController.text = loginDetails?.location ?? "";
    phoneController.text = loginDetails?.phone ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    locationController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _updateUser() async {
    // Lấy thông tin mới từ các trường nhập liệu
    String newFullName = fullNameController.text;
    String newEmail = emailController.text;
    String newLocation = locationController.text;
    String newPhone = phoneController.text;

    // Tạo một đối tượng UpdateUserRequestModel mới
    UpdateUserRequestModel model = UpdateUserRequestModel(
      id: loginDetails?.id,
      fullname: newFullName,
      email: newEmail,
      location: newLocation,
      phone: newPhone,
    );

    // Gửi yêu cầu cập nhật thông tin người dùng lên máy chủ
    bool updateSuccess = await APIService.updateUser(model);

    if (updateSuccess) {
      // Tạo một đối tượng LoginResponseModel từ UpdateUserRequestModel
      LoginResponseModel loginModel = LoginResponseModel(
        id: loginDetails?.id,
        fullname: newFullName,
        email: newEmail,
        location: newLocation,
        phone: newPhone,
      );

      // Gọi hàm updateUser để cập nhật dữ liệu trong cache
      await SharedService.updateUser(loginModel);

      // Gọi setState để rebuild giao diện với dữ liệu mới
      setState(() {});

      // Nếu cập nhật thành công, hiển thị thông báo hoặc thực hiện các hành động khác
      // Ví dụ: Hiển thị thông báo cập nhật thành công
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "User details updated successfully",
        "OK",
        () {
          Navigator.of(context).pop();
        },
      );
    } else {
      // Nếu cập nhật không thành công, hiển thị thông báo hoặc thực hiện các hành động khác
      // Ví dụ: Hiển thị thông báo cập nhật không thành công
      FormHelper.showSimpleAlertDialog(
        context,
        Config.appName,
        "Update fail",
        "OK",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: CustomBar(
        leftWidget: const BackIcon(),
        centerWidget1: const Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: InkWell(
          onTap: _updateUser,
          child: const Text(
            "Done",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.amber),
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
                  ClipOval(
                    child: Image.asset(
                      'lib/images/image1.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Leonardo",
                      style: TextStyle(
                          color: Color(0xFF1B1E28),
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Text(
                    "Change Profile Picture",
                    style: TextStyle(fontSize: 18, color: Colors.amber),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    customTextField(
                      "Full Name",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      fullNameController,
                      true,
                    ),
                    customTextField(
                      "Email",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      emailController,
                      true,
                    ),
                    customTextField(
                      "Location",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      locationController,
                      true,
                    ),
                    customTextField(
                      "Mobile Number",
                      const Color(0xFFF7F7F9),
                      true,
                      BorderSide.none,
                      BorderRadius.circular(14),
                      phoneController,
                      false,
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
      bool isCorrect) {
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
            suffixIcon: Icon(
              Icons.check,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
