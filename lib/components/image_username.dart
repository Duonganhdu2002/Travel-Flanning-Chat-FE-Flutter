import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/services/shared_service.dart';

class ImageUsername extends StatefulWidget {
  const ImageUsername({super.key});

  @override
  State<ImageUsername> createState() => _ImageUsernameState();
}

class _ImageUsernameState extends State<ImageUsername> {
  LoginResponseModel? loginDetails;

  @override
  void initState() {
    super.initState();
    _loadLoginDetails();
  }

  void _loadLoginDetails() async {
    final details = await SharedService.loginDetails();
    setState(() {
      loginDetails = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: const Color(0xFFF7F7F9),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          children: [
            if (loginDetails?.avatar != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.network(
                    '${Config.apiURL}public/images/avatars/${loginDetails!.avatar}',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Text('Hi ${loginDetails?.username ?? 'Loading...'}'),
          ],
        ),
      ),
    );
  }
}
