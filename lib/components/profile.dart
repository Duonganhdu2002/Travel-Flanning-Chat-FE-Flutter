import 'package:flutter/material.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/login_response_model.dart';
import 'package:flutter_app/pages/edit_profile.dart';
import 'package:flutter_app/services/shared_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
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

  void changeWidgets(BuildContext context, Widget newWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newWidget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      loginDetails?.avatar != null
                          ? '${Config.apiURL}public/images/avatars/${loginDetails?.avatar}'
                          : '${Config.apiURL}public/images/avatars/User_img.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      loginDetails?.username ?? "Loading...",
                      style: const TextStyle(
                          color: Color(0xFF1B1E28),
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    loginDetails?.email ?? "Loading..",
                    style:
                        const TextStyle(color: Color(0xFF7D848D), fontSize: 17),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Reward Points",
                                    style: TextStyle(
                                        color: Color(0xFF1B1E28),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "360",
                                  style: TextStyle(
                                      color: Color(0xFFFFD521),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Travel Trips",
                                    style: TextStyle(
                                        color: Color(0xFF1B1E28),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "238",
                                  style: TextStyle(
                                      color: Color(0xFFFFD521),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Bucket List",
                                    style: TextStyle(
                                        color: Color(0xFF1B1E28),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "473",
                                  style: TextStyle(
                                      color: Color(0xFFFFD521),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          itemColumnList(
                            "lib/images/User.svg",
                            "Profile",
                            () {
                              changeWidgets(context, const EditProfile());
                            },
                          ),
                          itemColumnList(
                            "lib/images/fav_list.svg",
                            "Bookmarked",
                            () {
                              // Xử lý hành động khi hình ảnh được nhấn vào
                            },
                          ),
                          itemColumnList(
                            "lib/images/plane.svg",
                            "Previous Trips",
                            () {
                              // Xử lý hành động khi hình ảnh được nhấn vào
                            },
                          ),
                          itemColumnList(
                            "lib/images/setting.svg",
                            "Settings",
                            () {
                              // Xử lý hành động khi hình ảnh được nhấn vào
                            },
                          ),
                          itemColumnList(
                            "lib/images/world.svg",
                            "Version",
                            () {
                              // Xử lý hành động khi hình ảnh được nhấn vào
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemColumnList(String iconName, String itemName, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: ImageFiltered(
                        imageFilter: const ColorFilter.mode(
                            Color(0xFF7D848D), BlendMode.srcATop),
                        child: SvgPicture.asset(
                          iconName,
                          width: 28,
                          height: 28,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(itemName),
                  ],
                ),
                ImageFiltered(
                  imageFilter: const ColorFilter.mode(
                      Color(0xFF7D848D), BlendMode.srcATop),
                  child: SvgPicture.asset(
                    "lib/images/next.svg",
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[100]),
            ),
          ),
        ],
      ),
    );
  }
}
