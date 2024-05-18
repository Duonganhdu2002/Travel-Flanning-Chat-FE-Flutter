import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchUsername extends StatelessWidget {
  const SearchUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search friends name',
                        hintStyle: TextStyle(
                            color: Color(0xFF7D848D),
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFD521),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              children: [
                IconButton(
                  icon: ImageFiltered(
                    imageFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcATop),
                    child: SvgPicture.asset(
                      "lib/images/RightArrow.svg",
                      width: 24,
                      height: 24,
                    ),
                  ), onPressed: () {  },
                )
              ],
            ),
          )
        ],
      ),
    ]);
  }
}
