import 'package:flutter/material.dart';
import 'package:flutter_app/components/back_icon.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/config.dart';
import 'package:flutter_app/models/place_model.dart';
import 'package:flutter_app/services/places_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class DetailsPage extends StatefulWidget {
  final String placeId;
  const DetailsPage({super.key, required this.placeId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  DetailPlaceModel? detailPlace;
  bool isLoading = true;
  String? selectedPhoto;

  @override
  void initState() {
    super.initState();
    fetchPlaceDetail();
  }

  void fetchPlaceDetail() async {
    try {
      DetailPlaceModel fetchedDetail =
          await PlaceService.getPlaceDetail(widget.placeId);
      setState(() {
        detailPlace = fetchedDetail;
        selectedPhoto = fetchedDetail.photos?.first;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching place detail: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const PageStorageKey<String>('detailPlace'),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          if (selectedPhoto != null)
            Image.network(
              '${Config.apiURL}public/images/places/${selectedPhoto!}',
              width: double.infinity,
              height: 720,
              fit: BoxFit.cover,
            ),
          Column(
            children: [
              const CustomBar(
                isTransparent: true,
                leftWidget: BackIcon(),
                centerWidget1: Text(
                  "Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                rightWidget: Text("               "),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(38),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detailPlace?.name ?? '',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color(0xFF1B1E28),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${detailPlace?.address?.street}, ${detailPlace?.address?.ward}, ${detailPlace?.address?.province}',
                                    style: const TextStyle(
                                      color: Color(0xFF7D848D),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipOval(
                              child: IconButton(
                                icon: ImageFiltered(
                                  imageFilter: const ColorFilter.mode(
                                    Color(0xFF7D848D),
                                    BlendMode.srcATop,
                                  ),
                                  child: SvgPicture.asset(
                                    "lib/images/fav_list.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ImageFiltered(
                                  imageFilter: const ColorFilter.mode(
                                      Color(0xFF7D848D), BlendMode.srcATop),
                                  child: SvgPicture.asset(
                                    "lib/images/Location.svg",
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  detailPlace?.address?.country ?? '',
                                  style: const TextStyle(
                                    color: Color(0xFF7D848D),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '4.7',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '(2498)',
                                  style: TextStyle(
                                    color: Color(0xFF7D848D),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Text(
                                  '\$59/',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Person',
                                  style: TextStyle(
                                    color: Color(0xFF7D848D),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (detailPlace?.photos != null)
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detailPlace!.photos!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedPhoto =
                                          detailPlace!.photos![index];
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.network(
                                      '${Config.apiURL}public/images/places/${detailPlace!.photos![index]}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About Destination',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFF1B1E28),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ReadMoreText(
                              detailPlace?.description ?? '',
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.deepOrangeAccent,
                              trimCollapsedText: "Read More",
                              trimExpandedText: "Show Less",
                              style: const TextStyle(
                                  color: Color(0xFF7D848D), fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'About Eating',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF1B1E28),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ReadMoreText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.deepOrangeAccent,
                              trimCollapsedText: "Read More",
                              trimExpandedText: "Show Less",
                            ),
                            const Text(
                              'About Playing',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF1B1E28),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ReadMoreText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.deepOrangeAccent,
                              trimCollapsedText: "Read More",
                              trimExpandedText: "Show Less",
                            ),
                            const Text(
                              'About Staying',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF1B1E28),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ReadMoreText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.deepOrangeAccent,
                              trimCollapsedText: "Read More",
                              trimExpandedText: "Show Less",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.yellow[600],
                              ),
                              child: const SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(
                                    child: Text("Make plan"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
