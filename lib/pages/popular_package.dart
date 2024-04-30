import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PopularPackagePage extends StatefulWidget {
  const PopularPackagePage({super.key});

  @override
  State<PopularPackagePage> createState() => _PopularPackagePageState();
}

class _PopularPackagePageState extends State<PopularPackagePage> {
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
        title: Text('Popular Package'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text(
                'All Popular Trip Package',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30), // Khoảng cách giữa tiêu đề và các hàng
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: Container(
                      height: 140,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Bo góc cho Card
                          side: BorderSide(
                              color: Colors.grey[300]!), // Màu sắc của viền
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1, // Tỷ lệ flex cho cột đầu tiên
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: ClipRRect(
                                      child: Image(
                                        image: AssetImage(
                                            'lib/images/dinosaur.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2, // Tỷ lệ flex cho cột thứ hai
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ nhất
                                    child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            //để xuống dòng
                                            child: Text(
                                              'Place',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow, // Màu sắc nền của khung bo
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '100',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ hai
                                    child: Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // Xử lý khi nút được nhấn
                                            },
                                          ),
                                          Text('16 July-28 July')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ ba
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/star.png'),
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '4.8',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '24 Person Joined',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: Container(
                      height: 140,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Bo góc cho Card
                          side: BorderSide(
                              color: Colors.grey[300]!), // Màu sắc của viền
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1, // Tỷ lệ flex cho cột đầu tiên
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: ClipRRect(
                                      child: Image(
                                        image: AssetImage(
                                            'lib/images/dinosaur.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2, // Tỷ lệ flex cho cột thứ hai
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ nhất
                                    child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            //để xuống dòng
                                            child: Text(
                                              'Place',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow, // Màu sắc nền của khung bo
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '100',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ hai
                                    child: Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons
                                                  .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // Xử lý khi nút được nhấn
                                            },
                                          ),
                                          Text('16 July-28 July')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ ba
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/star.png'),
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '4.8',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '24 Person Joined',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: Container(
                      height: 140,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Bo góc cho Card
                          side: BorderSide(
                              color: Colors.grey[300]!), // Màu sắc của viền
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1, // Tỷ lệ flex cho cột đầu tiên
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: ClipRRect(
                                      child: Image(
                                        image: AssetImage(
                                            'lib/images/dinosaur.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2, // Tỷ lệ flex cho cột thứ hai
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ nhất
                                    child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            //để xuống dòng
                                            child: Text(
                                              'Place',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow, // Màu sắc nền của khung bo
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '100',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ hai
                                    child: Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons
                                                  .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // Xử lý khi nút được nhấn
                                            },
                                          ),
                                          Text('16 July-28 July')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ ba
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/star.png'),
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '4.8',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '24 Person Joined',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Xử lý khi nút được nhấn
                    },
                    child: Container(
                      height: 140,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // Bo góc cho Card
                          side: BorderSide(
                              color: Colors.grey[300]!), // Màu sắc của viền
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1, // Tỷ lệ flex cho cột đầu tiên
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: ClipRRect(
                                      child: Image(
                                        image: AssetImage(
                                            'lib/images/dinosaur.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2, // Tỷ lệ flex cho cột thứ hai
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ nhất
                                    child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            //để xuống dòng
                                            child: Text(
                                              'Place',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            decoration: BoxDecoration(
                                              color: Colors
                                                  .yellow, // Màu sắc nền của khung bo
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '100',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ hai
                                    child: Container(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons
                                                  .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              // Xử lý khi nút được nhấn
                                            },
                                          ),
                                          Text('16 July-28 July')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ ba
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/star.png'),
                                                height: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '4.8',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: ClipRRect(
                                              child: Image(
                                                image: AssetImage(
                                                    'lib/images/dinosaur.png'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '24 Person Joined',
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
