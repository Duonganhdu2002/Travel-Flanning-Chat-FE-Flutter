// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/models/update_request_model.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class UserService {
  
  static Future<void> updateUser(
      LoginResponseModel? loginDetails,
      TextEditingController fullNameController,
      TextEditingController emailController,
      TextEditingController locationController,
      TextEditingController phoneController,
      BuildContext context) async {
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
      // Nếu _updateUser được gọi từ một Stateful Widget khác, bạn có thể truyền context vào hàm này từ hàm gọi.
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
}
