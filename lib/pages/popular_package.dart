import 'package:flutter/material.dart';

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
        title: const Text('Popular Package'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12.0, top: 20),
              child: Text(
                'All Popular Trip Package',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30), // Khoảng cách giữa tiêu đề và các hàng
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: SizedBox(
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
                          const Expanded(
                            flex: 1, // Tỷ lệ flex cho cột đầu tiên
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: ClipRRect(
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/dinosaur.png'),
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
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
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
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .yellow, // Màu sắc nền của khung bo
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
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
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          // Xử lý khi nút được nhấn
                                        },
                                      ),
                                      const Text('16 July-28 July')
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ ba
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
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: SizedBox(
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
                          const Expanded(
                            flex: 1, // Tỷ lệ flex cho cột đầu tiên
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: ClipRRect(
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/dinosaur.png'),
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
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
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
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .yellow, // Màu sắc nền của khung bo
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
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
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons
                                              .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          // Xử lý khi nút được nhấn
                                        },
                                      ),
                                      const Text('16 July-28 July')
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ ba
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
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: SizedBox(
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
                          const Expanded(
                            flex: 1, // Tỷ lệ flex cho cột đầu tiên
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: ClipRRect(
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/dinosaur.png'),
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
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
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
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .yellow, // Màu sắc nền của khung bo
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
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
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons
                                              .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          // Xử lý khi nút được nhấn
                                        },
                                      ),
                                      const Text('16 July-28 July')
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ ba
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
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: SizedBox(
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
                          const Expanded(
                            flex: 1, // Tỷ lệ flex cho cột đầu tiên
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  child: ClipRRect(
                                    child: Image(
                                      image:
                                          AssetImage('lib/images/dinosaur.png'),
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
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Flexible(
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
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .yellow, // Màu sắc nền của khung bo
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
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
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons
                                              .calendar_today, // Chọn biểu tượng từ thư viện biểu tượng của Flutter
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          // Xử lý khi nút được nhấn
                                        },
                                      ),
                                      const Text('16 July-28 July')
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ ba
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
                                const Expanded(
                                  flex: 1, // Tỷ lệ flex cho hàng thứ tư
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
          ],
        ),
      ),
    );
  }
}
