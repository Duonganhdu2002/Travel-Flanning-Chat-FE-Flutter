import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeComponent extends StatelessWidget {
  const HomeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(50, (index) => 'Item $index');

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Explore the ",
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Beautiful ",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "world!",
                      style: TextStyle(
                        fontSize: 50,
                        color: Color(0xFFFF7029),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Image.asset(
                      'lib/images/text_under.png',
                      width: 120,
                      fit: BoxFit.contain,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Best Destination",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    margin: const EdgeInsets.only(right: 25.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "lib/images/image1.png",
                                  width: double.infinity,
                                  height: 380,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Niladri Reservoir",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    " 4.7",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "lib/images/Location.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                  const Text(
                                    " Tekergat, Sunamgnj",
                                    style: TextStyle(
                                        color: Color(
                                          0xFF7D848D,
                                        ),
                                        fontSize: 18),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
