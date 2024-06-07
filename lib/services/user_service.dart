// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/models/update_request_model.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserService {
  static bool isImagePickerActive = false;

  static Future<void> updateUser(
      LoginResponseModel? loginDetails,
      TextEditingController fullNameController,
      TextEditingController emailController,
      TextEditingController locationController,
      TextEditingController phoneController,
      BuildContext context,
      [Uint8List? avatarImageData]) async {
    // Lấy thông tin mới từ các trường nhập liệu
    String newFullName = fullNameController.text;
    String newEmail = emailController.text;
    String newLocation = locationController.text;
    String newPhone = phoneController.text;

    String? newAvatarFileName;
    if (avatarImageData != null) {
      newAvatarFileName = await saveAvatar(avatarImageData, loginDetails!.id!);
    }

    // Tạo một đối tượng UpdateUserRequestModel mới
    UpdateUserRequestModel model = UpdateUserRequestModel(
      id: loginDetails?.id,
      fullname: newFullName,
      email: newEmail,
      location: newLocation,
      phone: newPhone,
      avatar: newAvatarFileName,
    );

    // Gửi yêu cầu cập nhật thông tin người dùng lên máy chủ
    bool updateSuccess = await AuthService.updateUser(model);

    if (updateSuccess) {
      // Tạo một đối tượng LoginResponseModel từ UpdateUserRequestModel
      LoginResponseModel loginModel = LoginResponseModel(
        id: loginDetails?.id,
        fullname: newFullName,
        email: newEmail,
        location: newLocation,
        phone: newPhone,
        avatar: newAvatarFileName,
      );

      // Gọi hàm updateUser để cập nhật dữ liệu trong cache
      await SharedService.updateUser(loginModel);

      // Gọi setState để rebuild giao diện với dữ liệu mới
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

  static Future<Uint8List?> pickCustomImage(
    ImageSource source,
    BuildContext context,
  ) async {
    if (isImagePickerActive) {
      return null;
    }

    isImagePickerActive = true;

    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: source);
      if (file != null) {
        return await file.readAsBytes();
      } else {
        debugPrint("No image selected!");
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      isImagePickerActive = false;
    }
  }

  static Future<String?> saveAvatar(Uint8List imageData, String userId) async {
    try {
      const url = '${Config.apiURL}api/user/uploadAvatar';
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['userId'] = userId;
      request.files.add(http.MultipartFile.fromBytes(
        'avatar',
        imageData,
        filename:
            'avatar_${userId}_${DateTime.now().millisecondsSinceEpoch}.png',
      ));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseBody);
        return responseData['avatar']; // Server trả về tên file
      } else {
        throw Exception('Failed to upload avatar');
      }
    } catch (e) {
      debugPrint('Error uploading avatar: $e'); // In ra lỗi nếu có
      return null;
    }
  }
}
