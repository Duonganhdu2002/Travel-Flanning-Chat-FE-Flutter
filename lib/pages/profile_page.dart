import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle:
            true, // Đặt thuộc tính centerTitle thành true để căn giữa tiêu đề
        title: Text('Profile'), // Tiêu đề của AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Icons.edit), // Icon cho nút sửa thông tin
              onPressed: () {
                // Xử lý khi nút được nhấn
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: AssetImage('lib/images/dinosaur.png'),
                    ),
                  )),
              const SizedBox(height: 10),
              Text(
                'Tên người dùng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Email',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Để căn giữa các cột
                children: [
                  Expanded(
                    flex: 1, // Tỷ lệ flex cho cột đầu tiên
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reward Point',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '360',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1, // Độ rộng của đường dọc
                    color: Colors.grey, // Màu sắc của đường dọc
                  ),
                  Expanded(
                    flex: 1, // Tỷ lệ flex cho cột đầu tiên
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Travel Trips',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '238',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 1, // Độ rộng của đường dọc
                    color: Colors.grey, // Màu sắc của đường dọc
                  ),
                  Expanded(
                    flex: 1, // Tỷ lệ flex cho cột đầu tiên
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bucket List',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '473',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //Menu
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('lib/images/user.png'),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Profile',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Xử lý khi nút được nhấn để điều hướng sang trang khác
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('lib/images/bookmark-white.png'),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Bookmarked',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Xử lý khi nút được nhấn để điều hướng sang trang khác
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('lib/images/airplane.png'),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Previous Trips',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Xử lý khi nút được nhấn để điều hướng sang trang khác
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('lib/images/settings.png'),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Settings',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Xử lý khi nút được nhấn để điều hướng sang trang khác
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              AssetImage('lib/images/merge.png'),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Version',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: () {
                            // Xử lý khi nút được nhấn để điều hướng sang trang khác
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
