import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            IconButton(
              icon: ImageFiltered(
                imageFilter:
                    const ColorFilter.mode(Colors.black87, BlendMode.srcATop),
                child: SvgPicture.asset(
                  "lib/images/direction_left.svg",
                  width: 24,
                  height: 24,
                ),
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  // Trang hiện tại là trang gốc, không thực hiện pop
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
