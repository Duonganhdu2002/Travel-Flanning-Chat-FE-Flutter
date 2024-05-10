import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';

class PopularPlacesPage extends StatefulWidget {
  const PopularPlacesPage({super.key});

  @override
  State<PopularPlacesPage> createState() => _PopularPlacesPageState();
}

class _PopularPlacesPageState extends State<PopularPlacesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomBar(
        isTransparent: false,
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "Popular Places",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        rightWidget: Text("               "),
      ),
      
      
    );
  }
}