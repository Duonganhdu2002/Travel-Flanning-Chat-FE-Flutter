import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/ultils/app_bar.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomBar(
        leftWidget: BackIcon(),
      ),
      body: Text("ahsdhaj"),
    );
  }
}
