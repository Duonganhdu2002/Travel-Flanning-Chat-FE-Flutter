
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomBar(
        isTransparent: false,
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "Popular Places",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        rightWidget: Text("               "),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          children: [
             const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Text(
                  "All Popular Places",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold
                  ),
                 )
              ],
            ),   
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
      
        
    );
  }
}