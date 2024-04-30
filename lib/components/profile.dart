import 'package:flutter/material.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

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
                  const SizedBox(
                    height: 10,
                  ),
                  ClipOval(
                    child: Image.asset(
                      'lib/images/image1.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Leonardo",
                      style: TextStyle(
                          color: Color(0xFF1B1E28),
                          fontSize: 28,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Text(
                    "Leonardo@gmail.com",
                    style: TextStyle(color: Color(0xFF7D848D), fontSize: 17),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
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
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFF7F7F9),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // Điều chỉnh vị trí của bóng
                                )
                              ]),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
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
                      const SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
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
              const Column(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
