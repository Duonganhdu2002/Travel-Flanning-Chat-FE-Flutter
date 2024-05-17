import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/create_group.dart';
import 'package:flutter_app/components/search_input.dart';
import 'package:flutter_app/pages/details_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateMessage extends StatelessWidget {
  const CreateMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomBar(
        leftWidget: BackIcon(),
        centerWidget1: Text(
          "New Messsages",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: Text("           "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchInput(),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateGroup()),
                );
              },
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Stack(
                      children: [
                        IconButton(
                          icon: ImageFiltered(
                            imageFilter: const ColorFilter.mode(
                                Colors.black12, BlendMode.srcATop),
                            child: SvgPicture.asset(
                              "lib/images/UserGroup.svg",
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Create a group chat",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 200,
                  ),
                  SvgPicture.asset(
                    "lib/images/RightArrow.svg",
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Suggested",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView(
                children: [
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemMessage(
                    context,
                    "lib/images/User_img.png",
                    "Tom Liebt Dich",
                  ),
                  itemGroupMessage(
                      context,
                      "lib/images/User_img.png",
                      "lib/images/User_img.png",
                      "Group name",
                      "Nanh, Wyd Anh Du, Tom")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemMessage(
    BuildContext context,
    String pathImage,
    String nameUser,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Image.asset(
                      pathImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              nameUser,
                              style: const TextStyle(
                                  color: Color(0xFF1B1E28),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const ImageFiltered(
                              imageFilter: ColorFilter.mode(
                                Color(0xFF7D848D),
                                BlendMode.srcATop,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemGroupMessage(
    BuildContext context,
    String userImage,
    String friendImage,
    String groupName,
    String membersName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Stack(children: [
                      Positioned(
                        child: SizedBox(
                          width: 55,
                          child: Image.asset(
                            userImage,
                            width: 55,
                            height: 55,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: SizedBox(
                          width: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white70),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              friendImage,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              groupName,
                              style: const TextStyle(
                                  color: Color(0xFF1B1E28),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const ImageFiltered(
                              imageFilter: ColorFilter.mode(
                                Color(0xFF7D848D),
                                BlendMode.srcATop,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          membersName,
                          style: const TextStyle(color: Color(0xFF7D848D)),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    "lib/images/RightArrow.svg",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
